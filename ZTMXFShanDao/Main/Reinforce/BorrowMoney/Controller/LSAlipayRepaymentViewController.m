//
//  LSAlipayRepaymentViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAlipayRepaymentViewController.h"
#import "ReflectionLabel.h"
#import "UIView+Administer.h"
#import "UploadSingleImageService.h"
#import "ImageCompressHelper.h"
#import "LSUploadPayProofApi.h"
#import "LSPaySuccessViewController.h"
#import "LSPayFailureViewController.h"
#import "TZImagePickerController.h"
#import "LSAlipayProofViewController.h"
#import "ALAIntroduction.h"
#import "HWTitleButton.h"
#import "UIImage+addition.h"
#import "ZTMXFCourseView.h"
#import "ZTMXFConfirmLoanHeaderView.h"
#import "UILabel+Attribute.h"
#import "UITextField+Addition.h"
@interface LSAlipayRepaymentViewController ()<TZImagePickerControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>

/** 1.4版本 */
@property (nonatomic, strong) UIScrollView *mainScrollView;

/** 是否上传凭证 */
@property (nonatomic, assign) BOOL uploadOrderNumber;

/** 示例图 */
@property (nonatomic, strong) UIImageView *uploadImageView;
/** 查看教程 */
@property (nonatomic, strong) UIButton    *viewCourseButton;

/** 订单号UITextField */
@property (nonatomic, strong) UITextField *orderTextField;
/** 上传订单号按钮 */
@property (nonatomic, strong) UIButton    *uploadOrderNumberButton;

@end

@implementation LSAlipayRepaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付宝还款";
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    [self configueSubViews];
    [self setNavgationBarRightTitle:@"还款帮助"];
    
    //  进入页面pv统计
    [self enterAlipayPageStatistics];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - 返回按钮操作
- (void)clickReturnBackEvent{
    if (!self.uploadOrderNumber) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"还没提交凭证, 确认离开?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *leave = [UIAlertAction actionWithTitle:@"先离开" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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

#pragma mark - 接口请求
- (void)submitAlipayWithOrderNumber:(NSString *)orderNumber{
    self.uploadOrderNumberButton.userInteractionEnabled = NO;
    [SVProgressHUD showLoading];
    LSUploadPayProofApi * payProofApi = [[LSUploadPayProofApi alloc] initWithBorrowId:self.borrowId repaymentAmount:self.repaymentAmount orderNumber:orderNumber];
    [payProofApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            self.uploadOrderNumber = YES;
            [self uploadProofSuccess:responseDict];
        } else {
            NSString *msgStr = [responseDict[@"msg"] description];
            [self.view makeCenterToast:msgStr];
        }
        self.uploadOrderNumberButton.userInteractionEnabled = YES;
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        self.uploadOrderNumberButton.userInteractionEnabled = YES;
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
    //  复制账号到剪切板
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = kAlipayRepaymentAccount;

    //  跳转到支付宝
    NSURL *appUrl = [NSURL URLWithString:@"alipay://"];
    BOOL openAlipay = [[UIApplication sharedApplication] openURL:appUrl];
    if (!openAlipay) {
        [self.view makeCenterToast:@"请先安装支付宝APP"];
    }
    
    //  跳转到支付宝
    [self jumpToAlipayStatistics];
}


//  上传订单号
- (void)uploadOrderNumberButtonAction{
    if (kStringIsEmpty(self.orderTextField.text)) {
        [kKeyWindow makeTopToast:@"请粘贴订单号"];
        return;
    }
    [self submitAlipayWithOrderNumber:self.orderTextField.text];
}

// 查看教程
- (void)viewCourseButtonAction{
    [self.view endEditing:YES];
    [ZTMXFCourseView popupCourseViewType:LSAlipayOrderType];
    //  查看支付宝教程
    [self viewAlipayRepaymentCourseStatistics];
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
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    ZTMXFConfirmLoanHeaderView * confirmLoanHeaderView = [[ZTMXFConfirmLoanHeaderView alloc] initWithFrame:CGRectMake(12, 16 * PY, KW - 24, 140 * PY)];
    confirmLoanHeaderView.textLabel.text = @"支付金额";
    NSString * amountStr = [NSString stringWithFormat:@"¥%@", _repaymentAmount];
    [UILabel attributeWithLabel:confirmLoanHeaderView.amountLabel text:amountStr maxFont:36 * PX minFont:18 * PX attributes:@[@"¥",_repaymentAmount] attributeFonts:@[FONT_LIGHT(18 * PX), FONT_Medium(36 * PX)]];
    confirmLoanHeaderView.costLabel.text = [NSString stringWithFormat:@"支付宝还款账号 %@", kAlipayRepaymentAccount];
//    [confirmLoanHeaderView.costLabel sizeToFit];
    [_mainScrollView addSubview:confirmLoanHeaderView];
    confirmLoanHeaderView.costLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [confirmLoanHeaderView.costLabel addGestureRecognizer:tapGR];
    
    UIButton *returnPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnPayBtn setFrame:CGRectMake(0, confirmLoanHeaderView.bottom + 20, SCREEN_WIDTH, AdaptedHeight(21))];
    [returnPayBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(15)]];
    [returnPayBtn setTitleColor:[UIColor colorWithHexString:@"4A90E2"] forState:UIControlStateNormal];
    [returnPayBtn setTitle:@"已复制账号，去支付宝还款" forState:UIControlStateNormal];
    [returnPayBtn addTarget:self action:@selector(goRepaymentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:returnPayBtn];
    
    UIView *centerView = [UIView setupViewWithSuperView:self.mainScrollView withBGColor:COLOR_WHITE_STR];
    centerView.frame = CGRectMake(0.0, returnPayBtn.bottom + 20, Main_Screen_Width, 10);
    centerView.backgroundColor = COLOR_SRT(@"#F2F2F2");
    [_mainScrollView addSubview:centerView];

    UILabel * txLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, centerView.bottom + 12, Main_Screen_Width, AdaptedHeight(24.0))];
    txLabel.text = @"转账后请上传支付宝订单号";
    txLabel.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    txLabel.font =FONT_Regular(14 * PX);
    [_mainScrollView addSubview:txLabel];
    
    UIView *orderNumberView = [[UIView alloc] init];
    orderNumberView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    orderNumberView.frame = CGRectMake(txLabel.left, txLabel.bottom + 14 * PX, KW - 40, 40 * PX);
    orderNumberView.layer.cornerRadius = 4.0;
    orderNumberView.clipsToBounds = YES;
    [_mainScrollView addSubview:orderNumberView];
    
    self.orderTextField = [[UITextField alloc] init];
    
    
    self.orderTextField = [UITextField textfieldWidthPlaceHolder:@"请粘贴订单号" placeHolderColorStr:@"#F3857B" textColor:@"#F3857B" textSize:14 leftMargin:10];

//    self.orderTextField.font = [UIFont systemFontOfSize:14];
//    self.orderTextField.textColor = [UIColor colorWithHexString:@"#F3857B"];
//    self.orderTextField.placeholder = @"请粘贴订单号";
    self.orderTextField.frame = CGRectMake(txLabel.left, txLabel.bottom + 14 * PX, KW - 40, 40 * PX);
//    UIView *leftView = [[UIView alloc] init];
//    leftView.frame = CGRectMake(0.0, 0.0, 10.0, 20.0);
//    self.orderTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.orderTextField.leftView = leftView;
    [_mainScrollView addSubview:self.orderTextField];
    
    
    self.uploadImageView = [[UIImageView alloc] init];
    self.uploadImageView.userInteractionEnabled = YES;
//    self.uploadImageView.image = [UIImage imageNamed:@"XL_alipay_demo"];
    CGFloat dashViewHeight = 172 * PX;
    CGFloat dashViewWidth = AdaptedWidth(352.0);
    self.uploadImageView.frame = CGRectMake((Main_Screen_Width - dashViewWidth) / 2.0, _orderTextField.bottom + AdaptedHeight(29.0), dashViewWidth, dashViewHeight);
    [_mainScrollView addSubview:self.uploadImageView];
    
    self.viewCourseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.viewCourseButton setTitle:@"查看教程" forState:UIControlStateNormal];
    [self.viewCourseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.viewCourseButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.viewCourseButton.frame = CGRectMake(CGRectGetMinX(self.uploadImageView.frame), CGRectGetMinY(self.uploadImageView.frame), CGRectGetWidth(self.uploadImageView.frame), CGRectGetHeight(self.uploadImageView.frame));
    [self.viewCourseButton addTarget:self action:@selector(viewCourseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:self.viewCourseButton];
    
    
    self.uploadOrderNumberButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.uploadOrderNumberButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"F85C3B"]] forState:UIControlStateNormal];
    self.uploadOrderNumberButton.layer.cornerRadius = 3;
    _uploadOrderNumberButton.backgroundColor = K_MainColor;
    [self.uploadOrderNumberButton setTitle:@"上传单号" forState:UIControlStateNormal];
    self.uploadOrderNumberButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self.uploadOrderNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.uploadOrderNumberButton.frame = CGRectMake(20, _uploadImageView.bottom + 40 * PY, KW   - 40, 44 * PX);
    [self.uploadOrderNumberButton addTarget:self action:@selector(uploadOrderNumberButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:self.uploadOrderNumberButton];

    self.mainScrollView.contentSize = CGSizeMake(Main_Screen_Width, CGRectGetMaxY(_uploadOrderNumberButton.frame) + 40.0);
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

- (void)tapAction
{
    [kKeyWindow makeCenterToast:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = kAlipayRepaymentAccount;
   
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
