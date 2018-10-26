//
//  LSMineHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSMineHeaderView.h"
#import "TopBottomTitleButton.h"
#import "LSMineModel.h"
#import "LSReminderButton.h"
#import "UIImage+addition.h"
#import "LSWaveView.h"
#import "RemainAlertView.h"
#import "LSInstallmentView.h"
#import "LSSettingViewController.h"
#import "UIViewController+Visible.h"
@interface LSMineHeaderView () <LSInstallmentViewDelegete>

/** user name */
@property (nonatomic, strong) UILabel *userNameLabel;
/** 设置 button */
@property (nonatomic, strong) UIButton *setupButton;

/** 我的余额 */
@property (nonatomic, strong) UIButton *myBalanceButton;
@property (nonatomic, strong) UIButton *balanceAmountButton;

/** 登陆 button */
@property (nonatomic, strong) UIButton *loginButton;
/** 登陆imageView */
@property (nonatomic, strong) UIImageView *loginImageView;

/** 分期账单View */
@property (nonatomic, strong) LSInstallmentView *preiodListView;

/** 邀请有礼 button */
@property (nonatomic, strong) TopBottomTitleButton *inviteButton;
/** 优惠券 button */
@property (nonatomic, strong) TopBottomTitleButton *couponButton;
/** 借钱记录 button */
@property (nonatomic, strong) TopBottomTitleButton *loanListButton;
/** 订单管理 button */
@property (nonatomic, strong) TopBottomTitleButton *orderManagerButton;

@property (nonatomic, strong) UILabel *lbBrwInfoLb;

@property (nonatomic, strong) UIButton *btnBrwInfoPromptBtn;

@property (nonatomic, strong) RemainAlertView *remainAlertView;
@property (nonatomic, strong) UIButton *setButton;
@property (nonatomic, strong) UIImageView *iconImageView;


@end

@implementation LSMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.clipsToBounds = YES;
        [self setupViews];
    }
    return self;
}

//  添加子视图
- (void)setupViews{
    //  背景view
    _topBgView = [[UIImageView alloc] init];
    UIImage *bgImage = [UIImage imageNamed:@"XL_Mine_Top"];
    _topBgView.image = bgImage;
    _topBgView.clipsToBounds = NO;
    _topBgView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(137.0));
    [self addSubview:_topBgView];
    
    //  消息中心
    self.messageCenterButton = [LSReminderButton buttonWithType:UIButtonTypeCustom];
    [self.messageCenterButton addTarget:self action:@selector(messageCenterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.messageCenterButton setImage:[UIImage imageNamed:@"XL_Mine_XiaoXi"] forState:UIControlStateNormal];
    self.messageCenterButton.frame = CGRectMake(KW - 75,Status_Bar_Height-6.0, 30.0, 44.0);
    [self addSubview:self.messageCenterButton];
    
    
    _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"XL_Mine_Icon"]];
    [self addSubview:_iconImageView];
    _iconImageView.frame = CGRectMake(20, _topBgView.height - 82, 60, 60);
    
    //  用户名
    self.userNameLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_WHITE_STR] fontSize:15 alignment:NSTextAlignmentLeft];
    self.userNameLabel.frame = CGRectMake(_iconImageView.right + 12, _iconImageView.top, 200, 60);
    self.userNameLabel.font = [UIFont boldSystemFontOfSize:15];
    self.userNameLabel.text = @"";
    [self addSubview:self.userNameLabel];
//
    self.loginImageView = [[UIImageView alloc] init];
    self.loginImageView.image = [UIImage imageWithGIFNamed:@"login"];
    self.loginImageView.frame = CGRectMake((Main_Screen_Width - AdaptedWidth(140.0)) / 2.0, AdaptedHeight(40.0), AdaptedWidth(140.0), AdaptedHeight(70));
    [self addSubview:self.loginImageView];
    self.loginImageView.hidden = YES;
    
    //  登录
    self.loginButton = [UIButton setupButtonWithSuperView:self withObject:self action:@selector(loginButtonAction)];
    [_loginButton setTitle:@"我要登录" forState:UIControlStateNormal];
    _loginButton.layer.cornerRadius = 5;
    _loginButton.layer.borderColor = COLOR_SRT(@"#93CAFD").CGColor;
    _loginButton.layer.borderWidth = 1;
    self.loginButton.frame = CGRectMake((Main_Screen_Width - AdaptedWidth(104.0)) / 2.0, AdaptedHeight(65.0), AdaptedWidth(104.0), AdaptedHeight(32));
    _setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_setButton addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _setButton.frame = CGRectMake(_messageCenterButton.right + 10, _messageCenterButton.top, _messageCenterButton.width, _messageCenterButton.height);
    [_setButton setImage:[UIImage imageNamed:@"XL_Mine_SheZhi"] forState:UIControlStateNormal];
    [self addSubview:_setButton];
    
    [self addSubview:self.preiodListView];
    self.preiodListView.frame = CGRectMake(0.0, CGRectGetMaxY(_topBgView.frame), Main_Screen_Width, 129 * PY);
    self.preiodListView.hidden = YES;
}

- (void)setBtnAction
{
    LSSettingViewController *settingVC = [[LSSettingViewController alloc] init];
    [[UIViewController currentViewController].navigationController pushViewController:settingVC animated:YES];
}

-(UILabel*)lbBrwInfoLb{
    if (!_lbBrwInfoLb) {
        _lbBrwInfoLb = [[UILabel alloc]init];
        [_lbBrwInfoLb setFrame:CGRectMake(0.0, AdaptedHeight(55.0), Main_Screen_Width, AdaptedHeight(20))];
        [_lbBrwInfoLb setTextColor:[UIColor whiteColor]];
        _lbBrwInfoLb.font = [UIFont systemFontOfSize:13];
        _lbBrwInfoLb.textAlignment = NSTextAlignmentCenter;
    }
    return _lbBrwInfoLb;
}

-(UIButton*)btnBrwInfoPromptBtn{
    if (!_btnBrwInfoPromptBtn) {
        _btnBrwInfoPromptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBrwInfoPromptBtn setFrame:CGRectMake(0, 0,_lbBrwInfoLb.width, _lbBrwInfoLb.height)];
        [_btnBrwInfoPromptBtn addTarget:self action:@selector(btnBrwInfoPromptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBrwInfoPromptBtn;
}

-(RemainAlertView *)remainAlertView{
    if (!_remainAlertView) {
        _remainAlertView = [[RemainAlertView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    }
    return _remainAlertView;
}

- (LSInstallmentView *)preiodListView{
    if (_preiodListView == nil) {
        _preiodListView = [[LSInstallmentView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 129 * PY)];
        _preiodListView.delegete = self;
    }
    return _preiodListView;
}

#pragma mark - 点击余额按钮
- (void)btnBrwInfoPromptBtnClick:(UIButton *)sender{
    NSLog(@"点击余额");
    [self.remainAlertView show];
}

//  设置页面数据
- (void)setMineModel:(LSMineModel *)mineModel{
    if (_mineModel != mineModel) {
        _mineModel = mineModel;
    }
    if (!_mineModel) {
        self.preiodListView.hidden = YES;
        self.loginButton.hidden = NO;
        self.iconImageView.hidden = YES;
        self.loginImageView.hidden = YES;
//        [self showPeriodBillView:NO];
        //  昵称
        self.userNameLabel.text = @"";
        self.lbBrwInfoLb.hidden = YES;
        self.balanceAmountButton.hidden = YES;
        self.couponButton.reminderCount = @"0";
        [self.messageCenterButton showReminderCount:@"0"];
        
        self.preiodListView.returnTimeLabel.text = @"";
        self.preiodListView.nowReturnMoneyLabel.text = @"0.00";
        self.preiodListView.residueReturnMoneyLabel.text = @"0.00";
        
    } else{
        self.preiodListView.hidden = NO;

        self.userNameLabel.text = [NSString phoneNumberTransform:[LoginManager userPhone]];;
        self.iconImageView.hidden = NO;

        self.loginButton.hidden = YES;
        self.loginImageView.hidden = YES;
        self.lbBrwInfoLb.hidden = NO;
        self.balanceAmountButton.hidden = NO;
        if (!kStringIsEmpty(self.mineModel.couponCount)) {
            self.couponButton.reminderCount = self.mineModel.couponCount;
        } else {
            self.couponButton.reminderCount = @"0";
        }
        if (!kStringIsEmpty(_mineModel.rebateAmount)) {
            if ([_mineModel.rebateAmount floatValue] <= 0) {
                [self.balanceAmountButton setTitle:@"0.00" forState:UIControlStateNormal];
            } else {
                [self.balanceAmountButton setTitle:_mineModel.rebateAmount forState:UIControlStateNormal];
            }
        } else {
            [self.balanceAmountButton setTitle:@"0.00" forState:UIControlStateNormal];
        }
        
        NSInteger unreadMessageCount = [LSNotificationModel notifi_updateAllNumNotificationInfoNotRead];
        if (unreadMessageCount > 0) {
            [self.messageCenterButton showReminderCount:[NSString stringWithFormat:@"%ld", unreadMessageCount]];
        } else {
            [self.messageCenterButton showReminderCount:@"0"];
        }
        
        // 分期账单
        if (self.mineModel.repayDay > 0) {
            self.preiodListView.returnTimeLabel.text = [NSString stringWithFormat:@"每月%ld日还款",self.mineModel.repayDay];
            self.preiodListView.nowReturnMoneyLabel.text = [NSDecimalNumber stringWithFloatValue:self.mineModel.billAmount];
            self.preiodListView.residueReturnMoneyLabel.text = [NSDecimalNumber stringWithFloatValue:self.mineModel.surplusBillAmount];
        } else {
            self.preiodListView.returnTimeLabel.text = @"";
            self.preiodListView.nowReturnMoneyLabel.text = @"0.00";
            self.preiodListView.residueReturnMoneyLabel.text = @"0.00";
        }
        
        if ([LoginManager appReviewState]) {
             self.preiodListView.hidden = YES;
        }else{
            
        }
        
        
        if (self.mineModel.inviteSwitch == 1) {
            //  显示邀请有礼
            [self showInviteButton:YES];
        } else {
            //  不显示邀请有礼
            [self showInviteButton:NO];
        }
        [self showPeriodBillView:YES];
    }
}

#pragma mark - LSInstallmentViewDelegete
#pragma mark - 点击分期账单
- (void)jumpToBillPeriodsVC{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickPreiodList)]) {
        [self.delegate mineTableHeaderViewClickPreiodList];
    }
}

#pragma mark - 点击事件
//  邀请有礼
- (void)inviteButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickInvite)]) {
        [self.delegate mineTableHeaderViewClickInvite];
    }
}

//  点击还款记录
- (void)boneListButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickLoanList)]) {
        [self.delegate mineTableHeaderViewClickLoanList];
    }
}

//  订单点击
- (void)orderButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickOrder)]) {
        [self.delegate mineTableHeaderViewClickOrder];
    }
}

//  优惠券点击
- (void)couponButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickCoupon)]) {
        [self.delegate mineTableHeaderViewClickCoupon];
    }
}

//  优惠券
- (void)loginButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickLogin)]) {
        [self.delegate mineTableHeaderViewClickLogin];
    }
}

//  点击设置按钮
- (void)setupButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickSetup)]) {
        [self.delegate mineTableHeaderViewClickSetup];
    }
}

//  点击消息中心
- (void)messageCenterButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickMessageCenter)]) {
        [self.delegate mineTableHeaderViewClickMessageCenter];
    }
}

//  点击余额
- (void)balanceAmountButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineTableHeaderViewClickBalance)]) {
        [self.delegate mineTableHeaderViewClickBalance];
    }
}

- (void)hiddenLoginButton:(BOOL)state{
    if (state) {
        self.loginButton.hidden = YES;
    } else {
        self.loginButton.hidden = NO;
    }
}

- (void)showInviteButton:(BOOL)show{
    CGFloat buttonWidth = Main_Screen_Width / 4.0;
    CGFloat buttonHeight = AdaptedHeight(80.0);
    if (show) {
        self.inviteButton.hidden = NO;
        self.orderManagerButton.hidden = NO;
        self.loanListButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.topBgView.frame), buttonWidth, buttonHeight);
        self.orderManagerButton.frame = CGRectMake(CGRectGetMaxX(self.loanListButton.frame), CGRectGetMinY(self.loanListButton.frame), buttonWidth, buttonHeight);
        self.couponButton.frame = CGRectMake(CGRectGetMaxX(self.orderManagerButton.frame), CGRectGetMinY(self.loanListButton.frame), buttonWidth, buttonHeight);
        self.inviteButton.frame = CGRectMake(CGRectGetMaxX(self.couponButton.frame), CGRectGetMinY(self.loanListButton.frame), buttonWidth, buttonHeight);
    } else {
        self.inviteButton.hidden = YES;
        self.orderManagerButton.hidden = YES;
        self.loanListButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.topBgView.frame), buttonWidth, buttonHeight);
        self.couponButton.frame = CGRectMake(CGRectGetMaxX(self.loanListButton.frame), CGRectGetMinY(self.loanListButton.frame), buttonWidth, buttonHeight);
    }
}

- (void)showPeriodBillView:(BOOL)show{
    CGFloat buttonWidth = Main_Screen_Width / 4.0;
    CGFloat buttonHeight = AdaptedHeight(80.0);
    if (show) {
        self.preiodListView.hidden = NO;
        if ([LoginManager appReviewState]) {
            self.preiodListView.hidden = YES;
        }
        self.loanListButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.preiodListView.frame)+10.0, buttonWidth, buttonHeight);
    } else {
        self.preiodListView.hidden = YES;
        self.loanListButton.frame = CGRectMake(0.0, CGRectGetMaxY(self.topBgView.frame), buttonWidth, buttonHeight);
    }
    self.orderManagerButton.frame = CGRectMake(CGRectGetMaxX(self.loanListButton.frame), CGRectGetMinY(self.loanListButton.frame), buttonWidth, buttonHeight);
    self.couponButton.frame = CGRectMake(CGRectGetMaxX(self.orderManagerButton.frame), CGRectGetMinY(self.loanListButton.frame), buttonWidth, buttonHeight);
    self.inviteButton.frame = CGRectMake(CGRectGetMaxX(self.couponButton.frame), CGRectGetMinY(self.loanListButton.frame), buttonWidth, buttonHeight);
}




@end

