//
//  LSCreditAuthenViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditAuthenViewController.h"
#import "LSSegmentView.h"

#import "LSSubmitConsumeLoanView.h"
#import "LSSubmitWhiteLoanView.h"

#import "WJYAlertView.h"
#import "LSAuthSupplyApi.h"
#import "MoxieSDK.h"
#import "ZhiMaCreditModel.h"
#import "AddressBookManager.h"
#import "LSWhiteLoanAuthView.h"
#import "LSSubmitConsumeLoanView.h"
#import "LSPromoteCreditInfoModel.h"
#import "LSAuthSupplyCertifyModel.h"
#import "ZTMXFAuthenticationViewModel.h"

#import "LSCreditAuthWebViewController.h"
#import "LSPhoneOperationAuthViewController.h"
#import "LSSubmitCompanyPhoneViewController.h"
#import "LSCreditCheckViewController.h"

@interface LSCreditAuthenViewController ()<SegmentViewDelegate, AuthenticationViewModelDelegate, SubmitConsumeLoanViewDelegate, SubmitWhiteLoanViewDelegate,MoxieSDKDelegate, AuthenticationViewModelDelegate, SubmitCompanyPhoneViewDelegate, LSCreditAuthWebViewDelegate,LSPhoneOperationAuthViewDelegate>

@property (nonatomic, strong) LSSegmentView *segmentView;
/** 消费贷认证view */
@property (nonatomic, strong) LSSubmitConsumeLoanView *consumeLoanView;
/** 白领贷认证view */
@property (nonatomic, strong) LSSubmitWhiteLoanView *whiteLoanView;

/** 认证viewModel */
@property (nonatomic, strong) ZTMXFAuthenticationViewModel *authViewModel;

/** 消费贷model */
@property (nonatomic, strong) LSPromoteCreditInfoModel *consumeLoanInfoModel;
/** 白领贷Model */
@property (nonatomic, strong) LSAuthSupplyCertifyModel *whiteLoanInfoModel;

@property (nonatomic, assign) BOOL selectConsumeLoan;
@property (nonatomic, assign) BOOL selectWhiteLoan;
/** 白领贷认证类型 */
@property (nonatomic, assign) AuthSupplyType authSupplyType;

@end

@implementation LSCreditAuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"信用认证";
    [self configSubViews];
    if (_authenType == WhiteCreditAuthen) {
        //  显示白领贷认证
        [self segmentViewSelectIndex:1];
        [self.segmentView selectWhiteLoanAuth];
    } else {
        //  显示消费贷认证
        [self segmentViewSelectIndex:0];
        [self.segmentView selectConsumeLoanAuth];
    }
    
    /** 获取消费贷认证数据 */
    [self.authViewModel requestBaseAuthInfoApi];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - SegmentViewDelegate
- (void)segmentViewSelectIndex:(NSInteger)index{
    if (index == 0) {
        self.consumeLoanView.hidden = NO;
        self.whiteLoanView.hidden = YES;
        if (!self.selectConsumeLoan) {
            self.selectConsumeLoan = YES;
            //  认证入口pv
            [self consumeWhiteAuthPageStatistics];
        }

    } else {
        self.consumeLoanView.hidden = YES;
        self.whiteLoanView.hidden = NO;
        if (!self.selectWhiteLoan) {
            self.selectWhiteLoan = YES;
            //  认证入口pv
            [self consumeWhiteAuthPageStatistics];
        }
    }
}

#pragma mark - BaseAuthViewDelegate

/** 点击运营商 */
- (void)submitConsumeLoanViewClickPhoneOperation{
    if (self.consumeLoanInfoModel.mobileStatus == -1) {
        //  运营商认证失败
        [WJYAlertView showTwoButtonsWithTitle:@"" Message:@"您好, 您本次认证未通过! 您可以核对身份信息后, 重新尝试认证." ButtonType:WJYAlertViewButtonTypeCancel ButtonTitle:@"暂不认证" Click:^{
        } ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"重新认证" Click:^{
            // 重新认证运营商
            LSPhoneOperationAuthViewController *VC = [[LSPhoneOperationAuthViewController alloc] init];
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }];
    } else if (self.consumeLoanInfoModel.mobileStatus == 0) {
        //  未认证
        [WJYAlertView showOneButtonWithTitle:@"认证提示" Message:@"手机运营商认证需授权通讯录权限\n授权请选择同意" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"我知道了" Click:^{
            LSPhoneOperationAuthViewController *VC = [[LSPhoneOperationAuthViewController alloc] init];
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }];
        
    } else if(self.consumeLoanInfoModel.mobileStatus ==2) {
        //  手机运营商品认证中
        [self.view makeCenterToast:@"运营商正在认证中，请耐心等待"];
    } else if (self.consumeLoanInfoModel.mobileStatus == 1) {
        //  手机运营商品认证成功
        if (self.consumeLoanInfoModel.riskStatus == 1) {
            //  强风控通过那么就会有额度
            [self.view makeCenterToast:@"运营商已认证"];
        }
    }
}
/** 点击芝麻信用 */
- (void)submitConsumeLoanViewClickZhiMaCredit{
    if (self.consumeLoanInfoModel.zmModel.zmStatus ==1) {
        //  芝麻信用授权成功
        [self.view makeCenterToast:@"芝麻信用已认证"];
    } else {
        //  没有芝麻信用授权
        LSCreditAuthWebViewController *VC = [[LSCreditAuthWebViewController alloc] init];
        VC.webUrl = self.consumeLoanInfoModel.zmModel.zmxyAuthUrl;
        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
/** 慢必赔点击 */
- (void)submitConsumeLoanViewClickSlowPay{
    if ([self.consumeLoanInfoModel.compensateUrl length]>0) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = self.consumeLoanInfoModel.compensateUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

/** 提交消费贷认证 */
- (void)submitConsumeLoanViewClickSubmitAuth{
    //  消费贷认证
    [self.authViewModel requestSubmitStrongRiskApiWithAuthType:ConsumeLoanType entranceType:@"1" Latitude:@"" Longitude:@""];
    //  提交消费贷认证
    [self consumeLoanSubmitAuthenStatistics];
}

#pragma mark - WhiteLoanAuthViewDelegate
/** 点击社保 */
- (void)submitWhiteLoanViewClickSocialSecurity{
    if (self.whiteLoanInfoModel.socialSecurityStatus == 0 || self.whiteLoanInfoModel.socialSecurityStatus == -1) {
        [self startMoXieAuthWithType:AuthSupplyTypeSheBao];
    } else if (self.whiteLoanInfoModel.socialSecurityStatus == 2){
        [self.view makeCenterToast:@"社保正在认证中，请耐心等待"];
    } else if (self.whiteLoanInfoModel.socialSecurityStatus == 1){
        [self.view makeCenterToast:@"社保已认证"];
    }
}
/** 点击公积金 */
- (void)submitWhiteLoanViewClickProvidentFund{
    if (self.whiteLoanInfoModel.fundStatus == 0 || self.whiteLoanInfoModel.fundStatus == -1) {
        [self startMoXieAuthWithType:AuthSupplyTypeGongJiJin];
    } else if (self.whiteLoanInfoModel.fundStatus ==2){
        [self.view makeCenterToast:@"公积金正在认证中，请耐心等待"];
    } else if (self.whiteLoanInfoModel.fundStatus ==1){
        [self.view makeCenterToast:@"公积金已认证"];
    }
    
}
/** 公司电话 */
- (void)submitWhiteLoanViewClickCompanyPhone{
    if (self.whiteLoanInfoModel) {
        //  未审核的时候才可以修改
        if (self.whiteLoanInfoModel.whiteRisk == 0) {
            LSSubmitCompanyPhoneViewController *companyPhoneVC = [[LSSubmitCompanyPhoneViewController alloc] init];
            companyPhoneVC.delegate = self;
            companyPhoneVC.companyPhone = self.whiteLoanInfoModel.phoneAuth;
            [self.navigationController pushViewController:companyPhoneVC animated:YES];
        }
    }
}



/** 提交白领贷认证 */
- (void)submitWhiteLoanViewClickSubmitAuth{
    [self.authViewModel requestSubmitStrongRiskApiWithAuthType:WhiteLoanType entranceType:@"1" Latitude:@"" Longitude:@""];
    // 白领贷认证页面UV
    [self whiteLoanSubmitAuthenStatistics];
}
/** 慢必赔点击 */
- (void)submitWhiteLoanViewClickSlowPay{
    if ([self.consumeLoanInfoModel.compensateUrl length]>0) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = self.consumeLoanInfoModel.compensateUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark - SubmitCompanyPhoneViewDelegate 提交公司电话认证
- (void)submitCompanyPhoneViewSuccess:(NSString *)companyPhone{
    self.whiteLoanInfoModel.phoneAuth = companyPhone;
    self.whiteLoanView.whiteLoanModel = self.whiteLoanInfoModel;
}

#pragma mark - LSCreditAuthWebViewDelegate 芝麻信用认证结果
- (void)creditAuthWebViewCreditScore:(ZhiMaCreditModel *)creditModel{
    self.consumeLoanInfoModel.zmModel.zmStatus = 1;
    self.consumeLoanInfoModel.zmModel.zmScore = creditModel.zmScore;
    self.consumeLoanView.consumeLoanInfoModel = self.consumeLoanInfoModel;
}

#pragma mark - LSPhoneOperationAuthViewDelegate 运营商认证成功
- (void)phoneOperationAuthViewSuccessAuth{
    self.consumeLoanInfoModel.mobileStatus = 1;
    self.consumeLoanView.consumeLoanInfoModel = self.consumeLoanInfoModel;
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
        [self.authViewModel requestPromoteAuthInfoApi];
        //  认证成功
        [self whiteLoanAuthItemSuccessStatistics];
    }
}

#pragma mark - AuthenticationViewModelDelegate获取认证页面信息
/** 获取消费贷认证信息成功 */
- (void)requestBaseAuthSuccess:(LSPromoteCreditInfoModel *)baseAuthInfoModel{
    if (baseAuthInfoModel) {
        self.consumeLoanInfoModel = baseAuthInfoModel;
        self.consumeLoanView.consumeLoanInfoModel = baseAuthInfoModel;
        [self updateConsumeLoanSubmitButtonState];
    }
    /** 获取白领贷认证数据 */
    [self.authViewModel requestPromoteAuthInfoApi];
}


/** 更新消费贷提交认证按钮 */
- (void)updateConsumeLoanSubmitButtonState{
    /** 是否走过认证的强风控【0:未审核A，-1:未通过审核N，2: 审核中P，1:已通过审核Y】 */
    self.consumeLoanView.submitButton.enabled = YES;
    [self.consumeLoanView.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
    NSInteger consumeRiskStatus = self.consumeLoanInfoModel.riskStatus;
    if (consumeRiskStatus == -1) {
        //  未通过审核
        if (!kStringIsEmpty(self.consumeLoanInfoModel.riskRetrialRemind)) {
            self.consumeLoanView.submitButton.hidden = NO;
            self.consumeLoanView.submitButton.enabled = NO;
            [self.consumeLoanView.submitButton setTitle:self.consumeLoanInfoModel.riskRetrialRemind forState:UIControlStateNormal];
        } else {
            self.consumeLoanView.submitButton.hidden = YES;
        }
    } else if (consumeRiskStatus == 0) {
        //  未审核
        if (self.consumeLoanInfoModel.zmModel.zmStatus == 1 && self.consumeLoanInfoModel.mobileStatus == 1 && self.consumeLoanInfoModel.contactsStatus == 1) {
            self.consumeLoanView.submitButton.enabled = YES;
            self.consumeLoanView.submitButton.hidden = NO;
        } else {
            self.consumeLoanView.submitButton.hidden = NO;
            self.consumeLoanView.submitButton.enabled = NO;
        }
    } else if (consumeRiskStatus == 1) {
        //  已通过审核
        self.consumeLoanView.submitButton.hidden = YES;
    } else if (consumeRiskStatus == 2) {
        //  审核中
        self.consumeLoanView.submitButton.hidden = NO;
        [self.consumeLoanView.submitButton setTitle:@"审核中" forState:UIControlStateNormal];
        self.consumeLoanView.submitButton.enabled = NO;
    }
    
}

/** 获取白领贷认证信息成功 */
- (void)requestPromoteAuthSuccess:(LSAuthSupplyCertifyModel *)promoteAuthInfoModel{
    if (promoteAuthInfoModel) {
        self.whiteLoanInfoModel = promoteAuthInfoModel;
        self.whiteLoanView.whiteLoanModel = promoteAuthInfoModel;
        [self updateWhiteLoanSubmitButtonState];
    }
}

/** 更新白领贷提交认证按钮 */
- (void)updateWhiteLoanSubmitButtonState{
    /** 是否走过认证的强风控【0:未审核A，-1:未通过审核N，2: 审核中P，1:已通过审核Y】 */
    [self.whiteLoanView.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
    self.whiteLoanView.submitButton.enabled = YES;
    NSInteger whiteRiskStatus = self.whiteLoanInfoModel.whiteRisk;
    if (whiteRiskStatus == -1) {
        //  未通过审核
        if (!kStringIsEmpty(self.whiteLoanInfoModel.whiteRiskRemind)) {
            self.whiteLoanView.submitButton.hidden = NO;
            self.whiteLoanView.submitButton.enabled = NO;
            [self.whiteLoanView.submitButton setTitle:self.whiteLoanInfoModel.whiteRiskRemind forState:UIControlStateNormal];
        } else {
            self.whiteLoanView.submitButton.hidden = YES;
        }
    } else if (whiteRiskStatus == 0) {
        //  未审核
        if (self.consumeLoanInfoModel.zmModel.zmStatus == 1 && self.consumeLoanInfoModel.mobileStatus == 1 && self.consumeLoanInfoModel.contactsStatus == 1 && (self.whiteLoanInfoModel.phoneAuth.length > 0) ) {
            if (self.whiteLoanInfoModel.fundStatus == 1 || self.whiteLoanInfoModel.socialSecurityStatus == 1) {
                self.whiteLoanView.submitButton.enabled = YES;
                self.whiteLoanView.submitButton.hidden = NO;
            } else {
                self.whiteLoanView.submitButton.hidden = NO;
                self.whiteLoanView.submitButton.enabled = NO;
            }
        } else {
            self.whiteLoanView.submitButton.hidden = NO;
            self.whiteLoanView.submitButton.enabled = NO;
        }
    } else if (whiteRiskStatus == 1) {
        //  已通过审核
        self.whiteLoanView.submitButton.hidden = YES;
    } else if (whiteRiskStatus == 2) {
        //  审核中
        self.whiteLoanView.submitButton.hidden = NO;
        [self.whiteLoanView.submitButton setTitle:@"审核中" forState:UIControlStateNormal];
        self.whiteLoanView.submitButton.enabled = NO;
    }
}

/** 提交强分控成功 */
- (void)requestSubmitStrongRiskSuccess:(NSDictionary *)successDict{
    if (!self.whiteLoanView.isHidden) {
       

    
    } else {
        [self.consumeLoanView.submitButton setTitle:@"审核中" forState:UIControlStateNormal];
        self.consumeLoanView.submitButton.enabled = NO;
        //  消费贷认证成功
        LSCreditCheckViewController * cheakVC = [[LSCreditCheckViewController alloc] init];
        cheakVC.animationTime = [successDict[@"animationTime"] integerValue];
        [self.navigationController pushViewController:cheakVC animated:YES];
    }
}

#pragma mark - configSubViews
- (void)configSubViews{
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.consumeLoanView];
    [self.view addSubview:self.whiteLoanView];
    self.whiteLoanView.hidden = YES;
    
    self.segmentView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, AdaptedHeight(50.0));
    self.consumeLoanView.frame = CGRectMake(0.0, CGRectGetMaxY(self.segmentView.frame), Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    self.whiteLoanView.frame = CGRectMake(0.0, CGRectGetMaxY(self.segmentView.frame), Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
}

#pragma mark - setter getter
/** 消费贷页面 */
- (LSSubmitConsumeLoanView *)consumeLoanView{
    if (_consumeLoanView == nil) {
        _consumeLoanView = [[LSSubmitConsumeLoanView alloc] init];
        _consumeLoanView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _consumeLoanView.delegate = self;
    }
    return _consumeLoanView;
}

/** 白领贷页面 */
- (LSSubmitWhiteLoanView *)whiteLoanView{
    if (_whiteLoanView == nil) {
        _whiteLoanView = [[LSSubmitWhiteLoanView alloc] init];
        _whiteLoanView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _whiteLoanView.delegate = self;
    }
    return _whiteLoanView;
}

-  (LSSegmentView *)segmentView{
    if (_segmentView == nil) {
        _segmentView = [[LSSegmentView alloc] init];
        _segmentView.backgroundColor = [UIColor whiteColor];
        _segmentView.delegate = self;
    }
    return _segmentView;
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
#warning - 消费贷提交认证
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"Home" forKey:@"entrance"];
}

#pragma mark - 白领贷提交认证
- (void)whiteLoanSubmitAuthenStatistics{
#warning - 白领贷提交认证
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"Home" forKey:@"entrance"];
    
}

#pragma mark - 白领贷认证项认证入口


#pragma mark - 白领贷认证项成功
- (void)whiteLoanAuthItemSuccessStatistics{
   
}

#pragma mark - 消费贷白领贷认证页面pV
- (void)consumeWhiteAuthPageStatistics{
    //  登陆了获取数据
    if (_authenType == ConsumeCreditAuthen) {
        //  强分控通过或者没有通过显示补充认证页面
        // 消费贷认证页面UV
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:@"Home" forKey:@"entrance"];
    } else {
        // 白领贷认证页面UV
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:@"Home" forKey:@"entrance"];
    }
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
