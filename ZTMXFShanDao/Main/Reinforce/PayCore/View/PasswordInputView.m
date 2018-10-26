//
//  PasswordInputView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/23.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "PasswordInputView.h"
#import "PasswordFieldView.h"

@interface PasswordInputView ()<PasswordFieldViewDelegate>
/** back button */
@property (nonatomic, strong) UIButton *backButton;
/** 跳过按钮(为设置支付密码使用) */
@property (nonatomic, strong) UIButton *skipButton;

/** header title label */
@property (nonatomic, strong) UILabel *headerLabel;
/** line view */
@property (nonatomic, strong) UIView *lineView;
/** 忘记密码 */
@property (nonatomic, strong) UIButton *forgetPasswordButton;

@end

@implementation PasswordInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //  添加子控件
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    self.backButton = [UIButton setupButtonWithImageStr:@"nav_back" title:@"" titleColor:[UIColor whiteColor] titleFont:14 withObject:self action:@selector(backButtonAction)];
    [self addSubview:self.backButton];

    UIColor *skipTitleColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    self.skipButton = [UIButton setupButtonWithImageStr:nil title:@"跳过" titleColor:skipTitleColor titleFont:14 withObject:self action:@selector(skipButtonAction)];
    [self addSubview:self.skipButton];
    self.skipButton.hidden = YES;
    
    self.headerLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:17 alignment:NSTextAlignmentCenter];
    self.headerLabel.text = @"输入密码";
    [self addSubview:self.headerLabel];
    
    /** 忘记密码 */
    self.forgetPasswordButton = [UIButton setupButtonWithSuperView:self withObject:self action:@selector(forgetPasswordButtonAction)];
    self.forgetPasswordButton.backgroundColor = [UIColor whiteColor];
    [self.forgetPasswordButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
    self.forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];

    
    self.lineView = [UIView setupViewWithSuperView:self withBGColor:COLOR_DEEPBORDER_STR];
 
    /** 密码输入框 */
    self.passwordFieldView = [[PasswordFieldView alloc] init];
    self.passwordFieldView.delegate = self;
    [self addSubview:self.passwordFieldView];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat headerHeight = 57.0;
    
    self.backButton.frame = CGRectMake(0.0, 0.0, 44.0, headerHeight);
    self.skipButton.frame = CGRectMake(Main_Screen_Width - 44.0, 0.0, 44.0, headerHeight);
    self.headerLabel.frame = CGRectMake(CGRectGetWidth(self.backButton.frame), 0.0, SCREEN_WIDTH - 2 * CGRectGetWidth(self.backButton.frame), headerHeight);
    self.lineView.frame = CGRectMake(0.0, headerHeight - 0.5, SCREEN_WIDTH, 0.5);
    self.passwordFieldView.frame = CGRectMake(0.0, CGRectGetMaxY(self.headerLabel.frame) + 25.0, SCREEN_WIDTH, 60.0);
    self.forgetPasswordButton.frame = CGRectMake(SCREEN_WIDTH - 110.0, 0.0, 110.0, headerHeight);

}

//  返回按钮
- (void)backButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordInputViewClickBackButton:)]) {
        [self.delegate passwordInputViewClickBackButton:self];
    }
}

//  跳过
- (void)skipButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordInputViewClickskipButton)]) {
        [self.delegate passwordInputViewClickskipButton];
        [ZTMXFUMengHelper mqEvent:k_skippassword_xf];
    }
}

//  忘记密码
- (void)forgetPasswordButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordInputViewClickForgetButton)]) {
        [self.delegate passwordInputViewClickForgetButton];
    }
}

#pragma mark - 密码输入框输入完成
//  密码输入完
- (void)passwordFieldViewCompletePasswordInput:(NSString *)passwordStr{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordInputViewCompleteInputPassword:password:)]) {
        [self.delegate passwordInputViewCompleteInputPassword:self password:passwordStr];
        self.password = passwordStr;
    }
}

/** 设置title */
- (void)configHeaderTitle:(NSString *)title{
    if (title) {
        self.headerLabel.text = title;
    }
}
/** 隐藏密码 */
- (void)hiddenForgetPassword:(BOOL)hidden{
    if (hidden) {
        self.forgetPasswordButton.hidden = YES;
    } else {
        self.forgetPasswordButton.hidden = NO;
    }
}

/** 隐藏跳过按钮 */
- (void)hiddenSkipButton:(BOOL)hidden{
    if (hidden) {
        self.skipButton.hidden = YES;
    } else {
        self.skipButton.hidden = NO;
    }
}
/**
 清空密码框
 */
-(void)emptyPassword{
    _password = @"";
    [_passwordFieldView emptyPassword];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
