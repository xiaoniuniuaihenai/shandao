//
//  LSCreditAmountViewController.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/9/15.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "LSCreditAmountViewController.h"
#import "RealNameManager.h"
#import "LSPeriodAuthView.h"
#import "LSCreditAmountHeaderView.h"

#import "LSAuthInfoModel.h"
#import "LSCreditAuthModel.h"
#import "LSCreditAuthViewModel.h"

#import "LSAuthResultViewController.h"

@interface LSCreditAmountViewController ()<UIScrollViewDelegate,PeriodAuthViewDelegete,LSCreditAuthViewModelDelegete>
/** scrollView */
@property (nonatomic, strong) UIScrollView      *scrollView;
/** headerView */
@property (nonatomic, strong) LSCreditAmountHeaderView *authHeaderView;

/** 2.0商城 */
/** 分期商城认证view */
@property (nonatomic, strong) LSPeriodAuthView *periodAuthView;

/** 额度页面数据Model */
@property (nonatomic, strong) LSCreditAuthModel *creditAuthModel;
/** 额度页面数据ViewModel */
@property (nonatomic, strong) LSCreditAuthViewModel *creditAuthViewModel;

@property (nonatomic, assign) LoanType creditAuthType;

@end

@implementation LSCreditAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    隐藏导航
    self.title = @"认证中心";
//    self.fd_prefersNavigationBarHidden = YES;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_WHITE_STR]];
    [self configueSubViews];
    
    //  监听退出登陆
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AmountPagelogoutSuccess) name:kLogoutSuccess object:nil];
    // 审核状态刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creditAuthStatusChange) name:kCreditAuthStatusPushNotification object:nil];
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //  设置状态栏颜色
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([LoginManager loginState]) {
        //  登陆了获取数据
        [self.creditAuthViewModel requestCreditAuthStatus];
    } else {
        // 获取未登录认证状信息
        [self.creditAuthViewModel requestCreditAuthInfoWithOutLogin];
    }
}
#pragma mark - PeriodAuthViewDelegete


#pragma mark - 获取认证状态信息
- (void)requestCreditAuthInfoSuccess:(LSAuthInfoModel *)authInfoModel
{
    if (authInfoModel.currentAuthStatus == 0) {
        // 未认证
        if (authInfoModel.facesStatus != 1) {
            // 跳转到实名认证
            [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES loanType:self.creditAuthType];
        } else if (authInfoModel.bindCard != 1) {
            // 跳转到绑卡认证
            [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES loanType:self.creditAuthType];
        }  else {
            // 跳转到认证表单页
            if (self.creditAuthType == ConsumeLoanType) {
                // 消费贷认证
                [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressConsumeLoan isSaveBackVcName:NO loanType:ConsumeLoanType];
            } else if (self.creditAuthType == WhiteLoanType) {
                // 白领贷认证
                [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressWhiteLoan isSaveBackVcName:NO loanType:WhiteLoanType];
            } else if (self.creditAuthType == MallLoanType) {
                // 分期商城认证
                [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressMallLoan isSaveBackVcName:NO loanType:MallLoanType];
            }
        }
    } else {
        // 跳转到认证结果页:-1 认证失败 1 认证通过 2 审核中
        LSAuthResultViewController *authResultVC = [[LSAuthResultViewController alloc] init];
        authResultVC.loanType = self.creditAuthType;
        authResultVC.authInfoModel = authInfoModel;
        [self.navigationController pushViewController:authResultVC animated:YES];
    }
}

/** 慢必赔点击 */
- (void)submitConsumeLoanViewClickSlowPay{
    
    if (self.creditAuthModel.banner.isNeedLogin == 1) {
        // 需要登录
        if (![LoginManager loginState]) {
            [LoginManager presentLoginVCWithController:self];
            return;
        } 
    }
    if ([self.creditAuthModel.banner.content length]>0) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = self.creditAuthModel.banner.content;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark - 点击认证
- (void)clickPeriodAuthWithType:(LoanType)periodAuthType
{
    self.creditAuthType = periodAuthType;
    if (![LoginManager loginState]) {
        [LoginManager presentLoginVCWithController:self];
    } else {
        // 请求认证状态接口
        if (periodAuthType == WhiteLoanType) {
            // 点击白领贷认证
            [self.creditAuthViewModel requestCreditAuthInfoStatusWithType:@"1"];
        } else if (periodAuthType == ConsumeLoanType) {
            // 点击消费贷认证
            [self.creditAuthViewModel requestCreditAuthInfoStatusWithType:@"2"];
        } else if (periodAuthType == MallLoanType) {
            // 点击分期商城认证
            [self.creditAuthViewModel requestCreditAuthInfoStatusWithType:@"3"];
        }
    }
}
#pragma mark - LSCreditAuthViewModelDelegete 获取认证页面信息
- (void)requestCreditAuthStatusSuccess:(LSCreditAuthModel *)creditAuthModel
{
    self.creditAuthModel = creditAuthModel;
    //  开始刻度动画
    self.authHeaderView.creditAuthModel = creditAuthModel;
    
    [self.authHeaderView startCreditProgressAnimation];
    
    self.periodAuthView.creditAuthModel = creditAuthModel;
}

#pragma mark -- 下拉刷新
-(void)refreshNormalHeader{
    [self.creditAuthViewModel requestCreditAuthStatus];
}

#pragma mark - 认证状态变更，状态刷新
- (void)creditAuthStatusChange{
    // 获取认证状态信息
    [self.creditAuthViewModel requestCreditAuthStatus];
}

#pragma mark - 退出登陆成功
- (void)AmountPagelogoutSuccess{
    if (!self.periodAuthView.hidden) {
        self.creditAuthModel = nil;
        self.authHeaderView.creditAuthModel = nil;
        [self.authHeaderView startCreditProgressAnimation];
        
        self.periodAuthView.creditAuthModel = nil;
    }
}

#pragma mark - 添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.authHeaderView];
    [self.view addSubview:self.periodAuthView];
    
    self.authHeaderView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, AdaptedHeight(291));
}

#pragma mark - setter/getter
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0.0,k_Navigation_Bar_Height, Main_Screen_Width,Main_Screen_Height-k_Navigation_Bar_Height);
        _scrollView.backgroundColor = [UIColor colorWithHexString:COLOR_WHITE_STR];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        MJRefreshNormalHeader* headerRefresh = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNormalHeader)];
        headerRefresh.lastUpdatedTimeLabel.hidden = YES;
        headerRefresh.stateLabel.hidden = YES;
        _scrollView.mj_header = headerRefresh;
    }
    return _scrollView;
}

- (LSCreditAmountHeaderView *)authHeaderView{
    if (_authHeaderView == nil) {
        _authHeaderView = [[LSCreditAmountHeaderView alloc] init];
        _authHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _authHeaderView;
}

/** 分期商城页面 */
- (LSPeriodAuthView *)periodAuthView{
    if (_periodAuthView == nil) {
        _periodAuthView = [[LSPeriodAuthView alloc] initWithFrame:CGRectMake(AdaptedWidth(16.0), AdaptedHeight(225.0), Main_Screen_Width-AdaptedWidth(32.0), AdaptedHeight(215.0 / 3 * 2)+100.0)];
        _periodAuthView.delegete = self;
    }
    return _periodAuthView;
}

/** 分期商城页面ViewModel */
- (LSCreditAuthViewModel *)creditAuthViewModel
{
    if (_creditAuthViewModel == nil) {
        _creditAuthViewModel = [[LSCreditAuthViewModel alloc] init];
        _creditAuthViewModel.delegete = self;
    }
    return _creditAuthViewModel;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.mj_offsetY <= -80) {
        scrollView.mj_offsetY  = -80;
    }
}

@end
