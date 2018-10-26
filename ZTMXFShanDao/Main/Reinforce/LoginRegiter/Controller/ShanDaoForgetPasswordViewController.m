//
//  ShanDaoForgetPasswordViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ShanDaoForgetPasswordViewController.h"
#import "LSInputTextField.h"
#import "JKCountDownButton.h"
#import "ForgetPasswordApi.h"
#import "GetVerifyCodeApi.h"
#import "LoginApi.h"
#import "ShanDaoCheckLoginViewController.h"
#import "GainImgCodeApi.h"
#import "ZTMXFAlertImgCodeView.h"
#import "ZTMXFCreditxTextField.h"
@interface ShanDaoForgetPasswordViewController ()

@property (nonatomic, strong) UILabel          *userPhoneLabel;
/** 验证码 */
@property (nonatomic, strong) LSInputTextField *securityCodeInput;
/** 密码 */
@property (nonatomic, strong) LSInputTextField *passwordInput;
/** 获取验证码按钮 */
@property (nonatomic, strong) JKCountDownButton *getCodeButton;

/** 确认按钮 */
@property (nonatomic, strong) UIButton         *confirmButton;

@end

@implementation ShanDaoForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.navigationItem.title) {
        self.navigationItem.title = @"忘记密码";
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configueSubViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response(按钮,手势点击事件)
//  立即确定按钮点击
- (void)confirmButtonAction{
    if ([self verfyForgetPassword]) {
        [self.view endEditing:YES];
        NSString *userPhone = [LoginManager userPhone];
        [LoginManager saveUserPhone:userPhone];
        
        NSString *password = [self.passwordInput.inputText MD5];
        NSString *securityCode = self.securityCodeInput.inputText;
        
        [SVProgressHUD showLoading];
        ForgetPasswordApi *forgetPasswordApi = [[ForgetPasswordApi alloc] initWithPassword:password securityCode:securityCode];
        [forgetPasswordApi requestWithSuccess:^(NSDictionary *responseDict) {
            [SVProgressHUD dismiss];
            NSLog(@"%@", responseDict);
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                [kKeyWindow makeCenterToast:responseDict[@"msg"]];
                //  忘记密码之后重新登录
                [self loginWithPassword:password loginType:@"F" userPhone:userPhone];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

//  注册之后重新登录
- (void)loginWithPassword:(NSString *)passowrd loginType:(NSString *)type userPhone:(NSString *)userPhone{
    LoginApi *loginApi = [[LoginApi alloc] initWithLoginType:type password:passowrd securityCode:nil];
    //    [SVProgressHUD showLoading];
    [loginApi requestWithSuccess:^(NSDictionary *responseDict) {
        //        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //  登录成功
                NSString *needVerify = [responseDict[@"data"][@"needVerify"] description];
                if ([needVerify isEqualToString:@"Y"]) {
                    //  登录成功
                    NSString *token = [responseDict[@"data"][@"token"] description];
                    [LoginManager saveUserPhone:userPhone userPasw:passowrd userToken:token];
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    //  跳转到可信登录
                    ShanDaoCheckLoginViewController *checkLoginVC = [[ShanDaoCheckLoginViewController alloc] init];
                    checkLoginVC.phoneNumber = [LoginManager userPhone];
                    checkLoginVC.password = passowrd;
                    [self.navigationController pushViewController:checkLoginVC animated:YES];
                }
            });
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - 私有方法
- (BOOL)verfyForgetPassword{
    if ([LoginManager userPhone].length <= 0) {
        [self.view makeCenterToast:kPhoneInputReminder];
        return NO;
    }
    
    if ([LoginManager userPhone].length != 11) {
        [self.view makeCenterToast:kPhoneInputErrorReminder];
        return NO;
    }
    
    if (self.securityCodeInput.inputText.length <= 0) {
        [self.view makeCenterToast:kVerifyCodeInputReminder];
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

//  获取验证码
- (BOOL)gainVerifyCode{
    NSString *userPhone = [LoginManager userPhone];
    if (userPhone.length <= 0) {
        [self.view makeCenterToast:kPhoneInputReminder];
        return NO;
    }
    if (userPhone.length != 11) {
        [self.view makeCenterToast:kPhoneInputErrorReminder];
        return NO;
    }
    GainImgCodeApi * imgCodeApi = [[GainImgCodeApi alloc]initWithMobile:userPhone type:@"2"];
    [imgCodeApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSDictionary * dicData = responseDict[@"data"];
            NSInteger  openStr = [[dicData[@"open"] description] integerValue];
            if (openStr == 1) {
                NSString * imgStr = [dicData[@"image"] description];
                [self showImgCodeViewImgDataStr:imgStr];
            }else{
                [self gainRequestCode:nil];
            }
            
        }else{
            self.getCodeButton.enabled = YES;
            
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        self.getCodeButton.enabled = YES;
    }];
    return YES;
}


//获取验证码
-(void)gainRequestCode:(NSString*)imgCodeStr
{
    NSString *userPhone = [LoginManager userPhone];
    GetVerifyCodeApi *verifyCodeApi = [[GetVerifyCodeApi alloc] initWithUserPhone:userPhone codeType:@"F" imgCode:imgCodeStr];
    [SVProgressHUD showLoadingWithOutMask];
    [verifyCodeApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSString *messageStr = [responseDict[@"msg"] description];
            [self.view makeCenterToast:messageStr];
            [self.getCodeButton startCountDownWithSecond:60];
           
        } else {
            self.getCodeButton.enabled = YES;
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        self.getCodeButton.enabled = YES;
    }];
}


//图片验证码
-(void)showImgCodeViewImgDataStr:(NSString *)imgDataStr{
    NSString *userPhone = [LoginManager userPhone];
    MJWeakSelf
    ZTMXFAlertImgCodeView * codeView = [[ZTMXFAlertImgCodeView alloc] initWithMobile:userPhone type:@"2"];
    codeView.imgDataStr = imgDataStr;
    codeView.blockBtnClick = ^(NSString *codeStr) {
        if (codeStr.length>0) {
            [weakSelf gainRequestCode:codeStr];
        }else{
            weakSelf.getCodeButton.enabled = YES;
        }
    };
    [codeView showAlertView];
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

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.userPhoneLabel];
    [self.view addSubview:self.securityCodeInput];
    [self.view addSubview:self.passwordInput];
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.getCodeButton];
    self.userPhoneLabel.text = [[LoginManager userPhone] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [_getCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        
        //  验证手机号有没有输
        if ([self gainVerifyCode]) {
            
        } else {
            sender.enabled = YES;
        }
        
    }];
    
    [self.passwordInput.rightButton addTarget:self action:@selector(passwordSecurity) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self configueSubViewsFrame];
}

#pragma mark - Configue SubViews Frame(设置子视图frame)
//  设置子视图的frame
- (void)configueSubViewsFrame{
    CGFloat inputViewHeight = 40.0;
    MJWeakSelf
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.left).mas_offset(@(X(13)));
        make.right.mas_equalTo(weakSelf.view.mas_right).mas_offset(@(X(-13)));
        make.height.mas_equalTo(@(X(20)));
        make.top.mas_equalTo(weakSelf.view.mas_top).mas_offset(X(27));
    }];
    [self.securityCodeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userPhoneLabel.mas_left);
        make.top.mas_equalTo(weakSelf.userPhoneLabel.mas_bottom).mas_offset(@(X(50)));
        make.height.mas_equalTo(inputViewHeight);
        make.right.mas_equalTo(weakSelf.userPhoneLabel.mas_right);
    }];
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.securityCodeInput.mas_right).mas_offset(@(X(-120)));
        make.top.mas_equalTo(weakSelf.securityCodeInput.mas_top);
        make.height.mas_equalTo(inputViewHeight);
        make.right.mas_equalTo(weakSelf.securityCodeInput.mas_right);
    }];
    [self.passwordInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.userPhoneLabel);
        make.top.mas_equalTo(weakSelf.securityCodeInput.mas_bottom).mas_offset(@(X(25)));
        make.height.mas_equalTo(inputViewHeight);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.userPhoneLabel);
        make.top.mas_equalTo(weakSelf.passwordInput.mas_bottom).mas_offset(@(X(60)));
        make.height.mas_equalTo(@(X(44)));
    }];
}

- (void)valueChange:(UITextField *)textField{
    if (textField == self.securityCodeInput.inputTextField) {
        //当前输入框是验证码
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
            //            [textField resignFirstResponder];
        }
    }
    if (textField == self.passwordInput.inputTextField) {
        //当前输入框是验证码
        if (textField.text.length > 18) {
            textField.text = [textField.text substringToIndex:18];
            //            [textField resignFirstResponder];
        }
    }
}

- (UILabel *)userPhoneLabel{
    if (!_userPhoneLabel) {
        _userPhoneLabel = [[UILabel alloc]init];
        _userPhoneLabel.textColor = K_333333;
        _userPhoneLabel.font = FONT_Medium(X(20));
    }
    return _userPhoneLabel;
}

#pragma mark - getters and setters

- (LSInputTextField *)securityCodeInput{
    if (_securityCodeInput == nil) {
        _securityCodeInput = [[LSInputTextField alloc] init];
        _securityCodeInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _securityCodeInput.inputPlaceHolder = @"请输入短信验证码";
        _securityCodeInput.isLineHighlighted = YES;
        [_securityCodeInput.inputTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _securityCodeInput;
}

- (LSInputTextField *)passwordInput{
    if (_passwordInput == nil) {
        _passwordInput = [[LSInputTextField alloc] init];
        _passwordInput.inputTextField.secureTextEntry = YES;
        _passwordInput.isLineHighlighted = YES;
        _passwordInput.inputPlaceHolder = kPasswordInputReminder;
        //        _passwordInput.leftImageStr = @"user_passowrd";
        _passwordInput.rightImageStr = @"login_password_security";
        UIButton *button = [_passwordInput.inputTextField valueForKey:@"_clearButton"];
        [button setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateHighlighted];
        _passwordInput.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_passwordInput.inputTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordInput;
}

- (UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:X(16)];
        _confirmButton.layer.cornerRadius = 5;
        _confirmButton.backgroundColor = K_MainColor;
        _confirmButton.clipsToBounds = YES;
    }
    return _confirmButton;
}

- (JKCountDownButton *)getCodeButton{
    if (_getCodeButton == nil) {
        _getCodeButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _getCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_getCodeButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        [_getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [_getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
    }
    return _getCodeButton;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

