//
//  ShanDaoRegisterViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  

#import "ShanDaoRegisterViewController.h"
#import "LSInputTextField.h"
#import "JKCountDownButton.h"
#import "RegisterApi.h"
#import "GetVerifyCodeApi.h"
#import "LoginApi.h"
#import "ShanDaoCheckLoginViewController.h"
#import "LSWebViewController.h"
#import "ZTMXFAlertImgCodeView.h"
#import "LSGetResourceApi.h"
#import "GainImgCodeApi.h"
#import "ZTMXFCreditxTextField.h"
@interface ShanDaoRegisterViewController ()
// 防止小屏幕 显示不全
@property (nonatomic, strong) UIScrollView * scrollView;
/** 手机号码 */
@property (nonatomic, strong) LSInputTextField *phoneInput;
/** 验证码 */
@property (nonatomic, strong) LSInputTextField *securityCodeInput;
/** 密码 */
@property (nonatomic, strong) LSInputTextField *passwordInput;

//V1.7.0 抛弃
/** 是否显示推荐人手机号按钮 */
@property (nonatomic, strong) UIButton *showRecommendButton;
/** 推荐人手机号 */
@property (nonatomic, strong) LSInputTextField *recommendInput;

@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UIButton *telButton;
/** 邀请人提示文案*/
@property (nonatomic, strong) UILabel * lbRecommendPrompt;
@property (nonatomic, strong) UILabel *serviceLabel;


// ----------

/** 获取验证码按钮 */
@property (nonatomic, strong) JKCountDownButton *getCodeButton;
/** 注册按钮 */
@property (nonatomic, strong) UIButton         *registerButton;

@property (nonatomic, strong) UILabel *agreeProtocolLabel;
@property (nonatomic, strong) UIButton *protocolButton;
@end

@implementation ShanDaoRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self configueSubViews];
    // 注册页面uv
    [self enterRegisterPageStatistics];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response(按钮,手势点击事件)
//  点击服务协议
- (void)protocolButtonAction{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(registerProtocol);
    [self.navigationController pushViewController:webVC animated:YES];
}

//  点击客服电话
- (void)telButtonAction{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.telButton.currentTitle];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
//  立即注册按钮点击
- (void)registerButtonAction{
    if ([self verifyRegister]) {
    
        NSString *userPhone = self.phoneInput.inputText;
        NSString *password = [self.passwordInput.inputText MD5];
        NSString *securityCode = self.securityCodeInput.inputText;
        NSString *recommender = self.recommendInput.inputText;
        
        // 注册按钮点击埋点
        [self registerStatistics:userPhone];
        
        RegisterApi *registerApi = [[RegisterApi alloc] initWithUserPhone:userPhone password:password securityCode:securityCode recommendPhone:recommender];
        [SVProgressHUD showLoading];
        [registerApi requestWithSuccess:^(NSDictionary *responseDict) {
            [SVProgressHUD dismiss];
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                // 注册成功埋点
                [self registSucceedStatistics:userPhone];
                //  注册成功之后重新登录
                [LoginManager saveUserPhone:userPhone];
                [self loginWithPassword:password loginType:@"R" userPhone:userPhone];
            }
            
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

//  注册之后重新登录
- (void)loginWithPassword:(NSString *)passowrd loginType:(NSString *)type userPhone:(NSString *)userPhone{
    LoginApi *loginApi = [[LoginApi alloc] initWithLoginType:type password:passowrd securityCode:nil];
    [SVProgressHUD showLoading];
    [loginApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            //  登录成功
            NSString *needVerify = [responseDict[@"data"][@"needVerify"] description];
            if ([needVerify isEqualToString:@"Y"]) {
                //  登录成功
                NSString *token = [responseDict[@"data"][@"token"] description];
                //  登录成功发送通知(在设置里面接收通知)
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:nil];
                [LoginManager saveUserPhone:userPhone userPasw:passowrd userToken:token];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                //  跳转到可信登录
                ShanDaoCheckLoginViewController *checkLoginVC = [[ShanDaoCheckLoginViewController alloc] init];
                checkLoginVC.phoneNumber = self.phoneInput.inputText;
                checkLoginVC.password = passowrd;
                [self.navigationController pushViewController:checkLoginVC animated:YES];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


//  显示填写推荐人手机号
- (void)showRecommendButtonAction{
    if (self.recommendInput.alpha == 0.0) {
        [self rowStartRotationAnimationClockwise:NO];
        _lbRecommendPrompt.hidden = YES;
        [UIView animateWithDuration:0.38 animations:^{
            self.recommendInput.alpha = 1.0;
        }];
    } else {
        [self rowStartRotationAnimationClockwise:YES];
        [self.recommendInput.inputTextField resignFirstResponder];
        [UIView animateWithDuration:0.38 animations:^{
            self.recommendInput.alpha = 0.0;
        }];
        _lbRecommendPrompt.hidden = NO;

    }
}

//  获取验证码
- (BOOL)gainVerifyCode{
    NSString *userPhone = self.phoneInput.inputText;
    // 点击获取验证码埋点
    if (userPhone.length <= 0) {
        [self.view makeCenterToast:kPhoneInputReminder];
        return NO;
    }

    if (userPhone.length != 11) {
        [self.view makeCenterToast:kPhoneInputErrorReminder];
        return NO;
    }
    [ZTMXFUMengHelper mqEvent:k_regist_getYZM parameter:@{@"Phone":userPhone}];
//    图片验证
    GainImgCodeApi * imgCodeApi = [[GainImgCodeApi alloc] initWithMobile:userPhone type:@"1"];
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
-(void)gainRequestCode:(NSString*)imgCodeStr{
    NSString *userPhone = self.phoneInput.inputText;
    GetVerifyCodeApi *verifyCodeApi = [[GetVerifyCodeApi alloc] initWithUserPhone:userPhone codeType:@"R" imgCode:imgCodeStr];
    [SVProgressHUD showLoadingWithOutMask];
    [verifyCodeApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            [self.getCodeButton startCountDownWithSecond:60];
            [self.getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [self.getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                return @"重新获取";
            }];
        } else {
            self.getCodeButton.enabled = YES;
            [SVProgressHUD dismiss];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        self.getCodeButton.enabled = YES;
    }];
}
//图片验证码
-(void)showImgCodeViewImgDataStr:(NSString *)imgDataStr{
    NSString *userPhone = self.phoneInput.inputText;
    MJWeakSelf
    ZTMXFAlertImgCodeView * codeView = [[ZTMXFAlertImgCodeView alloc] initWithMobile:userPhone type:@"1"];
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
#pragma mark - 验证注册
- (BOOL)verifyRegister{
    if (self.phoneInput.inputText.length <= 0) {
        [self.view makeCenterToast:kPhoneInputReminder];
        return NO;
    }
    
    if (self.phoneInput.inputText.length != 11) {
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
        
        [ZTMXFUMengHelper mqEvent:k_regist_doSeePassword parameter:@{@"Phone":_phoneInput.inputText}];

    }
}

#pragma mark - 私有方法
- (void)rowStartRotationAnimationClockwise:(BOOL)clockWise{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (clockWise) {
        rotation.fromValue = [NSNumber numberWithFloat:-(M_PI)];
        rotation.toValue = [NSNumber numberWithFloat:0.0];
    } else {
        rotation.fromValue = [NSNumber numberWithFloat:0.0];
        rotation.toValue = [NSNumber numberWithFloat:-(M_PI)];
    }
    rotation.duration = 0.5;
    rotation.fillMode = kCAFillModeForwards;
    rotation.removedOnCompletion = NO;
    [self.showRecommendButton.layer addAnimation:rotation forKey:nil];
}



#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.phoneInput];
    [self.scrollView addSubview:self.securityCodeInput];
    [self.scrollView addSubview:self.getCodeButton];

    [self.scrollView addSubview:self.passwordInput];
    [self.scrollView addSubview:self.showRecommendButton];
    [self.scrollView addSubview:self.lbRecommendPrompt];
    [self.scrollView addSubview:self.recommendInput];
    [self.scrollView addSubview:self.registerButton];
    
    [self.scrollView addSubview:self.agreeProtocolLabel];
    [self.scrollView addSubview:self.protocolButton];
    [self.scrollView addSubview:self.serviceLabel];
    [self.scrollView addSubview:self.telLabel];
    [self.scrollView addSubview:self.telButton];
    MJWeakSelf
    [_getCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [weakSelf.view endEditing:YES];
        //  获取验证码
        if ([self gainVerifyCode]) {

        } else {
            sender.enabled = YES;
        }
    }];
    
    [self.phoneInput.rightButton addTarget:self action:@selector(clearInputPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordInput.rightButton addTarget:self action:@selector(passwordSecurity) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.protocolButton addTarget:self action:@selector(protocolButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.telButton addTarget:self action:@selector(telButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self configueSubViewsFrame];
}

#pragma mark - Configue SubViews Frame(设置子视图frame)
//  设置子视图的frame
- (void)configueSubViewsFrame{
    CGFloat leftMarigin = AdaptedWidth(30.0);
    CGFloat inputViewWidth = Main_Screen_Width - 2 * leftMarigin;
    CGFloat inputViewHeight = 40.0;
    
    self.scrollView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    self.phoneInput.frame = CGRectMake(leftMarigin,AdaptedHeight(60.0), inputViewWidth, inputViewHeight);

    self.securityCodeInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.phoneInput.frame) + AdaptedHeight(25.0), inputViewWidth, inputViewHeight);
    self.getCodeButton.frame = CGRectMake(CGRectGetMaxX(self.securityCodeInput.frame) - 120.0, CGRectGetMinY(self.securityCodeInput.frame), 120.0, inputViewHeight);
    
    self.passwordInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.securityCodeInput.frame) + AdaptedHeight(25.0), inputViewWidth, inputViewHeight);
//    V1.7.0  抛弃----
//    self.showRecommendButton.frame = CGRectMake(CGRectGetMaxX(self.passwordInput.frame) - 45.0, CGRectGetMaxY(self.passwordInput.frame), 60.0, 30.0);
//    self.lbRecommendPrompt.frame = CGRectMake(leftMarigin, _showRecommendButton.top, _showRecommendButton.left-leftMarigin, _showRecommendButton.height);
//
//    self.recommendInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.passwordInput.frame) + AdaptedHeight(30.0), inputViewWidth, inputViewHeight);
//    ---------------------------
    self.registerButton.frame = CGRectMake(leftMarigin, _passwordInput.bottom + AdaptedHeight(60.0), inputViewWidth, AdaptedHeight(44.0));
    
    
    CGFloat agreeProtocolLabelW = [self.agreeProtocolLabel.text sizeWithFont:self.agreeProtocolLabel.font maxW:MAXFLOAT].width;
    self.agreeProtocolLabel.frame = CGRectMake(CGRectGetMinX(self.registerButton.frame) + 10.0, _registerButton.bottom+AdaptedHeight(10), agreeProtocolLabelW, 20.0);
    
    self.protocolButton.frame = CGRectMake(CGRectGetMaxX(self.agreeProtocolLabel.frame), CGRectGetMinY(self.agreeProtocolLabel.frame), 150.0, CGRectGetHeight(self.agreeProtocolLabel.frame));
    
   
//    V1.7.0 抛弃
//    self.serviceLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.registerButton.frame) + 20.0, Main_Screen_Width, 17.0);
//    NSString *telStr = [NSString stringWithFormat:@"%@%@", self.telLabel.text, self.telButton.currentTitle];
//    CGFloat telWidth = [telStr sizeWithFont:self.telLabel.font maxW:MAXFLOAT].width;
//    CGFloat telLabelW = [self.telLabel.text sizeWithFont:self.telLabel.font maxW:MAXFLOAT].width;
//
//    self.telLabel.frame = CGRectMake((Main_Screen_Width - telWidth) / 2.0, CGRectGetMaxY(self.serviceLabel.frame), telLabelW, 17.0);
//    self.telButton.frame = CGRectMake(CGRectGetMaxX(self.telLabel.frame), CGRectGetMinY(self.telLabel.frame), Main_Screen_Width - 100.0, CGRectGetHeight(self.telLabel.frame));
//    -----------
    _scrollView.contentSize = CGSizeMake(0, self.protocolButton.bottom);
}


#pragma mark - getters and setters
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (LSInputTextField *)phoneInput{
    if (_phoneInput == nil) {
        _phoneInput = [[LSInputTextField alloc] init];
        _phoneInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _phoneInput.inputPlaceHolder = kPhoneInputReminder;
        _phoneInput.editShowRight = YES;
        _phoneInput.leftImageStr = @"user_phone";
        _phoneInput.rightImageStr = @"login_delete";
        _phoneInput.isLineHighlighted = YES;
        [_phoneInput addTextFieldDelegate];
    }
    return _phoneInput;
}

- (LSInputTextField *)securityCodeInput{
    if (_securityCodeInput == nil) {
        _securityCodeInput = [[LSInputTextField alloc] init];
        _securityCodeInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _securityCodeInput.inputPlaceHolder = kVerifyCodeInputReminder;
        _securityCodeInput.leftImageStr = @"verify_code";
        _securityCodeInput.isLineHighlighted = YES;
    }
    return _securityCodeInput;
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
//V1.7.0 抛弃-----------
- (UIButton *)showRecommendButton{
    if (_showRecommendButton == nil) {
        _showRecommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showRecommendButton setImage:[UIImage imageNamed:@"common_row_up"] forState:UIControlStateNormal];
        [_showRecommendButton addTarget:self action:@selector(showRecommendButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        _showRecommendButton.backgroundColor = [UIColor redColor];
        _showRecommendButton.hidden = YES;
    }
    return _showRecommendButton;
}
-(UILabel*)lbRecommendPrompt{
    if (!_lbRecommendPrompt) {
        _lbRecommendPrompt = [[UILabel alloc]init];
        [_lbRecommendPrompt setFont:[UIFont systemFontOfSize:12]];
        _lbRecommendPrompt.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        _lbRecommendPrompt.textAlignment = NSTextAlignmentLeft;
        _lbRecommendPrompt.text = @"*推荐人手机号";
        _lbRecommendPrompt.hidden = YES;
    }
    return _lbRecommendPrompt;
}
- (LSInputTextField *)recommendInput{
    if (_recommendInput == nil) {
        _recommendInput = [[LSInputTextField alloc] init];
        _recommendInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _recommendInput.inputPlaceHolder = kRecommenderPhoneInputReminder;
        _recommendInput.leftImageStr = @"user_phone";
        _recommendInput.alpha = 0.0;
    }
    return _recommendInput;
}
//--------------

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _registerButton.layer.cornerRadius = 3;
        _registerButton.backgroundColor = K_MainColor;
        _registerButton.clipsToBounds = YES;
    }
    return _registerButton;
}

- (JKCountDownButton *)getCodeButton{
    if (_getCodeButton == nil) {
        _getCodeButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _getCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _getCodeButton.backgroundColor = [UIColor clearColor];
    }
    return _getCodeButton;
}

- (UILabel *)agreeProtocolLabel{
    if (_agreeProtocolLabel == nil) {
        _agreeProtocolLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:12 alignment:NSTextAlignmentLeft];
        _agreeProtocolLabel.text = @"注册代表您已阅读并同意";
    }
    return _agreeProtocolLabel;
}

- (UIButton *)protocolButton{
    if (_protocolButton == nil) {
        _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolButton setTitle:@"《闪到用户服务协议》" forState:UIControlStateNormal];
        _protocolButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_protocolButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        [_protocolButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    return _protocolButton;
}
// V1.7.0 抛弃

- (UILabel *)serviceLabel{
    if (_serviceLabel == nil) {
        _serviceLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:12 alignment:NSTextAlignmentCenter];
//        _serviceLabel.text = [NSString stringWithFormat:@"本服务由%@提供",kCompanyName];
        _serviceLabel.hidden = YES;
    }
    return _serviceLabel;
}

- (UILabel *)telLabel{
    if (_telLabel == nil) {
        _telLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:12 alignment:NSTextAlignmentLeft];
        _telLabel.text = @"客服电话";
        _telLabel.hidden = YES;
    }
    return _telLabel;
}
- (UIButton *)telButton{
    if (_telButton == nil) {
        _telButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_telButton setTitle:kCustomerServicePhone forState:UIControlStateNormal];
        _telButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_telButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        [_telButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        _telButton.hidden = YES;
    }
    return _telButton;
}
// -------
#pragma mark - 注册页面统计
- (void)enterRegisterPageStatistics{
}

#pragma mark - 注册页点击获取验证码
- (void)fverificationCodeStatistics:(NSString *)phone{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"userPhone"];
}

#pragma mark - 注册按钮点击
- (void)registerStatistics:(NSString *)phone{
    [ZTMXFUMengHelper mqEvent:k_regist_getYZM parameter:@{@"Phone":phone}];
    
}

#pragma mark - 注册成功统计
- (void)registSucceedStatistics:(NSString *)phone{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"userPhone"];
}

@end
