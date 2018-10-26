//
//  LSCreditCheckViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditCheckViewController.h"
#import "LSWebViewController.h"

#import "LSCreditBasicsPassView.h"
#import "LSCreditBasicsTimerEndView.h"
#import "LSCreditBasicWaitView.h"
#import "RealNameManager.h"
#import "LSCreditPassAlertView.h"
/** 1.4 版本*/
#import "LSCreditPassModel.h"
#import "ZTMXFAuthSuccessViewController.h"
#import "LSConsumeLoanAuthReviewViewController.h"

@interface LSCreditCheckViewController ()<LSCreditBasicsPassViewDelegate,LSCreditBasicsTimerEndViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
// 强风控通过
@property (nonatomic,strong) LSCreditBasicsPassView * viPassView;
// 动效 倒计时结束
@property (nonatomic,strong) LSCreditBasicsTimerEndView * viTimerEndView;
// 等待
@property (nonatomic,strong) LSCreditBasicWaitView * viWaitView;

// 弹窗
@property (nonatomic,strong) LSCreditPassAlertView * alertPaidView;

@end

@implementation LSCreditCheckViewController



-(void)dealloc{


}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = kCreditAuthen;
    //  设置不让侧滑
    self.fd_interactivePopDisabled = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.hidesBackButton = YES;
    [self setupUI];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_viWaitView removeTimer];

}

- (UIButton *)set_leftButton{
    return nil;
}
#pragma mark-  原生代理

#pragma mark ---  审核未通过
-(void)notCreditCheckStrongRiskFail:(NSNotification*)not{
    [_viWaitView removeTimer];

}
#pragma mark ---- 审核通过
-(void)notCreditCheckStrongRiskSucceed:(NSNotification*)not{
    // 当前页收到通知
    [_viWaitView removeTimer];
    [self startAnimateIsTimerEnd:NO];
    
    
}
#pragma mark-  自定义代理
#pragma mark ----
#pragma mark --- 强风控通过  点击跳转借钱
-(void)creditBasicePassGoBorrowMoney{
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark ----
#pragma mark ----- 返回
-(void)creditBasiceTimerEndSubmitClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-  按钮方法

#pragma mark-  私有方法
#pragma mark -- type  o
-(void)startAnimateIsTimerEnd:(BOOL)isTimerEnd{
    _viPassView.hidden = isTimerEnd;
    _viTimerEndView.hidden = !isTimerEnd;
    _viTimerEndView.userInteractionEnabled = NO;
    _viPassView.userInteractionEnabled = NO;
    _viWaitView.userInteractionEnabled = NO;
    [UIView animateWithDuration:1 animations:^{
        _scrollView.mj_offsetX = _scrollView.width;
    } completion:^(BOOL finished) {
        _viTimerEndView.userInteractionEnabled = YES;
        _viPassView.userInteractionEnabled = YES;
        _viWaitView.userInteractionEnabled = YES;
    }];
}
#pragma mark - 添加子视图
-(void)setupUI{
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.viPassView];

    if (_creditDict) {
        // 不是当前页过来
        [_scrollView addSubview:self.viPassView];
        // 1.4 版本
        LSCreditPassModel *passModel = [LSCreditPassModel mj_objectWithKeyValues:_creditDict];
        _viPassView.creditPassModel = passModel;
                
    }else{
        [_scrollView addSubview:self.viWaitView];
        [_scrollView addSubview:self.viPassView];
        [_scrollView addSubview:self.viTimerEndView];
        
        _viWaitView.left = 0;
        _viTimerEndView.left = _viWaitView.right;
        _viPassView.left = _viWaitView.right;
        _viTimerEndView.hidden = YES;
        _viPassView.hidden = YES;
        MJWeakSelf
        [_viWaitView startCountdownWithTimerOut:_animationTime block:^{
            [weakSelf startAnimateIsTimerEnd:YES];
//            NSLog(@"倒计时结束");
            //  进入人审页面
            LSConsumeLoanAuthReviewViewController *vc = [[LSConsumeLoanAuthReviewViewController alloc] init];
            vc.authTitle = @"雾霾太大，看不到额度页面啦～\n请稍后刷新查看吧！";
            vc.authDescribe = @"有任何疑问请向在线客服小伙伴反馈哦!";
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
}
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [_scrollView setFrame:CGRectMake(0,0, Main_Screen_Width, Main_Screen_Height-TabBar_Addition_Height)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(LSCreditBasicsPassView*)viPassView{
    if (!_viPassView) {
        _viPassView = [[LSCreditBasicsPassView alloc]init];
        [_viPassView setFrame:CGRectMake(0, 0, Main_Screen_Width, _scrollView.height)];
        [_viPassView setBackgroundColor:[UIColor whiteColor]];
        _viPassView.delegate = self;
        
    }
    return _viPassView;
}

-(LSCreditBasicWaitView*)viWaitView{
    if (!_viWaitView) {
        
        _viWaitView = [[LSCreditBasicWaitView alloc]init];
        [_viWaitView setFrame:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
        [_viWaitView setBackgroundColor:[UIColor whiteColor]];
        [ZTMXFUMengHelper mqEvent:k_credit_ing1_pv];
    }
    return _viWaitView;
}
-(LSCreditBasicsTimerEndView*)viTimerEndView{
    if (!_viTimerEndView) {
        _viTimerEndView = [[LSCreditBasicsTimerEndView alloc]init];
        [_viTimerEndView setFrame:CGRectMake(0, 0, Main_Screen_Width, _scrollView.height)];
        [_viTimerEndView setBackgroundColor:[UIColor whiteColor]];
        _viTimerEndView.delegate = self;
    }
    return _viTimerEndView;
}
-(LSCreditPassAlertView *)alertPaidView{
    if (!_alertPaidView) {
        _alertPaidView = [[NSBundle mainBundle] loadNibNamed:@"LSCreditPassAlertView" owner:nil options:nil].firstObject;
    }
    return _alertPaidView;
}

- (void)setCreditDict:(NSDictionary *)creditDict{
    _creditDict = creditDict;
}

@end
