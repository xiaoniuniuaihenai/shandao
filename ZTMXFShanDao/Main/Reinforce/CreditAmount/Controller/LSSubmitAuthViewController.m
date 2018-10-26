//
//  LSSubmitAuthViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSubmitAuthViewController.h"
#import "AuthenProgressView.h"
#import "LSBasicsBottomView.h"
#import "LSBaseAuthView.h"
#import "LSWhiteLoanAuthView.h"
#import "WJYAlertView.h"
#import "LSAuthSupplyApi.h"
#import "MoxieSDK.h"
#import "ZTMXFAuthenticationViewModel.h"
#import "LSAuthSupplyCertifyModel.h"
#import "LSPromoteCreditInfoModel.h"
#import "ZhiMaCreditModel.h"
#import "AddressBookManager.h"

#import "LSCreditAuthWebViewController.h"
#import "LSPhoneOperationAuthViewController.h"
#import "LSSubmitCompanyPhoneViewController.h"
#import "LSCreditCheckViewController.h"
#import "RealNameManager.h"

/** 1.6.0版本*/
#import "LSCreditAuthView.h"
#import "LSCompanyAuthViewController.h"

/** 2.0版本*/
#import "LSMallCreditInfoModel.h"
#import "LSAuthResultViewController.h"
#import "LSLocationManager.h"

#import "ZTMXFAlertCustomView.h"
@interface LSSubmitAuthViewController ()<MoxieSDKDelegate, AuthenticationViewModelDelegate,LSCreditAuthWebViewDelegate,LSPhoneOperationAuthViewDelegate,LSCreditAuthViewDelegete>
/**  1.6版本*/
/** 进度条 */
@property (nonatomic, strong) AuthenProgressView *progressView;
/** 认证表单页 */
@property (nonatomic, strong) LSCreditAuthView *creditAuthView;
/** 慢必赔 */
@property (nonatomic, strong) LSBasicsBottomView  *basicsBottomView;
/** 温馨提示view */
@property (nonatomic, strong) UIView *remindView;

/** 认证viewModel */
@property (nonatomic, strong) ZTMXFAuthenticationViewModel *authViewModel;

/** 消费贷model */
@property (nonatomic, strong) LSPromoteCreditInfoModel *consumeLoanInfoModel;
/** 白领贷Model */
@property (nonatomic, strong) LSAuthSupplyCertifyModel *whiteLoanInfoModel;
/** 分期商城Model */
@property (nonatomic, strong) LSMallCreditInfoModel *mallLoanInfoModel;

/** 提交按钮 */
@property (nonatomic, strong) ZTMXFButton *submitButton;
/** 白领贷认证类型 */
@property (nonatomic, assign) AuthSupplyType authSupplyType;

@property (nonatomic, strong) UIScrollView *mainScrollView;

/** 定位数据 */
@property (nonatomic, copy) NSString *latitudeString;
@property (nonatomic, copy) NSString *longitudeString;

@end

@implementation LSSubmitAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"信用认证";
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self configSubViews];
    //  认证页面PV
    [self consumeWhiteAuthPageStatistics];
    
    //  设置定位
    LSSubmitAuthViewController * __weak weakSelf = self;
    if (![LoginManager appReviewState]){
        [[LSLocationManager shareLocationManager] locationSuccessWithComplish:^(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString) {
            weakSelf.latitudeString = latitudeString;
            weakSelf.longitudeString = longitudeString;
        }];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creditAuthChange) name:kCreditAuthChangePushNotification object:nil];
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.authType == MallLoanType) {
        // 分期商城认证
        [self.authViewModel requestMallCreditAuthInfoStatus];
    } else {
        /** 获取消费贷认证数据 */
        [self.authViewModel requestBaseAuthInfoApi];
    }
}
#pragma mark - 认证状态变更，状态刷新
- (void)creditAuthChange{
    if (self.authType == MallLoanType) {
        // 分期商城认证
        [self.authViewModel requestMallCreditAuthInfoStatus];
    } else {
        /** 获取消费贷认证数据 */
        [self.authViewModel requestBaseAuthInfoApi];
    }
}



#pragma mark - 是否可以提交白领贷
- (BOOL)isCanSubmitWhiteLoan{
    if (self.consumeLoanInfoModel.mobileStatus == 1 && (self.whiteLoanInfoModel.companyStatus == 1 || self.whiteLoanInfoModel.companyStatus == 2) && (self.whiteLoanInfoModel.socialSecurityStatus == 1 || self.whiteLoanInfoModel.fundStatus == 1)) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 是否可以提交消费分期
- (BOOL)isCanSubmitMallLoan{
    if (self.mallLoanInfoModel.mobileStatus == 1 && (self.mallLoanInfoModel.jingdongStatus == 1 || self.mallLoanInfoModel.taobaoStatus == 1)) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - 是否可以提交消费贷
- (BOOL)isCanSumitConsumeLoan{
    if (self.consumeLoanInfoModel.mobileStatus == 1) {
        return YES;
    } else {
        return NO;
    }
}
- (void)clickReturnBackEvent{
    if (_authType == WhiteLoanType) {
        //  白领贷
        [WJYAlertView showTwoButtonsWithTitle:@"确认放弃认证?" Message:@"放弃认证将无法获得白领贷额度\n最高可贷额度: 10000元" ButtonType:WJYAlertViewButtonTypeCancel ButtonTitle:@"我要放弃" Click:^{
            //  返回最开始跳进来的页面
            [RealNameManager realNameBackSuperVc:self];
        } ButtonType:WJYAlertViewButtonTypeNone ButtonTitle:@"继续认证" Click:^{
        }];
    } else {
        //  消费贷、消费分期
        [RealNameManager realNameBackSuperVc:self];
    }
}

#pragma mark - LSCreditAuthViewDelegete
- (void)clickAuthType:(LSCreditAuthType)creditAuthType{
    if (creditAuthType == LSRealNameAuthType) {
        // 点击实名认证
        [self authViewClickRealNameCredit];
    } else if (creditAuthType == LSBindCardAuthType){
        // 点击绑定银行卡
        [self authViewClickBankCardCredit];
    } else if (creditAuthType == LSZhiMaAuthType){
        // 点击芝麻信用
        [self authViewClickZhiMaCredit];
    } else if (creditAuthType == LSOperatorAuthType){
        // 点击运营商认证
        [self authViewClickPhoneOperation];
    } else if (creditAuthType == LSCompanyAuthType){
        // 点击公司认证
        [self whiteLoanAuthClickCompany];
    } else if (creditAuthType == LSSecurityAuthType){
        // 点击社保认证
        [self whiteLoanAuthViewClickSocialSecurity];
    } else if (creditAuthType == LSFundAuthType){
        // 点击公积金认证
        [self whiteLoanAuthViewClickProvidentFund];
    } else if (creditAuthType == LSJingDongAuthType){
        // 点击京东认证
        [self mallLoanAuthViewClickProvidentJingDong];
    } else if (creditAuthType == LSTaoBaoAuthType){
        // 点击淘宝认证
        [self mallLoanAuthViewClickProvidentTaoBao];
    }
}

/** 点击实名认证 */
- (void)authViewClickRealNameCredit{
    NSInteger faceStatus = 0;
    if (self.authType == MallLoanType) {
        faceStatus = self.mallLoanInfoModel.realnameStatus;
    } else {
        faceStatus = self.consumeLoanInfoModel.faceStatus;
    }
    if (faceStatus == 1) {
        //  实名认证成功
        [self.view makeCenterToast:@"实名认证已认证"];
    } else {
        //  没有实名认证
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES loanType:self.authType];
    }
}



/** 点击芝麻信用 */
- (void)authViewClickZhiMaCredit{
    NSInteger zmStatus = 0;
    if (self.authType == MallLoanType) {
        zmStatus = self.mallLoanInfoModel.zmStatus;
    } else {
        zmStatus = self.consumeLoanInfoModel.zmModel.zmStatus;
    }
    if (zmStatus == 1) {
        //  芝麻信用授权成功
        [self.view makeCenterToast:@"芝麻信用已认证"];
    } else {
        //  没有芝麻信用授权
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressZhiMaAuth isSaveBackVcName:YES loanType:self.authType];
    }
}
/** 点击运营商 */
- (void)authViewClickPhoneOperation{
    NSInteger mobileStatus = 0;
    if (self.authType == MallLoanType) {
        mobileStatus = self.mallLoanInfoModel.mobileStatus;
    } else {
        mobileStatus = self.consumeLoanInfoModel.mobileStatus;
    }
    if (mobileStatus == -1) {
        //  运营商认证失败
        [WJYAlertView showTwoButtonsWithTitle:@"" Message:@"您好, 您本次认证未通过! 您可以核对身份信息后, 重新尝试认证." ButtonType:WJYAlertViewButtonTypeCancel ButtonTitle:@"暂不认证" Click:^{
        } ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"重新认证" Click:^{
            // 重新认证运营商
            LSPhoneOperationAuthViewController *VC = [[LSPhoneOperationAuthViewController alloc] init];
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }];
    } else if (mobileStatus == 0) {
        //  未认证
        NSString * msgStr = @"闪到将获取您的通讯录权限稍后请点击“允许”";
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:msgStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_RED_STR] range:[msgStr rangeOfString:@"“允许”"]];
        ZTMXFAlertCustomView * alertCustomView = [[ZTMXFAlertCustomView alloc] initWithMessage:attStr btnTitle:@"知道了"];
        alertCustomView.btnClick = ^{
                LSPhoneOperationAuthViewController *VC = [[LSPhoneOperationAuthViewController alloc] init];
                VC.delegate = self;
                [self.navigationController pushViewController:VC animated:YES];
        };
        [alertCustomView showAlertView];
    } else if(mobileStatus ==2) {
        //  手机运营商品认证中
        [self.view makeCenterToast:@"运营商正在认证中，请耐心等待"];
    } else if (mobileStatus == 1) {
        //  手机运营商品认证成功
        [self.view makeCenterToast:@"运营商已认证"];
    }
}
/** 点击绑定银行卡 */
- (void)authViewClickBankCardCredit{
    NSInteger bindCardStatus = 0;
    if (self.authType == MallLoanType) {
        bindCardStatus = self.mallLoanInfoModel.bindCard;
    } else {
        bindCardStatus = self.consumeLoanInfoModel.bindCardStatus;
    }
    if (bindCardStatus == 1) {
        //  银行卡已绑定
        [self.view makeCenterToast:@"银行卡已绑定"];
    } else {
        //  银行卡未绑定
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES loanType:self.authType];
    }
}
/** 点击公司认证 */
- (void)whiteLoanAuthClickCompany{
    if (self.whiteLoanInfoModel.whiteRisk == 1) {
        [self.view makeCenterToast:@"公司信息已认证"];
    } else if (self.whiteLoanInfoModel.whiteRisk == 2) {
        [self.view makeCenterToast:@"公司信息正在认证中，请耐心等待"];
    } else {
        // 0-未认证，-1-认证失败
        LSCompanyAuthViewController *companyAuthVC = [[LSCompanyAuthViewController alloc] init];
        companyAuthVC.isBackLastVC = YES;
        companyAuthVC.companyAuthStatus = self.whiteLoanInfoModel.companyStatus;
        [self.navigationController pushViewController:companyAuthVC animated:YES];
    }
}
/** 点击社保 */
- (void)whiteLoanAuthViewClickSocialSecurity{
    if (self.whiteLoanInfoModel.socialSecurityStatus == 0 || self.whiteLoanInfoModel.socialSecurityStatus ==-1) {
        [self startMoXieAuthWithType:AuthSupplyTypeSheBao];
    } else if (self.whiteLoanInfoModel.socialSecurityStatus == 2){
        [self.view makeCenterToast:@"社保正在认证中，请耐心等待"];
    } else if (self.whiteLoanInfoModel.socialSecurityStatus == 1){
        [self.view makeCenterToast:@"社保已认证"];
    }
}
/** 点击公积金 */
- (void)whiteLoanAuthViewClickProvidentFund{
    if (self.whiteLoanInfoModel.fundStatus == 0 || self.whiteLoanInfoModel.fundStatus == -1) {
        [self startMoXieAuthWithType:AuthSupplyTypeGongJiJin];
    } else if (self.whiteLoanInfoModel.fundStatus ==2){
        [self.view makeCenterToast:@"公积金正在认证中，请耐心等待"];
    } else if (self.whiteLoanInfoModel.fundStatus ==1){
        [self.view makeCenterToast:@"公积金已认证"];
    }

}
/** 点击京东 */
- (void)mallLoanAuthViewClickProvidentJingDong{
    if (self.mallLoanInfoModel.jingdongStatus == 0 || self.mallLoanInfoModel.jingdongStatus == -1) {
        [self startMoXieAuthWithType:AuthSupplyTypeJingDong];
    } else if (self.mallLoanInfoModel.jingdongStatus == 2) {
        [self.view makeCenterToast:@"京东正在认证中，请耐心等待"];
    } else if (self.mallLoanInfoModel.jingdongStatus ==1){
        [self.view makeCenterToast:@"京东已认证"];
    }
}
/** 点击淘宝 */
- (void)mallLoanAuthViewClickProvidentTaoBao{
    if (self.mallLoanInfoModel.taobaoStatus == 0 || self.mallLoanInfoModel.taobaoStatus == -1) {
        [self startMoXieAuthWithType:AuthSupplyTypeTaoBao];
    } else if (self.mallLoanInfoModel.taobaoStatus == 2) {
        [self.view makeCenterToast:@"淘宝正在认证中，请耐心等待"];
    } else if (self.mallLoanInfoModel.taobaoStatus ==1){
        [self.view makeCenterToast:@"淘宝已认证"];
    }
}

#pragma mark - LSCreditAuthWebViewDelegate 芝麻信用认证结果
- (void)creditAuthWebViewCreditScore:(ZhiMaCreditModel *)creditModel{
    self.consumeLoanInfoModel.zmModel.zmStatus = 1;
    self.consumeLoanInfoModel.zmModel.zmScore = creditModel.zmScore;
    self.creditAuthView.consumeLoanInfoModel = self.consumeLoanInfoModel;
}

#pragma mark - LSPhoneOperationAuthViewDelegate 运营商认证成功
- (void)phoneOperationAuthViewSuccessAuth{
    self.consumeLoanInfoModel.mobileStatus = 1;
    self.creditAuthView.consumeLoanInfoModel = self.consumeLoanInfoModel;
}

#pragma mark - 魔蝎认证
/** 开始认证 */
- (void)startMoXieAuthWithType:(AuthSupplyType)authType{
    self.authSupplyType = authType;
    //  认证入口PV
    [SVProgressHUD showLoading];
    LSAuthSupplyApi *  authSupplyApi = [[LSAuthSupplyApi alloc] initWithSupplyType:authType];
    [authSupplyApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSString * transParaStr = [responseDict[@"data"][@"transPara"] description];
            /** 开始魔蝎认证 */
            [self beginMoxieSDKWithUserId:transParaStr authType:authType];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 魔蝎 认证
//公积金认证  0  社保认证 1  信用卡认证2  支付宝3
-(void)beginMoxieSDKWithUserId:(NSString*)userId authType:(AuthSupplyType)authType{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = userId;
    [MoxieSDK shared].apiKey = MoxieSDKKEY;
    [MoxieSDK shared].backImageName = @"nav_back";
    [MoxieSDK shared].fromController = self;
    switch (authType) {
        case AuthSupplyTypeGongJiJin:{
            //  公积金
            [MoxieSDK shared].taskType = @"fund";
        }
            break;
        case AuthSupplyTypeSheBao:{
            //  社保
            [MoxieSDK shared].taskType = @"security";
        }
            break;
        case AuthSupplyTypeZhiFuBao:{
            //  支付宝
            [MoxieSDK shared].taskType = @"alipay";
        }
            break;
        case AuthSupplyTypeJingDong:{
            //  京东
            [MoxieSDK shared].taskType = @"jingdong";
        }
            break;
        case AuthSupplyTypeTaoBao:{
            //  淘宝
            [MoxieSDK shared].taskType = @"taobao";
        }
            break;
        default:
            break;
    }
    [[MoxieSDK shared] startFunction];
}

//  魔蝎认证结果
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    //  code = -1, 用户未进行操作
    //  code 1,  用户认证成功
    //  code 2,  认证处理中
    int code = [resultDictionary[@"code"] intValue];
    if (code == 1 || code == 2) {
        
        [self.authViewModel requestAuthSupplyVerifyingType:self.authSupplyType];
        //  提交魔蝎项认证成功
        [self whiteLoanAuthItemSuccessStatistics];
    }
}

//
- (void)requestAuthSupplyVerifyingSuccess
{
    if (self.authType == MallLoanType) {
        [self.authViewModel requestMallCreditAuthInfoStatus];
    } else {
        [self.authViewModel requestPromoteAuthInfoApi];
    }
}

#pragma mark - AuthenticationViewModelDelegate获取认证页面信息
/** 获取消费贷认证信息成功 */
- (void)requestBaseAuthSuccess:(LSPromoteCreditInfoModel *)baseAuthInfoModel{
    if (baseAuthInfoModel) {
        //  设置消费贷数据
        self.consumeLoanInfoModel = baseAuthInfoModel;
        self.creditAuthView.consumeLoanInfoModel = baseAuthInfoModel;

        if (_authType == WhiteLoanType) {
            //  白领贷
            /** 获取白领贷认证数据 */
            [self.authViewModel requestPromoteAuthInfoApi];
        } else {
            //  更新消费贷
            [self updateConsumeLoanSubmitButtonState];
            
            // 更新进度条
            if ([self isCanSumitConsumeLoan]) {
                self.progressView.progressType = AuthenProgressConsumeLoan;
                [self.progressView startAnimationWithProgessType:AuthenProgressConsumeLoan];
            }else{
                self.progressView.progressType = AuthenProgressNoSubmitWhiteLoan;
                [self.progressView startAnimationWithProgessType:AuthenProgressNoSubmitWhiteLoan];
            }
        }
    }
}

/** 更新消费贷提交认证按钮 */
- (void)updateConsumeLoanSubmitButtonState{
    //  设置是否显示慢必赔
//    [self configConsumeLoanFrame];
    /** 是否走过认证的强风控【0:未审核A，-1:未通过审核N，2: 审核中P，1:已通过审核Y】 */
    self.submitButton.userInteractionEnabled = YES;
    [self.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
    NSInteger consumeRiskStatus = self.consumeLoanInfoModel.riskStatus;
    if (consumeRiskStatus == -1) {
        //  未通过审核
        if (!kStringIsEmpty(self.consumeLoanInfoModel.riskRetrialRemind)) {
            self.submitButton.hidden = NO;
            self.submitButton.userInteractionEnabled = NO;
            [self.submitButton setTitle:self.consumeLoanInfoModel.riskRetrialRemind forState:UIControlStateNormal];
        } else {
            self.submitButton.hidden = YES;
        }
    } else if (consumeRiskStatus == 0) {
        //  未审核
        if (self.consumeLoanInfoModel.faceStatus == 1 && self.consumeLoanInfoModel.bindCardStatus == 1 && self.consumeLoanInfoModel.zmModel.zmStatus == 1 && self.consumeLoanInfoModel.mobileStatus == 1 && self.consumeLoanInfoModel.contactsStatus == 1) {
            self.submitButton.userInteractionEnabled = YES;
            self.submitButton.hidden = NO;
        } else {
            self.submitButton.hidden = NO;
            self.submitButton.userInteractionEnabled = NO;
        }
    } else if (consumeRiskStatus == 1) {
        //  已通过审核
        self.submitButton.hidden = YES;
    } else if (consumeRiskStatus == 2) {
        //  审核中
        self.submitButton.hidden = NO;
        [self.submitButton setTitle:@"审核中" forState:UIControlStateNormal];
        self.submitButton.enabled = NO;
    }
}

/** 获取白领贷认证信息成功 */
- (void)requestPromoteAuthSuccess:(LSAuthSupplyCertifyModel *)promoteAuthInfoModel{
    if (promoteAuthInfoModel) {
        self.whiteLoanInfoModel = promoteAuthInfoModel;
        self.creditAuthView.whiteLoanInfoModel = promoteAuthInfoModel;
        [self updateWhiteLoanSubmitButtonState];
        
        // 更新进度条
        if ([self isCanSubmitWhiteLoan]) {
            self.progressView.progressType = AuthenProgressSubmitWhiteLoan;
            [self.progressView startAnimationWithProgessType:AuthenProgressSubmitWhiteLoan];
        }else{
            self.progressView.progressType = AuthenProgressNoSubmitWhiteLoan;
            [self.progressView startAnimationWithProgessType:AuthenProgressNoSubmitWhiteLoan];
        }
    }
}

/** 更新白领贷提交认证按钮 */
- (void)updateWhiteLoanSubmitButtonState{
    /** 是否走过认证的强风控【0:未审核A，-1:未通过审核N，2: 审核中P，1:已通过审核Y】 */
    self.submitButton.enabled = YES;
    [self.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
    NSInteger whiteRiskStatus = self.whiteLoanInfoModel.whiteRisk;
    if (whiteRiskStatus == -1) {
        //  未通过审核
        if (!kStringIsEmpty(self.whiteLoanInfoModel.whiteRiskRemind)) {
            self.submitButton.hidden = NO;
            self.submitButton.enabled = NO;
            [self.submitButton setTitle:self.whiteLoanInfoModel.whiteRiskRemind forState:UIControlStateNormal];
        } else {
            self.submitButton.hidden = YES;
        }
    } else if (whiteRiskStatus == 0) {
        //  未审核
        if (self.consumeLoanInfoModel.faceStatus == 1 && self.consumeLoanInfoModel.bindCardStatus == 1 && self.consumeLoanInfoModel.zmModel.zmStatus == 1 && self.consumeLoanInfoModel.mobileStatus == 1 && self.consumeLoanInfoModel.contactsStatus == 1 && (self.whiteLoanInfoModel.companyStatus == 1) ) {
            if (self.whiteLoanInfoModel.fundStatus == 1 || self.whiteLoanInfoModel.socialSecurityStatus == 1) {
                self.submitButton.enabled = YES;
                self.submitButton.hidden = NO;
            } else {
                self.submitButton.hidden = NO;
                self.submitButton.enabled = NO;
            }
        } else {
            self.submitButton.hidden = NO;
            self.submitButton.enabled = NO;
        }
    } else if (whiteRiskStatus == 1) {
        //  已通过审核
        self.submitButton.hidden = YES;
    } else if (whiteRiskStatus == 2) {
        //  审核中
        self.submitButton.hidden = NO;
        [self.submitButton setTitle:@"审核中" forState:UIControlStateNormal];
        self.submitButton.enabled = NO;
    }
}

/** 获取分期商城认证信息成功 */
- (void)requestMallCreditAuthInfoSuccess:(LSMallCreditInfoModel *)mallCreditAuthInfoModel
{
    if (mallCreditAuthInfoModel) {
        self.mallLoanInfoModel = mallCreditAuthInfoModel;
        
        self.creditAuthView.mallLoanInfoModel = mallCreditAuthInfoModel;
        
        [self updateMallLoanSubmitButtonState];
        
        // 更新进度条
        if ([self isCanSubmitMallLoan]) {
            self.progressView.progressType = AuthenProgressSubmitMallLoan;
            [self.progressView startAnimationWithProgessType:AuthenProgressSubmitMallLoan];
        }else{
            self.progressView.progressType = AuthenProgressNoSubmitWhiteLoan;
            [self.progressView startAnimationWithProgessType:AuthenProgressNoSubmitWhiteLoan];
        }
    }
}

/** 更新消费分期提交认证按钮 */
- (void)updateMallLoanSubmitButtonState{
    /** 是否走过认证的强风控【0:未审核A，-1:未通过审核N，2: 审核中P，1:已通过审核Y】 */
    self.submitButton.enabled = YES;
    [self.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
    NSInteger mallRiskStatus = self.mallLoanInfoModel.mallStatus;
    if (mallRiskStatus == -1) {
        //  未通过审核
        self.submitButton.hidden = NO;
        self.submitButton.enabled = NO;
    } else if (mallRiskStatus == 0) {
        //  未审核
        if (self.mallLoanInfoModel.realnameStatus == 1 && self.mallLoanInfoModel.bindCard == 1 && self.mallLoanInfoModel.zmStatus == 1 && self.mallLoanInfoModel.mobileStatus == 1 && self.mallLoanInfoModel.contactsStatus == 1) {
            if (self.mallLoanInfoModel.jingdongStatus == 1 || self.mallLoanInfoModel.taobaoStatus == 1) {
                self.submitButton.enabled = YES;
                self.submitButton.hidden = NO;
            } else {
                self.submitButton.hidden = NO;
                self.submitButton.enabled = NO;
            }
        } else {
            self.submitButton.hidden = NO;
            self.submitButton.enabled = NO;
        }
    } else if (mallRiskStatus == 1) {
        //  已通过审核
        self.submitButton.hidden = YES;
    } else if (mallRiskStatus == 2) {
        //  审核中
        self.submitButton.hidden = NO;
        [self.submitButton setTitle:@"审核中" forState:UIControlStateNormal];
        self.submitButton.enabled = NO;
    }
}

/** 提交强分控成功 */
- (void)requestSubmitStrongRiskSuccess:(NSDictionary *)successDict{
    [self.submitButton setTitle:@"审核中" forState:UIControlStateNormal];
    self.submitButton.enabled = NO;

    if (_authType == WhiteLoanType) {
       
    } else if (_authType == ConsumeLoanType) {
        //  消费贷认证成功
        LSCreditCheckViewController * cheakVC = [[LSCreditCheckViewController alloc] init];
        cheakVC.animationTime = [successDict[@"animationTime"] integerValue];
        [self.navigationController pushViewController:cheakVC animated:YES];
    } else if (_authType == MallLoanType) {
        // 消费分期认证
        [self.authViewModel requestCreditAuthInfoStatusWithType:@"3"];
    }
}

#pragma mark -
- (void)requestCreditAuthInfoSuccess:(LSAuthInfoModel *)authInfoModel
{
    // 跳转到认证结果页面
    LSAuthResultViewController *authResultVC = [[LSAuthResultViewController alloc] init];
    authResultVC.loanType = MallLoanType;
    authResultVC.authInfoModel = authInfoModel;
    [self.navigationController pushViewController:authResultVC animated:YES];
    
    // 如果是消费分期，发送通知
    if (self.authType == MallLoanType) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KMallAuthSumitedNotifi" object:nil];
    }
}

#pragma mark - 按钮点击事件
#pragma mark 慢必赔活动页点击
- (void)btnBasicsBottomBtnClick{
    if ([self.consumeLoanInfoModel.compensateUrl length]>0) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = self.consumeLoanInfoModel.compensateUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark 提交认证
- (void)submitButtonAction{
    if (_authType == WhiteLoanType) {
        //  白领贷认证
        [self.authViewModel requestSubmitStrongRiskApiWithAuthType:WhiteLoanType entranceType:@"1" Latitude:self.latitudeString Longitude:self.longitudeString];
        //  提交认证pv
        [self whiteLoanSubmitAuthenStatistics];
    } else if (_authType == ConsumeLoanType) {
        //  消费贷认证
        
        [self.authViewModel requestSubmitStrongRiskApiWithAuthType:ConsumeLoanType entranceType:@"1" Latitude:self.latitudeString Longitude:self.longitudeString];
        //  提交认证pv
        [self consumeLoanSubmitAuthenStatistics];
    } else if (_authType == MallLoanType) {
        //  消费分期认证
        [self.authViewModel requestSubmitStrongRiskApiWithAuthType:MallLoanType entranceType:@"1" Latitude:self.latitudeString Longitude:self.longitudeString];
    }
}

#pragma mark - 添加子控件
- (void)configSubViews{
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_WHITE_STR];
    
    /** 认证进度 */
    self.progressView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 45.0);
//    [self.view addSubview:self.progressView];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    if (_authType == WhiteLoanType) {
        //  白领贷
        self.creditAuthView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(420.0)+70.0);
    } else if (_authType == MallLoanType) {
        // 消费分期
        self.creditAuthView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(360.0)+70.0);
    } else {
        //  消费贷
        self.creditAuthView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(240.0));
        /** 慢必赔 */
    }
    [self.mainScrollView addSubview:self.creditAuthView];
    [self.mainScrollView addSubview:self.remindView];
    self.remindView.frame = CGRectMake(0.0, CGRectGetMaxY(self.creditAuthView.frame)+AdaptedHeight(16.0), Main_Screen_Width, 60.0);
    self.submitButton.frame = CGRectMake(AdaptedWidth(20.0), CGRectGetMaxY(self.remindView.frame) + AdaptedHeight(20), Main_Screen_Width - AdaptedWidth(20.0) * 2, AdaptedHeight(44.0));
    /** 提交按钮 */
    [self.mainScrollView addSubview:self.submitButton];
    
    self.mainScrollView.contentSize = CGSizeMake(0.0, self.submitButton.bottom+20.0);
 
    [self.basicsBottomView.btnSubmitBtn addTarget:self action:@selector(btnBasicsBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];

}

//  配置消费贷认证frame
- (void)configConsumeLoanFrame{
    if (_consumeLoanInfoModel.riskStatus == 0 || _consumeLoanInfoModel.riskStatus == 2) {
        //  未审核或者审核中 显示
        self.basicsBottomView.hidden = NO;
        self.basicsBottomView.frame = CGRectMake(0.0, CGRectGetMaxY(self.creditAuthView.frame)+27.0, Main_Screen_Width, 100.0);
    } else {
        self.basicsBottomView.hidden = YES;
    }
    
    if (self.basicsBottomView.isHidden) {
        self.submitButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.creditAuthView.frame) + AdaptedHeight(50), Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
    } else {
        self.submitButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.basicsBottomView.frame) + AdaptedHeight(50), Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
    }
}

#pragma mark - setter getter
- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_mainScrollView setBackgroundColor:[UIColor colorWithHexString:COLOR_WHITE_STR]];
        
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

/** 认证进度 */
- (AuthenProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[AuthenProgressView alloc] init];
        _progressView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 45.0);
    }
    return _progressView;
}

/** 认证表单页 */
- (LSCreditAuthView *)creditAuthView{
    if (_creditAuthView == nil) {
        _creditAuthView = [[LSCreditAuthView alloc] init];
        _creditAuthView.backgroundColor = [UIColor whiteColor];
        _creditAuthView.delegete = self;
    }
    return _creditAuthView;
}

/** 慢必陪 */
- (LSBasicsBottomView *)basicsBottomView{
    if (_basicsBottomView == nil) {
        _basicsBottomView = [[NSBundle mainBundle] loadNibNamed:@"LSBasicsBottomView" owner:nil options:nil].firstObject;
        _basicsBottomView.hidden = YES;
    }
    return _basicsBottomView;
}

/** 温馨提示 */
- (UIView *)remindView{
    if (_remindView == nil) {
        _remindView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 60.0)];
        _remindView.backgroundColor = [UIColor whiteColor];
        
        UILabel *remindLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:13 alignment:NSTextAlignmentLeft];
        [remindLabel setFrame:CGRectMake(AdaptedWidth(20.0), 0.0, Main_Screen_Width-AdaptedWidth(40.0), 24.0)];
        remindLabel.text = @"  *温馨提示";
        [_remindView addSubview:remindLabel];
        
        UILabel *descriptLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:13 alignment:NSTextAlignmentLeft];
        [descriptLabel setFrame:CGRectMake(AdaptedWidth(35), CGRectGetMaxY(remindLabel.frame), Main_Screen_Width-AdaptedWidth(70), 48.0)];
        descriptLabel.numberOfLines = 0;
        descriptLabel.text = @"认证中的状态会在1分钟左右更新，须认证的项目全部变为“已认证”状态后就可提交审核.认证疑问可至""我的-服务中心""寻找答案";
        [_remindView addSubview:descriptLabel];
    }
    return _remindView;
}

/** 提交按钮 */
- (ZTMXFButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
    }
    return _submitButton;
}

- (ZTMXFAuthenticationViewModel *)authViewModel{
    if (_authViewModel == nil) {
        _authViewModel = [[ZTMXFAuthenticationViewModel alloc] init];
        _authViewModel.delegate = self;
    }
    return _authViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 消费贷提交认证
- (void)consumeLoanSubmitAuthenStatistics{
   
}

#pragma mark - 白领贷提交认证
- (void)whiteLoanSubmitAuthenStatistics{
  
}


#pragma mark - 白领贷认证项成功
- (void)whiteLoanAuthItemSuccessStatistics{
  
}

#pragma mark - 消费贷白领贷认证页面pV
- (void)consumeWhiteAuthPageStatistics{
    //  登陆了获取数据
    if (self.authType == ConsumeLoanType) {
        //  强分控通过或者没有通过显示补充认证页面
        // 消费贷认证页面UV
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:@"Home" forKey:@"entrance"];
    } else {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:@"Home" forKey:@"entrance"];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
