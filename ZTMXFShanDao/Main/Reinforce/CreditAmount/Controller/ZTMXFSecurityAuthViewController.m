//
//  LSSecurityAuthViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFSecurityAuthViewController.h"
#import "MoxieSDK.h"
#import "LSAuthSupplyApi.h"
#import "ZTMXFAuthenticationViewModel.h"
#import "LSAuthSupplyCertifyModel.h"
#import "LSSecurityAuthView.h"
#import "LSSubmitAuthViewController.h"
#import "RealNameManager.h"
#import "AuthenProgressView.h"

@interface ZTMXFSecurityAuthViewController () <MoxieSDKDelegate,LSSecurityAuthViewDelegete>

/**  1.6版本*/
@property (nonatomic, strong) AuthenProgressView *progressView;

/** 社保、公积金认证view*/
@property (nonatomic, strong) LSSecurityAuthView *securityAuthView;

/** 白领贷认证类型 */
@property (nonatomic, assign) AuthSupplyType authSupplyType;

/** 认证viewModel */
@property (nonatomic, strong) ZTMXFAuthenticationViewModel *authViewModel;

@end

@implementation ZTMXFSecurityAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *title = @"";
    if (self.loanType == WhiteLoanType) {
        title = kCreditAuthen;
    } else if (self.loanType == MallLoanType) {
        title = @"电商认证";
    }
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:title];
    [self set_Title:titleStr];
    
    [self configueSubViews];
    
    //  设置不让侧滑
    self.fd_interactivePopDisabled = YES;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.progressView startAnimationWithProgessType:AuthenProgressSheBaoGongJiJing];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.progressView.progressType = AuthenProgressSheBaoGongJiJing;
}
#pragma mark-  按钮方法
-(void)clickReturnBackEvent{
    //        直接返回根视图
    [RealNameManager realNameBackSuperVc:self];
}

#pragma mark - LSSecurityAuthViewDelegete
#pragma mark - 点击去认证
- (void)clickSecurityAuthBtn:(NSInteger)tag{
    if (tag == 1) {
        if (self.loanType == WhiteLoanType) {
            // 社保认证
            [self startMoXieAuthWithType:AuthSupplyTypeSheBao];
        } else if (self.loanType == MallLoanType) {
            // 京东认证
            [self startMoXieAuthWithType:AuthSupplyTypeJingDong];
        }
    }else if (tag == 2){
        if (self.loanType == WhiteLoanType) {
            // 公积金认证
            [self startMoXieAuthWithType:AuthSupplyTypeGongJiJin];
        } else if (self.loanType == MallLoanType) {
            // 淘宝认证
            [self startMoXieAuthWithType:AuthSupplyTypeTaoBao];
        }
    }
}

#pragma mark - 按钮点击事件
- (void)clickServiceButtonAction{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(serviceCenter);
    [self.navigationController pushViewController:webVC animated:YES];
}



#pragma mark - 魔蝎 认证
//公积金认证  0  社保认证 1
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
//  魔蝎认证结果
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    //  code = -1, 用户未进行操作
    //  code 1,  用户认证成功
    //  code 2,  认证处理中
    int code = [resultDictionary[@"code"] intValue];
    if (code == 1 || code == 2) {
        [self.authViewModel requestPromoteAuthInfoApi];
        
        //  提交魔蝎项认证成功
        [self whiteLoanAuthItemSuccessStatistics];
        
        if (self.loanType == WhiteLoanType) {
            // 跳转到认证表单页
            [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressWhiteLoan isSaveBackVcName:NO loanType:WhiteLoanType];
        } else if (self.loanType == MallLoanType) {
            // 跳转到认证表单页
            [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressMallLoan isSaveBackVcName:NO loanType:MallLoanType];
        }
    }
}

#pragma mark - 白领贷认证项认证入口


#pragma mark - 白领贷认证项成功
- (void)whiteLoanAuthItemSuccessStatistics{
   
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
//    [self.view addSubview:self.progressView];
    [self.view addSubview:self.securityAuthView];
    self.securityAuthView.frame = CGRectMake(0, _progressView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-_progressView.bottom);
}

#pragma mark - setter
- (AuthenProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[AuthenProgressView alloc] init];
        _progressView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 45.0);
    }
    return _progressView;
}

- (LSSecurityAuthView *)securityAuthView{
    if (!_securityAuthView) {
        _securityAuthView = [[LSSecurityAuthView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height)];
        _securityAuthView.loanType = self.loanType;
        _securityAuthView.delegete = self;
    }
    return _securityAuthView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
