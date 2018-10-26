//
//  PasswordPopupView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PasswordPopupView.h"
#import "PasswordFieldView.h"

@interface PasswordPopupView ()<PasswordFieldViewDelegate>

/** 蒙版 view */
@property (nonatomic, strong) UIView                    *maskBackgroundView;
/** 点击蒙版手势 */
@property (nonatomic, strong) UITapGestureRecognizer    *tapMaskViewGesture;
/** 横向滚动scrollView */
@property (nonatomic, strong) UIView                    *whiteBackView;
/** 密码输入view */
@property (nonatomic, strong) UIView                    *passwordView;
/** 忘记密码 */
@property (nonatomic, strong) UIButton                  *forgetPasswordButton;


@end

@implementation PasswordPopupView

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

//  添加子控件
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
    
    /** 输入密码框 */
    CGFloat passwordHeaderH = 60.0;
    UIView *passwordView = [[UIView alloc] init];
    passwordView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, PayTypeViewHeight);
    passwordView.backgroundColor = [UIColor whiteColor];
    [self.whiteBackView addSubview:passwordView];
    self.passwordView = passwordView;
    
    UIButton *passwordBackButton = [UIButton setupButtonWithImageStr:@"nav_back" title:@"" titleColor:[UIColor whiteColor] titleFont:14 withObject:self action:@selector(passwordBackButtonAction)];
    passwordBackButton.frame = CGRectMake(0.0, 0.0, 32.0, passwordHeaderH);
    [passwordView addSubview:passwordBackButton];
    
    UILabel *inputPassword = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:17 alignment:NSTextAlignmentCenter];
    inputPassword.frame = CGRectMake(CGRectGetWidth(passwordBackButton.frame), 0.0, SCREEN_WIDTH - 2 * CGRectGetWidth(passwordBackButton.frame), passwordHeaderH);
    inputPassword.text = @"输入密码";
    [passwordView addSubview:inputPassword];
    
    UIView *lineView1 = [UIView setupViewWithSuperView:passwordView withBGColor:@"afafaf"];
    lineView1.frame = CGRectMake(0.0, passwordHeaderH - 0.5, SCREEN_WIDTH, 0.5);
    
    /** 密码输入框 */
    self.passwordInputView = [[PasswordFieldView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(lineView1.frame) + 25.0, SCREEN_WIDTH, 60.0)];
    self.passwordInputView.delegate = self;
    [passwordView addSubview:self.passwordInputView];
    
    /** 忘记密码 */
    self.forgetPasswordButton = [UIButton setupButtonWithSuperView:passwordView withObject:self action:@selector(forgetPasswordButtonAction)];
    self.forgetPasswordButton.frame = CGRectMake(SCREEN_WIDTH - 110.0, CGRectGetMaxY(self.passwordInputView.frame) + 10.0, 110.0, 30.0);
    self.forgetPasswordButton.backgroundColor = [UIColor whiteColor];
    [self.forgetPasswordButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
    self.forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    
}


//  弹出支付类型view
+ (instancetype)popupPasswordBoxView{
    
    PasswordPopupView *passwordView = [[PasswordPopupView alloc] init];
    passwordView.frame = [UIScreen mainScreen].bounds;
    passwordView.backgroundColor = [UIColor clearColor];
    [kKeyWindow addSubview:passwordView];
    CGRect whiteBackViewFrame = passwordView.whiteBackView.frame;
    whiteBackViewFrame.origin.y = SCREEN_HEIGHT - PayTypeViewHeight;
    [UIView animateWithDuration:0.38 animations:^{
        passwordView.maskBackgroundView.alpha = 0.4;
        passwordView.whiteBackView.frame = whiteBackViewFrame;
        [passwordView.passwordInputView.passwordTextField becomeFirstResponder];
    }];
    //  通知开始输入密码,弹出键盘
    return passwordView;
}

//  撤销弹出的密码框
- (void)dismiss{
    [self hiddenView];
}

#pragma mark - response event
/** 密码框返回按钮 */
- (void)passwordBackButtonAction{
    //  隐藏密码输入view
    [self hiddenView];
}


#pragma mark - 操作页面逻辑
//  隐藏优惠view
- (void)hiddenView{
    [self endEditing:YES];
    
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

//  无动画隐藏view
- (void)hiddenViewWithNoAnimation{
    [self endEditing:YES];
    
    self.maskBackgroundView.alpha = 0.0;
    self.whiteBackView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, PayTypeViewHeight);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
    
}

#pragma mark - ALAPasswordInputViewDelegate
//  密码输入完成
- (void)passwordFieldViewCompletePasswordInput:(NSString *)passwordStr{
    [self hiddenView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordPopupViewEnterPassword:)]) {
        [self.delegate passwordPopupViewEnterPassword:passwordStr];
    }
}

//  忘记密码
- (void)forgetPasswordButtonAction{
    [self hiddenViewWithNoAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordPopupViewForgetPassword)]) {
        [self.delegate passwordPopupViewForgetPassword];
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
