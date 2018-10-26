//
//  PayTypePopupView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PayTypePopupView.h"
#import "PasswordFieldView.h"
#import "PayTypeView.h"
#import "PasswordInputView.h"
#import "PayChannelModel.h"
#import "RealNameManager.h"
#import "UIViewController+Visible.h"

@interface PayTypePopupView ()<PayTypeViewDelegate, PasswordInputViewDelegate>

/** 蒙版 view */
@property (nonatomic, strong) UIView                    *maskBackgroundView;
/** 点击蒙版手势 */
@property (nonatomic, strong) UITapGestureRecognizer    *tapMaskViewGesture;
/** 横向滚动View */
@property (nonatomic, strong) UIView                    *whiteBackView;
/** 支付方式view */
@property (nonatomic, strong) PayTypeView               *payTypeView;
/** 密码输入框 */
@property (nonatomic, strong) PasswordInputView         *passwordInputView;

/** 选中渠道model */
@property (nonatomic, strong) PayChannelModel           *selectedChannelModel;

@end

@implementation PayTypePopupView

//  懒加载手势
- (UITapGestureRecognizer *)tapMaskViewGesture{
    if (_tapMaskViewGesture == nil) {
        _tapMaskViewGesture = [[UITapGestureRecognizer alloc] init];
        [_tapMaskViewGesture addTarget:self action:@selector(hiddenView)];
    }
    return _tapMaskViewGesture;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  添加子控件
        [self setupViews];
    }
    return self;
}

//  撤销弹出框
- (void)dismissPopView{
    [self hiddenView];
}

#pragma mark  添加子控件
- (void)setupViews{
    /** 蒙版view */
    self.maskBackgroundView = [[UIView alloc] init];
    self.maskBackgroundView.backgroundColor = [UIColor blackColor];
    self.maskBackgroundView.alpha = 0.0;
    self.maskBackgroundView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.maskBackgroundView];
    [self.maskBackgroundView addGestureRecognizer:self.tapMaskViewGesture];
    
    /** 横向scrollView */
    self.whiteBackView = [[UIView alloc] init];
    self.whiteBackView.backgroundColor = [UIColor whiteColor];
    self.whiteBackView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, PayTypeViewHeight);
    [self addSubview:self.whiteBackView];
    
    /** 其他支付方式 */
    self.payTypeView = [[PayTypeView alloc] init];
    self.payTypeView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, PayTypeViewHeight);
    self.payTypeView.delegate = self;
    [self.whiteBackView addSubview:self.payTypeView];
    
    /** 密码输入框 */
    self.passwordInputView = [[PasswordInputView alloc] init];
    self.passwordInputView.frame = CGRectMake(SCREEN_WIDTH, 0.0, CGRectGetWidth(self.whiteBackView.frame), CGRectGetHeight(self.whiteBackView.frame));
    self.passwordInputView.delegate = self;
    [self.whiteBackView addSubview:self.passwordInputView];
}

//  设置显示title
- (void)setTitleStr:(NSString *)titleStr{
    if (_titleStr != titleStr) {
        _titleStr = titleStr;
    }
    if (_titleStr) {
        self.payTypeView.title = _titleStr;
    }
}

- (void)setShowOfflinePay:(BOOL)showOfflinePay{
    _showOfflinePay = showOfflinePay;
    self.payTypeView.offlinePay = _showOfflinePay;
}

#pragma mark  弹出付款view
+ (instancetype)popupView{
    PayTypePopupView *popupView = [[PayTypePopupView alloc] init];
    popupView.frame = [UIScreen mainScreen].bounds;
    popupView.backgroundColor = [UIColor clearColor];
    [kKeyWindow addSubview:popupView];
    CGRect whiteBackViewFrame = popupView.whiteBackView.frame;
    whiteBackViewFrame.origin.y = SCREEN_HEIGHT - PayTypeViewHeight;
    [UIView animateWithDuration:0.38 animations:^{
        popupView.maskBackgroundView.alpha = 0.4;
        popupView.whiteBackView.frame = whiteBackViewFrame;
    }];
    return popupView;
}

//  撤销弹出的密码框
- (void)dismiss{
    [self hiddenView];
}

#pragma mark - 操作页面逻辑
#pragma mark  隐藏优惠view
- (void)hiddenView{
    [UIView animateWithDuration:0.28 animations:^{
        self.maskBackgroundView.alpha = 0.0;
        self.whiteBackView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, PayTypeViewHeight);
    } completion:^(BOOL finished) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark  无动画隐藏view
- (void)hiddenViewWithNoAnimation{
    self.maskBackgroundView.alpha = 0.0;
    self.whiteBackView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, PayTypeViewHeight);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}


#pragma mark - 密码输入框弹框代理
#pragma mark 点击返回按钮
- (void)passwordInputViewClickBackButton:(PasswordInputView *)passwordInputView{
    [self endEditing:YES];
    CGRect passwordInputViewRect = self.passwordInputView.frame;
    passwordInputViewRect.origin.x = SCREEN_WIDTH;
    CGRect otherPayViewRect = self.payTypeView.frame;
    otherPayViewRect.origin.x = 0.0;
    [UIView animateWithDuration:0.38 animations:^{
        self.passwordInputView.frame = passwordInputViewRect;
        self.payTypeView.frame = otherPayViewRect;
    }];
}

#pragma mark 点击忘记密码
- (void)passwordInputViewClickForgetButton{
    [self hiddenViewWithNoAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(payTypePopupViewClickForgetPassword)]) {
        [self.delegate payTypePopupViewClickForgetPassword];
    }
}

#pragma mark 密码输入完成
- (void)passwordInputViewCompleteInputPassword:(PasswordInputView *)passwordInputView password:(NSString *)password{
    [self hiddenView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(payTypePopupViewEnterPassword:channelModel:)]) {
        [self.delegate payTypePopupViewEnterPassword:password channelModel:self.selectedChannelModel];
    }
}

#pragma mark -  PayTypeViewDelegate (其他支付代理方法)
/** 点击返回按钮 */
- (void)payTypeViewClickBackButton{
    [self hiddenView];
}

- (void)choiseBankCardViewAddBankCard{
    NSLog(@"添加银行卡");
    [self hiddenView];
    [RealNameManager realNameWithCurrentVc:[UIViewController currentViewController] andRealNameProgress:RealNameProgressBindCard isSaveBackVcName:YES];
}

/** 渠道支付 */
- (void)payTypeViewClickPayChannel:(PayChannelModel *)channelModel{
    
    if ([channelModel.channelId isEqualToString:@"-4"]) {
        //  线下支付宝支付
        if (self.delegate && [self.delegate respondsToSelector:@selector(payTypePopupViewAlipayWithChannelModel:isNewPayStyle:)]) {
            [self hiddenView];
            [self.delegate payTypePopupViewAlipayWithChannelModel:channelModel isNewPayStyle:0];
        }
    } else if ([channelModel.channelId isEqualToString:@"-5"]) {
        //  其他支付方式
        if (self.delegate && [self.delegate respondsToSelector:@selector(payTypePopupViewOtherPayStyleWithChannelModel:)]) {
            [self hiddenView];
            [self.delegate payTypePopupViewOtherPayStyleWithChannelModel:channelModel];
        }
    } else if ([channelModel.channelId isEqualToString:@"-6"]){
        //  订单输入版支付宝线下还款
        if (self.delegate && [self.delegate respondsToSelector:@selector(payTypePopupViewAlipayWithChannelModel:isNewPayStyle:)]) {
            [self hiddenView];
            [self.delegate payTypePopupViewAlipayWithChannelModel:channelModel isNewPayStyle:1];
        }
    } else {
        //  银行卡支付
        self.selectedChannelModel = channelModel;
        CGRect otherPayViewRect = self.payTypeView.frame;
        otherPayViewRect.origin.x = -SCREEN_WIDTH;
        CGRect passwordInputViewRect = self.passwordInputView.frame;
        passwordInputViewRect.origin.x = 0.0;
        [UIView animateWithDuration:0.38 animations:^{
            self.payTypeView.frame = otherPayViewRect;
            self.passwordInputView.frame = passwordInputViewRect;
            [self.passwordInputView.passwordFieldView.passwordTextField becomeFirstResponder];
        }];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
