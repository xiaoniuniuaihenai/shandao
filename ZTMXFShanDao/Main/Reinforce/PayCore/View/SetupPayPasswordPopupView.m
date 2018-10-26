//
//  SetupPayPasswordPopupView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "SetupPayPasswordPopupView.h"
#import "PasswordInputView.h"
#import "PasswordFieldView.h"

@interface SetupPayPasswordPopupView ()<PasswordInputViewDelegate>

/** 蒙版 view */
@property (nonatomic, strong) UIView                *maskBackgroundView;

/** 横向滚动scrollView */
@property (nonatomic, strong) UIView                *whiteBackView;

/** 设置支付密码 */
@property (nonatomic, strong) PasswordInputView     *setupPasswordView;
/** 确认支付密码 */
@property (nonatomic, strong) PasswordInputView     *checkPasswordView;

@end

@implementation SetupPayPasswordPopupView

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
    
    /** 横向scrollView */
    self.whiteBackView = [[UIView alloc] init];
    self.whiteBackView.backgroundColor = [UIColor whiteColor];
    self.whiteBackView.frame = CGRectMake(0.0, Main_Screen_Height, Main_Screen_Width, PayTypeViewHeight);
    [self addSubview:self.whiteBackView];
    
 
    /** 设置支付密码 */
    self.setupPasswordView = [[PasswordInputView alloc] init];
    self.setupPasswordView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.whiteBackView.frame), CGRectGetHeight(self.whiteBackView.frame));
    self.setupPasswordView.delegate = self;
    [self.setupPasswordView configHeaderTitle:@"请设置支付密码"];
    [self.setupPasswordView hiddenForgetPassword:YES];
    [self.setupPasswordView hiddenSkipButton:NO];
    [self.whiteBackView addSubview:self.setupPasswordView];

    /** 确认支付密码 */
    self.checkPasswordView = [[PasswordInputView alloc] init];
    self.checkPasswordView.frame = CGRectMake(Main_Screen_Width, 0.0, CGRectGetWidth(self.whiteBackView.frame), CGRectGetHeight(self.whiteBackView.frame));
    self.checkPasswordView.delegate = self;
    [self.checkPasswordView configHeaderTitle:@"请确认支付密码"];
    [self.checkPasswordView hiddenForgetPassword:YES];
    [self.checkPasswordView hiddenSkipButton:YES];
    [self.whiteBackView addSubview:self.checkPasswordView];

}

#pragma mark  弹出付款view
+ (instancetype)popupView{
    SetupPayPasswordPopupView *popupView = [[SetupPayPasswordPopupView alloc] init];
    popupView.frame = [UIScreen mainScreen].bounds;
    popupView.backgroundColor = [UIColor clearColor];
    [kKeyWindow addSubview:popupView];
    CGRect whiteBackViewFrame = popupView.whiteBackView.frame;
    whiteBackViewFrame.origin.y = Main_Screen_Height - PayTypeViewHeight;
    [UIView animateWithDuration:0.38 animations:^{
        popupView.maskBackgroundView.alpha = 0.4;
        popupView.whiteBackView.frame = whiteBackViewFrame;
        [popupView.setupPasswordView.passwordFieldView passwordTextFeildBecomeFirstResponder];
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

#pragma mark - 密码框代理方法
/** 点击返回按钮 */
- (void)passwordInputViewClickBackButton:(PasswordInputView *)passwordInputView{
    if ([passwordInputView isEqual:self.setupPasswordView]) {
        //  设置支付密码
        [self hiddenView];
        if (self.delegate && [self.delegate respondsToSelector:@selector(setupPayPasswordClickSkip:)]) {
            [self.delegate setupPayPasswordClickSkip:self];
        }
    } else if ([passwordInputView isEqual:self.checkPasswordView]) {
        //  确认支付密码(返回到设置支付密码)
        CGRect setupPasswordViewRect = self.setupPasswordView.frame;
        setupPasswordViewRect.origin.x = 0.0;
        CGRect checkPasswordViewRect = self.checkPasswordView.frame;
        checkPasswordViewRect.origin.x = Main_Screen_Width;
        [UIView animateWithDuration:0.38 animations:^{
            self.setupPasswordView.frame = setupPasswordViewRect;
            self.checkPasswordView.frame = checkPasswordViewRect;
        } completion:^(BOOL finished) {
            [_checkPasswordView emptyPassword];
            [self.setupPasswordView.passwordFieldView passwordTextFeildBecomeFirstResponder];
        }];
    }
}

/** 跳过按钮点击 */
- (void)passwordInputViewClickskipButton{
    [self hiddenViewWithNoAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(setupPayPasswordClickSkip:)]) {
        [self.delegate setupPayPasswordClickSkip:self];
    }
}

/** 密码输入完成 */
- (void)passwordInputViewCompleteInputPassword:(PasswordInputView *)passwordInputView password:(NSString *)password{
    if ([passwordInputView isEqual:self.setupPasswordView]) {
        //  设置支付密码
        CGRect setupPasswordViewRect = self.setupPasswordView.frame;
        setupPasswordViewRect.origin.x = -Main_Screen_Width;
        CGRect checkPasswordViewRect = self.checkPasswordView.frame;
        checkPasswordViewRect.origin.x = 0.0;
        [UIView animateWithDuration:0.38 animations:^{
            self.setupPasswordView.frame = setupPasswordViewRect;
            self.checkPasswordView.frame = checkPasswordViewRect;
        } completion:^(BOOL finished) {
            [self.checkPasswordView.passwordFieldView passwordTextFeildBecomeFirstResponder];
        }];
        
        
    } else if ([passwordInputView isEqual:self.checkPasswordView]) {
        //  确认支付密码(密码输入完成)
        if (![self.setupPasswordView.password isEqualToString:password]) {
            [_checkPasswordView.passwordFieldView emptyPassword];
            [kKeyWindow makeCenterToast:@"两次输入不一致，请重新输入"];
        } else {
            [self hiddenViewWithNoAnimation];
            if (self.delegate && [self.delegate respondsToSelector:@selector(setupPayPasswordCompleteInputPassword:)]) {
                [self.delegate setupPayPasswordCompleteInputPassword:password];
            }
        }
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
