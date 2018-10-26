//
//  ShanDaoLoginViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ShanDaoLoginViewController.h"
#import "LSInputTextField.h"
#import "ShanDaoRegisterViewController.h"
#import "ShanDaoForgetPasswordViewController.h"
#import "ShanDaoCheckLoginViewController.h"
#import "LoginApi.h"
#import "ZTMXFCreditxTextField.h"

@interface ShanDaoLoginViewController ()

/** 手机号码 */
@property (nonatomic, strong) LSInputTextField  *phoneInput;
/** 密码 */
@property (nonatomic, strong) LSInputTextField  *passwordInput;
/** 登录 */
@property (nonatomic, strong) XLButton          *loginButton;

/** 立即注册 */
@property (nonatomic, strong) UIButton          *registerButton;
/** 忘记密码 */
@property (nonatomic, strong) UIButton          *forgetPasswordButton;


@end

@implementation ShanDaoLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    [self configueSubViews];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (UIButton *)set_leftButton{
    UIButton *returnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBack. frame=CGRectMake(15, 5, 38, 38);
    [returnBack setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    returnBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return returnBack;
}

- (void)left_button_event:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response(按钮,手势点击事件)
//  立即登录按钮点击
- (void)loginButtonAction{
    NSString *userName = self.phoneInput.inputText;
    NSString *password = [self.passwordInput.inputText MD5];

    if ([self verifyLogin]) {
        [LoginManager saveUserPhone:userName];
        [SVProgressHUD showLoading];
        LoginApi *loginApi = [[LoginApi alloc] initWithLoginType:@"L" password:password securityCode:nil];
        [loginApi requestWithSuccess:^(NSDictionary *responseDict) {
            [SVProgressHUD dismiss];
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                //  登录成功
                NSString *needVerify = [responseDict[@"data"][@"needVerify"] description];
                if ([needVerify isEqualToString:@"Y"]) {
                    //  登录成功
                    NSString *token = [responseDict[@"data"][@"token"] description];
                    [LoginManager saveUserPhone:userName userPasw:password userToken:token];

                    //  登录成功发送通知(在设置里面接收通知)
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    //  跳转到可信登录
                    ShanDaoCheckLoginViewController *checkLoginVC = [[ShanDaoCheckLoginViewController alloc] init];
                    checkLoginVC.phoneNumber = self.phoneInput.inputText;
                    checkLoginVC.password = password;
                    [self.navigationController pushViewController:checkLoginVC animated:YES];
                }
            }

        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}
//  立即注册按钮点击
- (void)registerButtonAction{
    NSLog(@"注册");
    
    ShanDaoRegisterViewController *registerVC = [[ShanDaoRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    // 点击去注册埋点
    [self goRegistStatistics];
}
//  立即忘记密码按钮点击
- (void)forgetPasswordButtonAction{
    NSLog(@"忘记密码");
    ShanDaoForgetPasswordViewController *forgetPasswordVC = [[ShanDaoForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}
//  清除手机号
- (void)clearInputPhoneNumber{
    self.phoneInput.inputTextField.text = @"";
    [_phoneInput bottomLineColorChange];
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
    }
}

#pragma mark - 私有方法
//  验证登录
- (BOOL)verifyLogin{
    
    if (self.phoneInput.inputText.length <= 0) {
        [self.view makeCenterToast:kPhoneInputReminder];
        return NO;
    }

    if (self.passwordInput.inputText.length <= 0) {
        [self.view makeCenterToast:kPasswordInputReminder];
        return NO;
    }

    BOOL passwordVerify = [NSString checkLoginPwdRule:self.passwordInput.inputText];
    if (self.passwordInput.inputText.length >= 6 && self.passwordInput.inputText.length <= 18 && passwordVerify) {
        return YES;
    } else {
        [self.view makeCenterToast:kPasswordInputReminder];
        return NO;
    }
    
    return YES;
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.phoneInput];
    [self.view addSubview:self.passwordInput];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.forgetPasswordButton];
    
    [self.phoneInput.rightButton addTarget:self action:@selector(clearInputPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordInput.rightButton addTarget:self action:@selector(passwordSecurity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self configueSubViewsFrame];
}

#pragma mark - Configue SubViews Frame(设置子视图frame)
//  设置子视图的frame
- (void)configueSubViewsFrame{
    CGFloat leftMarigin = AdaptedWidth(30.0);
    CGFloat inputViewWidth = Main_Screen_Width - 2 * leftMarigin;
    CGFloat inputViewHeight = 40.0;
    
    self.phoneInput.frame = CGRectMake(leftMarigin,k_Navigation_Bar_Height+AdaptedHeight(60.0), inputViewWidth, inputViewHeight);
    self.passwordInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.phoneInput.frame) + 20.0, inputViewWidth, inputViewHeight);
    
    self.loginButton.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.passwordInput.frame) + AdaptedHeight(90), Main_Screen_Width - leftMarigin * 2, AdaptedHeight(44.0));

    self.registerButton.frame = CGRectMake(CGRectGetMinX(self.loginButton.frame)+AdaptedWidth(5), CGRectGetMaxY(self.loginButton.frame) + AdaptedWidth(15), 120.0, 20.0);
    
    self.forgetPasswordButton.frame = CGRectMake(CGRectGetMaxX(self.loginButton.frame) - 80.0, CGRectGetMinY(self.registerButton.frame), 120.0, 20.0);
        _forgetPasswordButton.right = _loginButton.right-AdaptedWidth(5);

}


#pragma mark - getters and setters
- (LSInputTextField *)phoneInput{
    if (_phoneInput == nil) {
        _phoneInput = [[LSInputTextField alloc] init];
        _phoneInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _phoneInput.editShowRight = YES;
        _phoneInput.isLineHighlighted = YES;
        _phoneInput.inputPlaceHolder = kPhoneInputReminder;
        _phoneInput.leftImageStr = @"user_phone";
        _phoneInput.rightImageStr = @"login_delete";
        [_phoneInput addTextFieldDelegate];
    }
    return _phoneInput;
}

- (LSInputTextField *)passwordInput{
    if (_passwordInput == nil) {
        _passwordInput = [[LSInputTextField alloc] init];
        _passwordInput.inputTextField.secureTextEntry = YES;
        _passwordInput.isLineHighlighted = YES;
        _passwordInput.inputPlaceHolder = kPasswordInputReminder;
        _passwordInput.leftImageStr = @"user_passowrd";
        _passwordInput.rightImageStr = @"login_password_security";
    }
    return _passwordInput;
}

- (XLButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [XLButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        _loginButton.layer.cornerRadius = 3;
//        _loginButton.backgroundColor = K_MainColor;
        _loginButton.clipsToBounds = YES;
    }
    return _loginButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"新用户注册>" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] forState:UIControlStateNormal];
        _registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _registerButton;
}

- (UIButton *)forgetPasswordButton{
    if (_forgetPasswordButton == nil) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPasswordButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] forState:UIControlStateNormal];
        _forgetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _forgetPasswordButton;
}

#pragma mark - 点击去注册
- (void)goRegistStatistics{
    [ZTMXFUMengHelper mqEvent:k_logoin_regist_click];
}

@end
