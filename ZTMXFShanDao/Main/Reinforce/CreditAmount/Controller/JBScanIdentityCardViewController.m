//
//  JBScanIdentityCardViewController.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "JBScanIdentityCardViewController.h"
#import "ZTMXFJBFaceRecognitionViewController.h"
#import "ScanIdentityCardView.h"
#import "WJYAlertView.h"
#import "ZTMXFFacePlusManager.h"
#import "ImageCompressHelper.h"
#import "IdentityFrontInfoModel.h"
#import "IdentityBackInfoModel.h"
#import "ZTMXFUserInfoViewModel.h"
#import <MGLivenessDetection/MGLivenessDetection.h>

#import "LSGetFaceType.h"
#import "LSIdentityAlertView.h"
#import "CertificationProssView.h"
#import <WTAuthorizationTool.h>
#import "ZTMXFPermissionsAlertView.h"
#import "ZTMXFCertificationPromptView.h"

@interface JBScanIdentityCardViewController ()<ScanIdentityCardViewDelegate, FacePlusManagerDelgate, UserInfoViewModelDelegate,LSIdentityAlertViewDelegete>

@property (nonatomic, strong) UIView                *descriptView;
@property (nonatomic, strong) ScanIdentityCardView  *scanIdentityCardView;
@property (nonatomic, strong) ZTMXFUserInfoViewModel     *userInfoViewModel;
/** face ++ */
@property (nonatomic, strong) ZTMXFFacePlusManager       *facePlusManager;

/** 正面身份证信息model */
@property (nonatomic, strong) IdentityFrontInfoModel *identityFrontInfoModel;
/** 正面身份证信息model */
@property (nonatomic, strong) IdentityBackInfoModel *identityBackInfoModel;

/** 身份认证提示 */
@property (nonatomic, strong) LSIdentityAlertView *identityAlertView;
/** 是否第一次认证失败 */
@property (nonatomic, assign) BOOL isFirstIdentityFailure;
/** 点击正面、反面 */
@property (nonatomic, assign) BOOL isClickHeadView;

/** 人脸识别控制器 */
@property (nonatomic, strong) ZTMXFJBFaceRecognitionViewController *faceRecognitionVC;

@end

@implementation JBScanIdentityCardViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //氪信浏览统计
    [CreditXAgent onEnteringPage:CXPageNameIdVerify];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //氪信浏览统计
    [CreditXAgent onLeavingPage:CXPageNameIdVerify];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //消费贷身份证页面 pv
    [ZTMXFUMengHelper mqEvent:k_Idcard_page_pv_xf];

    self.navigationItem.title = @"身份认证";
    //右边?按钮
    [self setNavgationBarRightImageStr:@"XL_WenHao"];
    //添加主要视图
    [self configueSubviews];
    //  默认依图识别
    _authType = FacePlusAuthentication;
    //  获取认证类型
    [self.userInfoViewModel requestRealNameAuthType];
    //清除存储
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isFirstFailure"];
    //  添加子控制器-人脸
    [self addFaceRecognitionVC];
    [self configFacePlusAuth];
}

//  配置face++联网
- (void)configFacePlusAuth{
    //  face++  互联网授权
    [MGLiveManager licenseForNetWokrFinish:^(bool License) {
        if (License) {
            NSLog(@"face++  网络授权成功");
        }
    }];
}

//  添加人脸控制器
- (void)addFaceRecognitionVC
{
    self.faceRecognitionVC.view.frame = CGRectMake(10.0, k_Navigation_Bar_Height + 40, 10.0, 10.0);
    [self.view addSubview:self.faceRecognitionVC.view];
    [self addChildViewController:self.faceRecognitionVC];
}

#pragma mark - 点击身份认证说明
- (void)right_button_event:(UIButton *)sender{
    
    sender.userInteractionEnabled = NO;
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(idCardExplain);
    [self.navigationController pushViewController:webVC animated:YES];
    sender.userInteractionEnabled = YES;
}

#pragma mark - 自定义代理方法
#pragma mark - LSIdentityAlertViewDelegete
#pragma mark - 点击再试试按钮
- (void)clickTryButton
{
    // 跳转到相应的识别窗口
    if (self.isClickHeadView) {
        // 点击的正面
            [self.facePlusManager fp_scanIdentityID:IDCARD_SIDE_FRONT viewController:self];
    }else{
        // 点击的反面
            [self.facePlusManager fp_scanIdentityID:IDCARD_SIDE_BACK viewController:self];
    }
}

//打开摄像头
- (void)allowCamera
{
    [ZTMXFPermissionsAlertView showAlert:XLPermissionsCamera Click:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
    }];
}

- (void)certificationCardFront
{
    [SVProgressHUD dismissAfterDuration:1 mask:NO complete:nil];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_smrz_zmz" OtherDict:nil];
    self.isClickHeadView = YES;
    // 是否弹出提示框
    if ([self isAlertIdentityView]) {
        return;
    }
    [self.facePlusManager fp_scanIdentityID:IDCARD_SIDE_FRONT viewController:self];

}

#pragma mark 点击正面
- (void)scanIdentityCardViewClickHead{
    
    @WeakObj(self);
    [WTAuthorizationTool requestCameraAuthorization:^(WTAuthorizationStatus status) {
        if (status == WTAuthorizationStatusDenied) {
            [selfWeak allowCamera];
        }else{
            [selfWeak certificationCardFront];
        }
    }];
}

//认证身份证返回
- (void)certificationCardBack
{
    [SVProgressHUD dismissAfterDuration:1 mask:NO complete:nil];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_smrz_fmz" OtherDict:nil];
    self.isClickHeadView = NO;
    // 是否弹出提示框
    if ([self isAlertIdentityView]) {
        return;
    }
    //扫描身份证
    [self.facePlusManager fp_scanIdentityID:IDCARD_SIDE_BACK viewController:self];
   
}


/** 点击反面 */
- (void)scanIdentityCardViewClickTail
{
    @WeakObj(self);
    [WTAuthorizationTool requestCameraAuthorization:^(WTAuthorizationStatus status) {
        if (status == WTAuthorizationStatusDenied) {
            [selfWeak allowCamera];
        }else{
            [selfWeak certificationCardBack];
        }
    }];
   
}

//认证失败 展示提示框
- (BOOL)isAlertIdentityView{
    if (self.isFirstIdentityFailure) {
        [self.identityAlertView show];
        return YES;
    }
    return NO;
}

/** 点击下一步 */
- (void)scanIdentityCardViewClickNextAction
{
    
    if (self.identityFrontInfoModel && self.identityBackInfoModel) {
        //  身份证两面都扫过
        [ZTMXFUMengHelper mqEvent:k_idcard_page_next_xf];
        //  判断名字是否修改
        if (![self.identityFrontInfoModel.cardInfo.name isEqualToString:[self.scanIdentityCardView identityEditName]]) {
            [WJYAlertView showTwoButtonsWithTitle:@"" Message:@"为了提高通过率,请确保您的身份证姓名与扫描结果姓名统一!\n信息不一致将无法通过人脸识别" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"返回修改" Click:^{
                NSLog(@"您点返回修改");
            } ButtonType:WJYAlertViewButtonTypeNone ButtonTitle:@"确认提交" Click:^{
                [self uploadIdentityFrontBackInfo];
            }];
        } else {
            [self uploadIdentityFrontBackInfo];
        }
        
    } else {
        [self.view makeCenterToast:@"请先扫描身份证正反面"];
    }
}

//  上传身份证正反面信息
- (void)uploadIdentityFrontBackInfo{
    /** face ++ 正反面上传 */
    [self.facePlusManager fp_submitIdentityFrontBackImagesWithEditName:[self.scanIdentityCardView identityEditName]];
}

#pragma mark - 配置实名认证类型
- (void)requestRealNameAuthSuccessAuthType:(RealNameAuthenticationType)authType nameEdit:(BOOL)edit{
    _authType = authType;
    if (edit) {
        //  名字可编辑
        [self.scanIdentityCardView realNameEdit:YES];
    } else {
        //  名字不可编辑
        [self.scanIdentityCardView realNameEdit:NO];
    }
}

#pragma mark - face++ 身份证识别成功
/** 识别身份证图片成功 */
- (void)fp_scanIdentityIdSuccess:(UIImage *)image cardType:(MGIDCardSide)type{
    if (type == IDCARD_SIDE_FRONT) {
        //  正面
        [self.scanIdentityCardView setHeadImage:image];
        
        //[self.scanIdentityCardView setHeadImage:[self jx_WaterImageWithImage:[self jx_WaterImageWithImage:image waterImage:[UIImage imageNamed:@"XL_Privacy_Protection_BG"] waterImageRect:CGRectMake(0, 0, image.size.width, image.size.height)] waterImage:[UIImage imageNamed:@"XL_Privacy_Protection"] waterImageRect:CGRectMake(image.size.width - 220, 0, 220, 200)]];
        
    } else if (type == IDCARD_SIDE_BACK) {
        //  反面
        [self.scanIdentityCardView setTailImage:image];
        
        //[self.scanIdentityCardView setTailImage:[self jx_WaterImageWithImage:[self jx_WaterImageWithImage:image waterImage:[UIImage imageNamed:@"XL_Privacy_Protection_BG"] waterImageRect:CGRectMake(0, 0, image.size.width, image.size.height)] waterImage:[UIImage imageNamed:@"XL_Privacy_Protection"] waterImageRect:CGRectMake(image.size.width - 220, 0, 220, 200)]];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    self.isFirstIdentityFailure = NO;
}

/** 正面身份证上传成功 */
- (void)fp_uploadIdentityFrontImageSuccess:(IdentityFrontInfoModel *)frontInfoModel{
    [self.scanIdentityCardView showIdentityView];
    //自动填写
    [self.scanIdentityCardView setIdentityName:frontInfoModel.cardInfo.name];
    [self.scanIdentityCardView setIdentityIdNumber:frontInfoModel.cardInfo.citizen_id];
    self.identityFrontInfoModel = frontInfoModel;
}

/** 反面身份证上传成功 */
- (void)fp_uploadIdentityBackImageSuccess:(IdentityBackInfoModel *)backInfoModel{
    self.identityBackInfoModel =  backInfoModel;
}

/** 提交正反面身份证证信息成功 */
- (void)fp_submitIdentityFrontBackImagesSuccess{
    
    
//    JBFaceRecognitionViewController * faceRecognitionVC = [[JBFaceRecognitionViewController alloc] init];
//    faceRecognitionVC.title = @"人脸识别";
//    faceRecognitionVC.isAddBankCard = _isAddBankCard;
//    faceRecognitionVC.realName = [self.scanIdentityCardView identityEditName];
//    faceRecognitionVC.citizen_id = self.identityFrontInfoModel.cardInfo.citizen_id;
//     faceRecognitionVC.authType = _authType;
//    [self presentViewController:faceRecognitionVC animated:YES completion:^{
//        [faceRecognitionVC startFaceRecognition];
//    }];
    
//    [self.facePlusManager fp_beginFaceRecognition:self];

    self.faceRecognitionVC.realName = [self.scanIdentityCardView identityEditName];
    self.faceRecognitionVC.citizen_id = self.identityFrontInfoModel.cardInfo.citizen_id;
    self.faceRecognitionVC.authType = _authType;
    self.faceRecognitionVC.loanType = _loanType;
    /** 判断是否显示倒计时 */
    BOOL result =[[NSUserDefaults standardUserDefaults]boolForKey:@"ZTMXFCertificationPromptViewShow"];
    if (!result) {
        [ZTMXFCertificationPromptView showCertificationPromptViewWithTimerInterval:5 Success:^{
            //开始人脸识别
            [self.faceRecognitionVC startFaceRecognition];
        }];
    }else{
        [self.faceRecognitionVC startFaceRecognition];
    }
}

/** 取消身份证识别 */
- (void)fp_scanIdentityIdCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 切换身份证扫描 */
- (void)fp_switchScanIdentity:(RealNameAuthenticationType)authType{
    _authType = authType;
    //  清空页面信息
    [self clearScanIdentityInfo];
}

#pragma mark - 私有方法
/** 切换扫描身份证的信息 */
- (void)clearScanIdentityInfo{
    [self.scanIdentityCardView clearViewInfo];
    //设置身份认证状态
    [self setIdentityStatus];
}

#pragma mark - 设置身份认证状态
- (void)setIdentityStatus{
    NSString *isFirstFailure = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstFailure"];
    if (!isFirstFailure) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstFailure"];
        self.isFirstIdentityFailure = YES;
    }else{
        self.isFirstIdentityFailure = NO;
    }
}

#pragma mark - 添加子视图
- (void)configueSubviews
{
    [self.view addSubview:self.scanIdentityCardView];
}

- (UIView *)descriptView{
    if (_descriptView == nil) {
        _descriptView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 24.0)];
        _descriptView.backgroundColor = [UIColor whiteColor];
        UIImageView *redImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AdaptedWidth(55.0), 0.0, 2.0, 13.0)];
        UILabel *descriptLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(15.0) alignment:NSTextAlignmentLeft];
        [descriptLabel setFrame:CGRectMake(12, 3.0, SCREEN_WIDTH-AdaptedWidth(62), 21)];
        descriptLabel.text = @"拍摄时请确保身份证边框对齐 图象清晰";
        redImageView.centerY = descriptLabel.centerY;
        [_descriptView addSubview:descriptLabel];
    }
    return _descriptView;
}

- (ScanIdentityCardView *)scanIdentityCardView{
    if (_scanIdentityCardView == nil) {
        _scanIdentityCardView = [[ScanIdentityCardView alloc] initWithFrame:CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height)];
        _scanIdentityCardView.delegate = self;
    }
    return _scanIdentityCardView;
}

- (LSIdentityAlertView *)identityAlertView{
    if (_identityAlertView == nil) {
        _identityAlertView = [[LSIdentityAlertView alloc] init];
        _identityAlertView.delegete = self;
    }
    return _identityAlertView;
}

- (ZTMXFFacePlusManager *)facePlusManager{
    if (_facePlusManager == nil) {
        _facePlusManager = [[ZTMXFFacePlusManager alloc] init];
        _facePlusManager.delegate = self;
    }
    return _facePlusManager;
}


- (ZTMXFJBFaceRecognitionViewController *)faceRecognitionVC{
    if (_faceRecognitionVC == nil) {
        _faceRecognitionVC = [[ZTMXFJBFaceRecognitionViewController alloc] init];
        _faceRecognitionVC.title = @"人脸识别";
        _faceRecognitionVC.isAddBankCard = _isAddBankCard;
    }
    return _faceRecognitionVC;
}
- (ZTMXFUserInfoViewModel *)userInfoViewModel{
    if (_userInfoViewModel == nil) {
        _userInfoViewModel = [[ZTMXFUserInfoViewModel alloc] init];
        _userInfoViewModel.delegate = self;
    }
    return _userInfoViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"JBScanIdentityCardViewController---------------");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isFirstFailure"];
}
// 给图片添加图片水印
- (UIImage *)jx_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
    
    //1.获取图片
    
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


@end
