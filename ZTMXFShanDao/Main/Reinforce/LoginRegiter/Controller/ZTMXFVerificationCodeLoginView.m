//
//  ZTMXFVerificationCodeLoginView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFVerificationCodeLoginView.h"
#import "LSInputTextField.h"
#import "JKCountDownButton.h"
#import "UIButton+Attribute.h"
#import "UIViewController+Visible.h"
#import "UIButton+JKImagePosition.h"
#import "ZTMXFCreditxTextField.h"
@interface ZTMXFVerificationCodeLoginView()
@property (nonatomic, strong) UILabel          *registerLabel;
/** 密码输入框 */
@property (nonatomic, strong) LSInputTextField *passwordInput;
/** 验证码输入框 */
@property (nonatomic, strong) LSInputTextField *verificationInput;
/** 当前页面的类型:1.验证码登录 2.密码登录 */
@property (nonatomic, assign) XL_VERIFICATION_OR_PASSWORD loginType;
@end

@implementation ZTMXFVerificationCodeLoginView

- (instancetype)initWithFrame:(CGRect)frame Type:(XL_VERIFICATION_OR_PASSWORD)type{
    if (self = [super initWithFrame:frame]) {
        _loginType = type;
        [self configUI];
    }
    return self;
}

- (NSDictionary *)getData{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"phone"] = [self.phoneInput.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    dict[@"password"] = [self.passwordInput.inputTextField text];
    dict[@"verCode"] = [self.verificationInput.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return dict;
}

- (void)configUI{
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.registerLabel];
    self.registerLabel.sd_layout
    .leftSpaceToView(self, X(35 * PX))
    .heightIs(X(24))
    .widthIs(KW - X(25))
    .topSpaceToView(self, X(68));
    
    [self addSubview:self.phoneInput];
    self.phoneInput.sd_layout
    .leftEqualToView(_registerLabel)
    .topSpaceToView(self.registerLabel, X(50))
    .rightSpaceToView(self, X(35 * PX))
    .heightIs(X(40));
    
    self.registerLabel.text = @"注册/登录";
    [self addSubview:self.verificationInput];
    self.verificationInput.sd_layout
    .leftEqualToView(_phoneInput)
    .topSpaceToView(_phoneInput, X(20))
    .rightEqualToView(_phoneInput)
    .heightIs(X(42));

    [self addSubview:self.getCodeButton];
    self.getCodeButton.sd_layout
    .rightEqualToView(_verificationInput)
    .centerYEqualToView(self.verificationInput)
    .widthIs(X(90))
    .heightIs(X(31));
    
    [self addSubview:self.loginButton];
    self.loginButton.sd_layout
    .leftSpaceToView(self, X(20))
    .topSpaceToView(_verificationInput, X(43))
    .widthIs(KW - X(40))
    .heightIs(X(44));
    _loginButton.layer.cornerRadius = _loginButton.height/2;
    
    if (![LoginManager appReviewState]) {
        [self addSubview:self.advertisingImageView];
    }
    self.advertisingImageView.sd_layout
    .leftEqualToView(_phoneInput)
    .widthRatioToView(_phoneInput, 1.0)
    .heightIs(X(60))
    .topSpaceToView(_loginButton, X(63));
    
    UIButton *agreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreementButton addTarget:self action:@selector(agreementButtonClick) forControlEvents:UIControlEventTouchUpInside];
    agreementButton.titleLabel.font = FONT_Regular(X(12));
    [UIButton attributeWithBUtton:agreementButton title:@"点击登录代表您同意《闪到用户注册协议》" titleColor:@"646464" forState:UIControlStateNormal attributes:@[@"《闪到用户注册协议》"] attributeColors:@[K_2B91F0]];
    [self addSubview:agreementButton];
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    agreementButton.sd_layout
    .leftSpaceToView(self, X(20))
    .topSpaceToView(self.loginButton, X(20))
    .widthIs(KW - X(40))
    .heightIs(X(20));
    [_getCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.userInteractionEnabled = NO;
        
        //  验证手机号有没有输
        if ([self gainVerifyCode]) {
            sender.userInteractionEnabled =  NO;
        } else {
            sender.userInteractionEnabled = YES;
        }
    }];
}

- (void)agreementButtonClick{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(registerProtocol);
    [[UIViewController currentViewController].navigationController pushViewController:webVC animated:YES];
}

- (void)loginButtonClick{
    if (self.loginBlock) {
        self.loginBlock();
    }
}

//* 获取验证码 */
- (BOOL)gainVerifyCode{
    NSString *userPhone = self.phoneInput.inputText;
    if (userPhone.length <= 0) {
        [self makeCenterToast:kPhoneInputReminder];
        return NO;
    }
    if (userPhone.length != 11) {
        [self makeCenterToast:kPhoneInputErrorReminder];
        return NO;
    }
    [ZTMXFUMengHelper mqEvent:k_regist_getYZM_130 parameter:@{@"userName":userPhone}];
    if (self.getVerificationCodeBlock) {
        self.getVerificationCodeBlock(userPhone);
    }
    
    //请求验证码
    return YES;
}

- (void)setGetCodeButtonEnabled:(BOOL)getCodeButtonEnabled{
    _getCodeButtonEnabled = getCodeButtonEnabled;
    if (getCodeButtonEnabled) {
        _getCodeButton.userInteractionEnabled = YES;
        _getCodeButton.layer.borderColor = K_MainColor.CGColor;
        [self.getCodeButton setTitleColor:K_MainColor forState:UIControlStateNormal];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        _getCodeButton.layer.borderColor = [UIColor colorWithHexString:@"6B6B6B"].CGColor;
        [self.getCodeButton setTitleColor:[UIColor colorWithHexString:@"818181"] forState:UIControlStateNormal];
        [self.getCodeButton startCountDownWithSecond:60];
        [self.getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            countDownButton.userInteractionEnabled = NO;
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [self.getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.userInteractionEnabled = YES;
            _getCodeButton.layer.borderColor = K_MainColor.CGColor;
            [self.getCodeButton setTitleColor:K_MainColor forState:UIControlStateNormal];;
            return @"重新获取";
        }];
    }
}

//  设置密码是否明文
- (void)passwordSecurity{
    if (self.passwordInput.inputTextField.isSecureTextEntry) {
        //  设置不明文
        self.passwordInput.rightImageStr = @"login_password";
        self.passwordInput.inputTextField.secureTextEntry = NO;
    } else {
        //  设置明文
        self.passwordInput.rightImageStr = @"login_password_security";
        self.passwordInput.inputTextField.secureTextEntry = YES;
//      [ZTMXFUMengHelper mqEvent:k_login_doSeePassword parameter:@{@"Phone":_phoneInput.inputText}];
    }
}

- (void)advertisingClick{
    if (self.advertisingClickBlock) {
        self.advertisingClickBlock();
    }
}

- (void)valueChange:(UITextField *)textField{
    
 
    if (textField == self.verificationInput.inputTextField) {
        //当前输入框是验证码
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
//            [textField resignFirstResponder];
        }
    }
    if (textField == self.passwordInput.inputTextField) {
        //当前输入框是密码
        if (textField.text.length > 18) {
            textField.text = [textField.text substringToIndex:18];
//            [textField resignFirstResponder];
        }
    }
    
    if (textField == self.phoneInput.inputTextField) {
        //当前输入框是手机号码
        if ([textField.text hasPrefix:@"1"] && textField.text.length == 13) {
            if ([_getCodeButton.titleLabel.text isEqualToString:@"重新获取"] || [_getCodeButton.titleLabel.text isEqualToString:@"获取验证码"]) {
                _getCodeButton.layer.borderColor = K_MainColor.CGColor;
                [_getCodeButton setTitleColor:K_MainColor forState:UIControlStateNormal];
                _getCodeButton.userInteractionEnabled = YES;
            }
        }else{
            _getCodeButton.userInteractionEnabled = NO;
            _getCodeButton.layer.borderColor = [UIColor colorWithHexString:@"6B6B6B"].CGColor;
            [self.getCodeButton setTitleColor:[UIColor colorWithHexString:@"#818181"] forState:UIControlStateNormal];
        }
    }
    
    BOOL canLogin = NO;
    NSString *phone = [_phoneInput.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length != 11 || ![phone hasPrefix:@"1"]) {
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.alpha = .4f;
        return;
    }
    if (_loginType == XL_LOGINVC_VERIFICATION_CODE) {
        if ([[_verificationInput.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
            canLogin = NO;
        }else{
            canLogin = YES;
        }
    }else{
//        BOOL passwordVerify = [NSString checkLoginPwdRule:self.passwordInput.inputText];
        if (self.passwordInput.inputText.length < 6 || self.passwordInput.inputText.length > 18) {
            canLogin = NO;
        }else{
            canLogin = YES;
        }
    }
    canLogin == YES?({
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.alpha = 1.f;
        
    }):({
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.alpha = .4f;
    });
    

}


- (void)setCredixForPhoneTextField:(BOOL)credixForPhoneTextField{
    _credixForPhoneTextField = credixForPhoneTextField;
    if (_credixForPhoneTextField == YES) {
        self.phoneInput.inputTextField.inputActionName = CXInputLoginUserID;
    }else{
        self.phoneInput.inputTextField.inputActionName = 0;
    }
}

- (void)phoneInputDidBeginEditing:(UITextField *)textField{
    if (textField == self.phoneInput.inputTextField) {
        //后台打点-->输入手机号
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"dl" PointSubCode:@"input.dl_sjh" OtherDict:nil];
    }
}

#pragma mark - getters and setters
- (UILabel *)registerLabel{
    if (!_registerLabel) {
        _registerLabel = [[UILabel alloc]init];
        _registerLabel.font = FONT_Regular(X(30));
        _registerLabel.textColor = COLOR_SRT(@"000000");
    }
    return _registerLabel;
}

- (LSInputTextField *)phoneInput{
    if (_phoneInput == nil) {
        _phoneInput = [[LSInputTextField alloc] init];
        _phoneInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _phoneInput.editShowRight = YES;
        _phoneInput.isLineHighlighted = YES;
        _phoneInput.inputPlaceHolder = @"请输入您的手机号";
        _phoneInput.leftTitle = @"手机号";
//      _phoneInput.leftImageStr = @"XL_Login_Phone_Icon";
        _phoneInput.rightImageStr = @"login_delete";
        _phoneInput.inputTextField.inputActionName = CXInputLoginUserID;
        [_phoneInput.inputTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        [_phoneInput.rightButton addTarget:self action:@selector(phoneInputRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_phoneInput.inputTextField addTarget:self action:@selector(phoneInputDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
        [_phoneInput addTextFieldDelegate];
    }
    return _phoneInput;
}

- (void)phoneInputRightButtonClick{
    self.phoneInput.inputTextField.text = @"";
    [self.phoneInput bottomLineColorChange];
}

- (LSInputTextField *)passwordInput{
    if (_passwordInput == nil) {
        _passwordInput = [[LSInputTextField alloc] init];
        _passwordInput.inputTextField.secureTextEntry = YES;
        _passwordInput.isLineHighlighted = YES;
        _passwordInput.inputPlaceHolder = kPasswordInputReminder;
        _passwordInput.leftImageStr = @"XL_Login_Password_Icon";
        _passwordInput.rightImageStr = @"login_password_security";
        
        UIButton *button = [_passwordInput.inputTextField valueForKey:@"_clearButton"];
        [button setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
        _passwordInput.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

        [_passwordInput.rightButton addTarget:self action:@selector(passwordSecurity) forControlEvents:UIControlEventTouchUpInside];
        [_passwordInput.inputTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        [_verificationInput bottomLineColorChange];

    }
    return _passwordInput;
}

- (LSInputTextField *)verificationInput{
    if (_verificationInput == nil) {
        _verificationInput = [[LSInputTextField alloc] init];
        _verificationInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _verificationInput.editShowRight = YES;
        _verificationInput.isLineHighlighted = YES;
        _verificationInput.inputPlaceHolder = kVerifyCodeInputReminder;
//        _verificationInput.leftImageStr = @"XL_Login_Code_Icon";
        _verificationInput.rightImageStr = @"login_delete";
        _verificationInput.leftTitle = @"验证码";
        _verificationInput.inputTextField.inputActionName = CXInputLoginPassword;
        [_verificationInput.rightButton addTarget:self action:@selector(verificationInputRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_verificationInput.inputTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        [_verificationInput bottomLineColorChange];
    }
    return _verificationInput;
}

- (void)verificationInputRightButtonClick{
    self.verificationInput.inputTextField.text = @"";
    [_phoneInput bottomLineColorChange];
}

- (JKCountDownButton *)getCodeButton{
    if (_getCodeButton == nil) {
        _getCodeButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:X(15)];
        _getCodeButton.layer.borderWidth = 1;
        _getCodeButton.layer.borderColor = [UIColor colorWithHexString:@"#6B6B6B"].CGColor;
//        _getCodeButton.layer.cornerRadius = 3.0;
        _getCodeButton.layer.masksToBounds = YES;
        _getCodeButton.userInteractionEnabled = NO;
        _getCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_getCodeButton setTitleColor:[UIColor colorWithHexString:@"818181"] forState:UIControlStateNormal];
    }
    return _getCodeButton;
}

- (UIButton *)loginButton{
    return _loginButton?:({
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateHighlighted];
        [_loginButton setTitleColor:K_BtnTitleColor forState:UIControlStateHighlighted];
        [_loginButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = _loginButton.height/2;
        _loginButton.layer.masksToBounds = YES;
        _loginButton.alpha = .4f;
        _loginButton.userInteractionEnabled = NO;
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton;
    });
}
- (UIImageView *)advertisingImageView{
    return _advertisingImageView?:({
        _advertisingImageView = [UIImageView new];
        _advertisingImageView.image = [UIImage imageWithColor:[UIColor whiteColor]];
      
        _advertisingImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advertisingClick)];
        [_advertisingImageView addGestureRecognizer:tap];
        _advertisingImageView;
    });
}
- (XL_VERIFICATION_OR_PASSWORD)loginType{
    if (!_loginType) {
        _loginType = XL_LOGINVC_VERIFICATION_CODE;
    }
    return _loginType;
}



@end
