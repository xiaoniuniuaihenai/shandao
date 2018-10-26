//
//  PasswordFieldView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  

#import "PasswordFieldView.h"

@interface PasswordFieldView ()<UITextFieldDelegate>

@end

@implementation PasswordFieldView

- (NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.passwordCount = 6;
        self.passwordTextFieldMargin = 5.0;
        self.passwordTextFieldW = 50.0 / 375.0 * SCREEN_WIDTH;
        
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    if (self.buttonArray.count > 0) {
        [self.buttonArray removeAllObjects];
    }
    
    for (int i = 0 ; i < self.passwordCount; i++) {
        
        UIButton *passwordButton = [[UIButton alloc] init];
        passwordButton.backgroundColor = [UIColor whiteColor];
        passwordButton.layer.borderColor = [UIColor colorWithHexString:COLOR_DEEPBORDER_STR].CGColor;
        passwordButton.layer.borderWidth = 1.0;
        passwordButton.layer.cornerRadius = 2.0;
        [passwordButton setImage:[UIImage imageNamed:@"pay_password"] forState:UIControlStateSelected];
        [passwordButton setImage:nil forState:UIControlStateNormal];
        [self addSubview:passwordButton];
        [self.buttonArray addObject:passwordButton];
        
    }
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(20.0, 0.0, SCREEN_WIDTH - 40.0, 50.0);
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.tintColor = [UIColor clearColor];
    passwordTextField.textColor = [UIColor clearColor];
    [passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    
}

- (void)setPasswordTextFieldW:(CGFloat)passwordTextFieldW{
    if (_passwordTextFieldW != passwordTextFieldW) {
        _passwordTextFieldW = passwordTextFieldW;
    }
    if (_passwordTextFieldW < 0) {
        _passwordTextFieldW = 50.0;
    }
    
    [self layoutIfNeeded];
}

- (void)setPasswordTextFieldMargin:(CGFloat)passwordTextFieldMargin{
    if (_passwordTextFieldMargin != passwordTextFieldMargin) {
        _passwordTextFieldMargin = passwordTextFieldMargin;
    }
    if (_passwordTextFieldMargin < 0) {
        _passwordTextFieldMargin = 5.0;
    }
    
    [self layoutIfNeeded];
}
/**
 清空密码框
 */
-(void)emptyPassword{
    _passwordTextField.text = @"";
    [self passwordTextFieldDidChange:_passwordTextField];
}
#pragma mark - textField 变化
- (void)passwordTextFieldDidChange:(UITextField *)sender{
    NSString *password = sender.text;
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *button = self.buttonArray[i];
        if (i < password.length) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    
    //  密码输入完成
    if (password.length == self.passwordCount) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(passwordFieldViewCompletePasswordInput:)]) {
            [self.delegate passwordFieldViewCompletePasswordInput:[password MD5]];
        }
    }
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.location >= self.passwordCount && ![string isEqualToString:@""]) {
        return NO;
    }
    //密码限制
    return YES;
}


#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat leftMargin = (viewWidth - self.passwordCount * self.passwordTextFieldW - self.passwordTextFieldMargin * (self.passwordCount - 1)) / 2.0;
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *passwordButton = self.buttonArray[i];
        passwordButton.frame = CGRectMake(leftMargin + i * (self.passwordTextFieldMargin + self.passwordTextFieldW), 0.0, self.passwordTextFieldW, self.passwordTextFieldW);
    }
}

- (void)passwordTextFeildBecomeFirstResponder{
    [self.passwordTextField becomeFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
