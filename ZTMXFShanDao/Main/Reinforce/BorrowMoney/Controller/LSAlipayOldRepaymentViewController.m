//
//  LSAlipayOldRepaymentViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSAlipayOldRepaymentViewController.h"
#import "ReflectionLabel.h"
#import "UIView+Administer.h"
#import "UploadSingleImageService.h"
#import "ImageCompressHelper.h"
#import "LSUploadPayOldApi.h"
#import "LSPaySuccessViewController.h"
#import "LSPayFailureViewController.h"
#import "TZImagePickerController.h"
#import "LSAlipayProofViewController.h"
#import "ALAIntroduction.h"
#import "HWTitleButton.h"
#import "UIImage+addition.h"
#import "ZTMXFCourseView.h"

@interface LSAlipayOldRepaymentViewController () <TZImagePickerControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *uploadImageView;
@property (nonatomic, strong) UIButton *goRepaymentButton;
@property (nonatomic, strong) UIButton *grayUploadButton;
@property (nonatomic, strong) UIButton *redUploadButton;
@property (nonatomic, strong) UIButton *alipayRepaymentButton;

/** 1.4版本 */
@property (nonatomic, strong) UIScrollView *mainScrollView;

/** 支付宝还款账号 */
@property (nonatomic, copy) NSString *alipayAcount;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;

/** 是否上传凭证 */
@property (nonatomic, assign) BOOL uploadProof;

/** 1.5版本 */
@property (nonatomic, strong) UIView *uploadSuccessView;

@end

@implementation LSAlipayOldRepaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付宝还款";
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    self.alipayAcount = kAlipayRepaymentAccount;
    
    [self configueSubViews];
    [self setNavgationBarRightTitle:@"还款帮助"];
    
    //  复制账号到剪切板
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.alipayAcount;
    
    self.selectedPhotos = [NSMutableArray array];
    self.selectedAssets = [NSMutableArray array];
    
    //  进入页面pv统计
    [self enterAlipayPageStatistics];
}

#pragma mark - 返回按钮操作
- (void)clickReturnBackEvent{
    if (!self.uploadProof) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"还没提交还款凭证, 确认离开?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *leave = [UIAlertAction actionWithTitle:@"先离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *continueUpload = [UIAlertAction actionWithTitle:@"继续上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:leave];
        [alertVC addAction:continueUpload];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 跳转到还款帮助
- (void)right_button_event:(UIButton *)sender{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(kRepayHelp);
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    //  是否选择原图
    imagePickerVc.isSelectOriginalPhoto = NO;
    // 在内部显示拍照按钮
    imagePickerVc.allowTakePicture = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    
    if (self.selectedPhotos.count > 0) {
        
        [self.mainScrollView addSubview:self.uploadSuccessView];
        self.uploadImageView.image = self.selectedPhotos[0];
        
        //        [self.goRepaymentButton setTitle:@"提 交" forState:UIControlStateNormal];
        //        [self.grayUploadButton setTitle:@"重新上传" forState:UIControlStateNormal];
    }
}

#pragma mark - 接口请求
- (void)uploadPayProof{
    if (self.selectedPhotos.count > 0) {
        NSData *imageData = [ImageCompressHelper returnDataCompressedImageToLimitSizeOfKB:200.0 image:self.selectedPhotos[0]];
        if (imageData) {
            NSArray * arrImg = @[imageData];
            NSArray * arrFileName = @[@"proof.jpg"];
            [SVProgressHUD showLoading];
            UploadSingleImageService * uploadImageApi = [[UploadSingleImageService alloc]initWithImageDatas:arrImg andUploadType:UploadSingleTypeFile andFileName:arrFileName];
            [uploadImageApi requestWithSuccess:^(NSDictionary *responseDict) {
                NSString * codeStr = [responseDict[@"code"]description];
                if ([codeStr isEqualToString:@"1000"]) {
                    NSArray *urlArray = responseDict[@"data"][@"list"];
                    if (urlArray.count > 0) {
                        NSDictionary *urlDict = urlArray[0];
                        NSString *proofUrl = [urlDict[@"url"] description];
                        if (proofUrl.length > 4) {
                            [self submitAlipayProofWithUrl:proofUrl];
                        } else {
                            [SVProgressHUD dismiss];
                        }
                    } else {
                        [SVProgressHUD dismiss];
                    }
                } else {
                    [SVProgressHUD dismiss];
                }
            } failure:^(__kindof YTKBaseRequest *request) {
                [SVProgressHUD dismiss];
            }];
        }
    } else {
        [self pushTZImagePickerController];
    }
}

- (void)submitAlipayProofWithUrl:(NSString *)proofUrl{
    LSUploadPayOldApi * payProofApi = [[LSUploadPayOldApi alloc] initWithBorrowId:self.borrowId repaymentAmount:self.repaymentAmount proofUrl:proofUrl ];
    [payProofApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            self.uploadProof = YES;
            [self uploadProofSuccess:responseDict];
        } else {
            NSString *msgStr = [responseDict[@"msg"] description];
            [self.view makeCenterToast:msgStr];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

//  上传凭证成功
- (void)uploadProofSuccess:(NSDictionary *)resultDict{
    NSDictionary *dataDict = resultDict[@"data"];
    NSString *submitName = [dataDict[@"submitName"] description];
    NSString *submitDesc = [dataDict[@"submitDesc"] description];
    NSString *finishName = [dataDict[@"finishName"] description];
    NSString *finishDesc = [dataDict[@"finishDesc"] description];
    LSPaySuccessViewController *successVC = [[LSPaySuccessViewController alloc] init];
    successVC.submitName = submitName;
    successVC.submitDesc = submitDesc;
    successVC.finishName = finishName;
    successVC.finishDesc = finishDesc;
    successVC.successResultType = PaySuccessResultRepaymentType;
    [self.navigationController pushViewController:successVC animated:YES];
}

#pragma mark - 按钮点击事件
//  去支付宝还款按钮点击事件
- (void)goRepaymentButtonAction{
    //    [self.grayUploadButton setTitle:@"上传凭证" forState:UIControlStateNormal];
    
    //  跳转到支付宝
    NSURL *appUrl = [NSURL URLWithString:@"alipay://"];
    [[UIApplication sharedApplication] openURL:appUrl];
    
    //  跳转到支付宝
    [self jumpToAlipayStatistics];
}

//  还未付款, 去付款按钮点击事件
- (void)alipayRepaymentButtonAction{
    //  跳转到支付宝
    NSURL *appUrl = [NSURL URLWithString:@"alipay://"];
    [[UIApplication sharedApplication] openURL:appUrl];
}

//  已付款,上传凭证 按钮点击事件
- (void)redUploadButtonAction{
    //  选择图片
    [self uploadPayProof];
}

//  选择相册图片
- (void)clearUploadProofButtonAction{
    [self choisePhotoAlbum];
}

//  选择相册图片
- (void)grayUploadButtonAction{
    [self choisePhotoAlbum];
}

//  选择相册图片
- (void)choisePhotoAlbum{
    //  选择图片
    if ([self.grayUploadButton.currentTitle isEqualToString:@"重新上传"] || [self.grayUploadButton.currentTitle isEqualToString:@"上传凭证"]) {
        [self pushTZImagePickerController];
    }else if ([self.grayUploadButton.currentTitle isEqualToString:@"查看教程"]){
        //  查看支付宝教程
        [self.view endEditing:YES];
        [ZTMXFCourseView popupCourseViewType:LSAlipayProofType];
        
        [self viewAlipayRepaymentCourseStatistics];
    }
}

#pragma mark - 上传还款截图
- (void)uploadPayImage{
    //  上传还款截图
    [self uploadAlipayRepaymentImageStatistics];
    
    [self pushTZImagePickerController];
}

//  上传凭证提示
- (void)uploadReminderButtonAction{
    LSAlipayProofViewController *proofVC = [[LSAlipayProofViewController alloc] init];
    [self.navigationController pushViewController:proofVC animated:YES];
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.mainScrollView];
    
    UIView *topView = [UIView setupViewWithSuperView:self.mainScrollView withBGColor:COLOR_WHITE_STR];
    topView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(150.0));
    topView.backgroundColor = [UIColor whiteColor];
    
    UILabel *payAmount = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentCenter];
    payAmount.text = @"支付金额 (元)";
    payAmount.frame = CGRectMake(0.0, AdaptedHeight(14.0), Main_Screen_Width, AdaptedHeight(20));
    [topView addSubview:payAmount];
    
    UILabel *amountLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"E56647"] fontSize:AdaptedWidth(40) alignment:NSTextAlignmentCenter];
    amountLabel.text = self.repaymentAmount;
    amountLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
    amountLabel.font = [UIFont boldSystemFontOfSize:AdaptedWidth(40)];
    amountLabel.frame = CGRectMake(0.0, CGRectGetMaxY(payAmount.frame), Main_Screen_Width, AdaptedHeight(56));
    [topView addSubview:amountLabel];
    
    UILabel *accountLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentCenter];
    accountLabel.text = [NSString stringWithFormat:@"支付宝还款账号 %@", self.alipayAcount];
    accountLabel.frame = CGRectMake(0.0, CGRectGetMaxY(amountLabel.frame), Main_Screen_Width, AdaptedHeight(20));
    [topView addSubview:accountLabel];
    
    UIButton *returnPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnPayBtn setFrame:CGRectMake(0, CGRectGetMaxY(accountLabel.frame)+AdaptedHeight(7), SCREEN_WIDTH, AdaptedHeight(21))];
    [returnPayBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(15)]];
    [returnPayBtn setTitleColor:[UIColor colorWithHexString:@"4A90E2"] forState:UIControlStateNormal];
    [returnPayBtn setTitle:@"已复制账号，去支付宝还款>" forState:UIControlStateNormal];
    [returnPayBtn addTarget:self action:@selector(goRepaymentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:returnPayBtn];
    
    UIView *centerView = [UIView setupViewWithSuperView:self.mainScrollView withBGColor:COLOR_WHITE_STR];
    centerView.frame = CGRectMake(0.0, CGRectGetMaxY(topView.frame) + AdaptedHeight(10), Main_Screen_Width, Main_Screen_Height - TabBar_Addition_Height - CGRectGetHeight(topView.frame) - AdaptedHeight(10) - 120.0);
    centerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *uploadReminderButton = [HWTitleButton buttonWithType:UIButtonTypeCustom];
    uploadReminderButton.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(17)];
    [uploadReminderButton setTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] forState:UIControlStateNormal];
    [uploadReminderButton setTitle:@"转账成功后记得上传还款截图哦！" forState:UIControlStateNormal];
    //    [uploadReminderButton setImage:[UIImage imageNamed:@"XL_upload_proof_reminder"] forState:UIControlStateNormal];
    //    [uploadReminderButton addTarget:self action:@selector(uploadReminderButtonAction) forControlEvents:UIControlEventTouchUpInside];
    uploadReminderButton.frame = CGRectMake(0.0, 12.0, Main_Screen_Width, 20.0);
    [centerView addSubview:uploadReminderButton];
    
    UIImageView *rowGifImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, uploadReminderButton.bottom+4.0, 15, 20)];
    rowGifImgView.image = [UIImage imageWithGIFNamed:@"guideRow"];
    rowGifImgView.centerX = SCREEN_WIDTH/2.;
    [centerView addSubview:rowGifImgView];
    
    UIView *dashView = [UIView setupViewWithSuperView:centerView withBGColor:COLOR_WHITE_STR];
    CGFloat dashViewHeight = CGRectGetHeight(centerView.frame) - k_Navigation_Bar_Height - 37.0;
    CGFloat dashViewWidth = 170.0 / 293.0 * dashViewHeight;
    dashView.frame = CGRectMake((Main_Screen_Width - dashViewWidth) / 2.0, CGRectGetMaxY(rowGifImgView.frame) + 12.0, dashViewWidth, dashViewHeight);
    [dashView setupViewDotWdith:1 dotColor:K_B8B8B8 fullLineWidth:2 blankWidth:3 radius:0];
    
    
    self.uploadImageView = [[UIImageView alloc] init];
    self.uploadImageView.frame = CGRectMake(5.0, 5.0, CGRectGetWidth(dashView.frame) - 10.0, CGRectGetHeight(dashView.frame) - 10.0);
    self.uploadImageView.userInteractionEnabled = YES;
//    self.uploadImageView.image = [UIImage imageNamed:@"XL_alipay_demo"];
    [dashView addSubview:self.uploadImageView];
    
    UIButton *clearUploadProofButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearUploadProofButton.backgroundColor = [UIColor clearColor];
    clearUploadProofButton.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.uploadImageView.frame), CGRectGetHeight(self.uploadImageView.frame) - 50.0);
    [clearUploadProofButton addTarget:self action:@selector(clearUploadProofButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [dashView addSubview:clearUploadProofButton];
    
    UIView *grayView = [UIView setupViewWithSuperView:self.uploadImageView withBGColor:COLOR_BLACK_STR];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.6;
    grayView.frame = CGRectMake(0.0, CGRectGetHeight(self.uploadImageView.frame) - 50.0, CGRectGetWidth(self.uploadImageView.frame), 50.0);
    grayView.centerY = _uploadImageView.centerY;
    [self.uploadImageView addSubview:grayView];
    
    
    self.grayUploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.grayUploadButton setTitle:@"查看教程" forState:UIControlStateNormal];
    [self.grayUploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.grayUploadButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.grayUploadButton.frame = CGRectMake(0.0, CGRectGetMinY(grayView.frame), CGRectGetWidth(grayView.frame), CGRectGetHeight(grayView.frame));
    [self.grayUploadButton addTarget:self action:@selector(grayUploadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.uploadImageView addSubview:self.grayUploadButton];
    
    UIView *bottomView = [UIView setupViewWithSuperView:self.mainScrollView withBGColor:COLOR_WHITE_STR];
    bottomView.frame = CGRectMake(0.0, centerView.bottom + 20, Main_Screen_Width, 57.0);
    bottomView.backgroundColor = [UIColor clearColor];
    
    //    UILabel *copyAccount = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:12 alignment:NSTextAlignmentCenter];
    //    copyAccount.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, 25.0);
    //    copyAccount.text = @"已经帮您复制支付宝还款账号";
    //    [bottomView addSubview:copyAccount];
    
    UIButton *goRepaymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goRepaymentButton setTitle:@"上传还款截图" forState:UIControlStateNormal];
    goRepaymentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    goRepaymentButton.backgroundColor = K_MainColor;
    goRepaymentButton.frame = CGRectMake(46.0, 0.0, Main_Screen_Width - 92.0, 44.0);
    goRepaymentButton.layer.cornerRadius = 3.0;
    goRepaymentButton.clipsToBounds = YES;
    [goRepaymentButton addTarget:self action:@selector(uploadPayImage) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:goRepaymentButton];
    self.goRepaymentButton = goRepaymentButton;
    
    
    CGFloat buttonLeftMargin = 20.0;
    CGFloat buttonWidth = (Main_Screen_Width - 75.0) / 2.0;
    CGFloat buttonHeight = 40.0;
    
    self.alipayRepaymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alipayRepaymentButton setTitle:@"还未付款, 去还款" forState:UIControlStateNormal];
    self.alipayRepaymentButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.alipayRepaymentButton setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateNormal];
    self.alipayRepaymentButton.frame = CGRectMake(buttonLeftMargin, 0.0, buttonWidth, buttonHeight);
    self.alipayRepaymentButton.layer.cornerRadius = 20.0;
    self.alipayRepaymentButton.clipsToBounds = YES;
    self.alipayRepaymentButton.layer.borderWidth = 1.0;
    self.alipayRepaymentButton.layer.borderColor = [UIColor colorWithHexString:COLOR_RED_STR].CGColor;
    [self.alipayRepaymentButton addTarget:self action:@selector(alipayRepaymentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.alipayRepaymentButton.hidden = YES;
    [bottomView addSubview:self.alipayRepaymentButton];
    
    self.redUploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.redUploadButton setBackgroundImage:[UIImage imageNamed:@"btnBg"] forState:UIControlStateNormal];
    [self.redUploadButton setTitle:@"已付款, 上传凭证" forState:UIControlStateNormal];
    self.redUploadButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.redUploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.redUploadButton.frame = CGRectMake(CGRectGetMaxX(self.alipayRepaymentButton.frame) + 35.0, 0.0, buttonWidth, buttonHeight);
    self.redUploadButton.layer.cornerRadius = 20.0;
    self.redUploadButton.clipsToBounds = YES;
    [self.redUploadButton addTarget:self action:@selector(redUploadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.redUploadButton.hidden = YES;
    [bottomView addSubview:self.redUploadButton];
    
    _mainScrollView.contentSize = CGSizeMake(0, bottomView.bottom + 20);
}

-(UIView *)uploadSuccessView{
    if (!_uploadSuccessView) {
        _uploadSuccessView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_uploadSuccessView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *titleLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:AdaptedWidth(17) alignment:NSTextAlignmentCenter];
        titleLabel.text = @"请确认还款截图是否正确";
        titleLabel.frame = CGRectMake(0.0,18.0, Main_Screen_Width, AdaptedHeight(24));
        [_uploadSuccessView addSubview:titleLabel];
        
        UIView *dashView = [UIView setupViewWithSuperView:_uploadSuccessView withBGColor:COLOR_WHITE_STR];
        dashView.frame = CGRectMake(0, titleLabel.bottom + 18.0, AdaptedWidth(268), AdaptedHeight(460));
        dashView.centerX = _uploadSuccessView.centerX;
        [dashView setupViewDotWdith:1 dotColor:K_B8B8B8 fullLineWidth:2 blankWidth:3 radius:0];
        
        self.uploadImageView = [[UIImageView alloc] init];
        self.uploadImageView.frame = CGRectMake(5.0, 5.0, CGRectGetWidth(dashView.frame) - 10.0, CGRectGetHeight(dashView.frame) - 10.0);
        self.uploadImageView.userInteractionEnabled = YES;
        //        self.uploadImageView.image = [UIImage imageNamed:@"XL_alipay_demo"];
        [dashView addSubview:self.uploadImageView];
        
        UIView *grayView = [UIView setupViewWithSuperView:self.uploadImageView withBGColor:COLOR_BLACK_STR];
        grayView.backgroundColor = [UIColor blackColor];
        grayView.alpha = 0.6;
        grayView.frame = CGRectMake(0.0, CGRectGetHeight(self.uploadImageView.frame) - 60.0, CGRectGetWidth(self.uploadImageView.frame), 60.0);
        [self.uploadImageView addSubview:grayView];
        
        
        UIButton *againUploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [againUploadBtn setTitle:@"重新上传" forState:UIControlStateNormal];
        [againUploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        againUploadBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        againUploadBtn.frame = CGRectMake(0.0, CGRectGetMinY(grayView.frame), CGRectGetWidth(grayView.frame), CGRectGetHeight(grayView.frame));
        [againUploadBtn addTarget:self action:@selector(uploadPayImage) forControlEvents:UIControlEventTouchUpInside];
        [self.uploadImageView addSubview:againUploadBtn];
        
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitButton setBackgroundImage:[UIImage imageNamed:@"btnBg"] forState:UIControlStateNormal];
        [submitButton setTitle:@"提 交" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitButton.frame = CGRectMake(46.0, dashView.bottom+32.0, Main_Screen_Width - 92.0, 44.0);
        submitButton.layer.cornerRadius = 22.0;
        submitButton.clipsToBounds = YES;
        [submitButton addTarget:self action:@selector(redUploadButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_uploadSuccessView addSubview:submitButton];
        
    }
    return _uploadSuccessView;
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainScrollView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 支付宝页面统计
- (void)enterAlipayPageStatistics{
   
}

#pragma mark - 跳转到支付宝
- (void)jumpToAlipayStatistics{
   
}

#pragma mark - 查看支付宝还款教程
- (void)viewAlipayRepaymentCourseStatistics{
}

#pragma mark - 上传支付宝还款截图
- (void)uploadAlipayRepaymentImageStatistics{
   
}

@end
