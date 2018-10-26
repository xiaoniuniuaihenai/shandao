//
//  ShanDaoCheckLoginViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ShanDaoCheckLoginViewController.h"
#import "LSInputTextField.h"
#import "JKCountDownButton.h"
#import "GetVerifyCodeApi.h"
#import "LoginApi.h"

@interface ShanDaoCheckLoginViewController ()

/** 验证码发送提示 */
@property (nonatomic, strong) UILabel *reminderLabel;
/** 验证码 */
@property (nonatomic, strong) LSInputTextField *securityCodeInput;
/** 获取验证码按钮 */
@property (nonatomic, strong) JKCountDownButton *getCodeButton;
/** 确认按钮 */
@property (nonatomic, strong) UIButton         *confirmButton;

@end

@implementation ShanDaoCheckLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    [self configueSubViews];
    //  发送验证码
    [self.getCodeButton touched:self.getCodeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response(按钮,手势点击事件)
//  获取验证码
- (void)gainVerifyCode{
    GetVerifyCodeApi *verifyCodeApi = [[GetVerifyCodeApi alloc] initWithUserPhone:self.phoneNumber codeType:@"L" imgCode:nil];
    [SVProgressHUD showLoadingWithOutMask];
    [verifyCodeApi requestWithSuccess:^(NSDictionary *responseDict) {
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
        }

    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        self.getCodeButton.enabled = YES;
    }];
}

//  点击确认按钮
- (void)confirmButtonAction{
    if ([self verifyLogin]) {
        NSString *userName = self.phoneNumber;
        NSString *password = self.password;
        
        [[NSUserDefaults standardUserDefaults] setValue:userName forKey:kUserPhoneNumber];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [SVProgressHUD showLoadingWithOutMask];
        LoginApi *loginApi = [[LoginApi alloc] initWithLoginType:@"L" password:password securityCode:self.securityCodeInput.inputText];
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
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [self.view makeCenterToast:@"登录失败"];
                }
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

#pragma mark - 私有方法
- (BOOL)verifyLogin{
    if (self.securityCodeInput.inputText.length <= 0) {
        [self.view makeCenterToast:kVerifyCodeInputReminder];
        return NO;
    }
    return YES;
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.reminderLabel];
    [self.view addSubview:self.securityCodeInput];
    [self.view addSubview:self.getCodeButton];
    [self.view addSubview:self.confirmButton];

    [_getCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        //  获取验证码
        [self gainVerifyCode];
    }];
    
    [self.confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [self configueSubViewsFrame];
}

#pragma mark - Configue SubViews Frame(设置子视图frame)
//  设置子视图的frame
- (void)configueSubViewsFrame{
    CGFloat leftMarigin = AdaptedWidth(30.0);
    CGFloat inputViewWidth = Main_Screen_Width - 2 * leftMarigin;
    CGFloat inputViewHeight = 40.0;
    
    self.reminderLabel.frame = CGRectMake(leftMarigin, k_Navigation_Bar_Height + 30.0, inputViewWidth, 40.0);
    self.securityCodeInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.reminderLabel.frame) + AdaptedHeight(25.0), inputViewWidth, inputViewHeight);
    self.getCodeButton.frame = CGRectMake(CGRectGetMaxX(self.securityCodeInput.frame) - 120.0, CGRectGetMinY(self.securityCodeInput.frame), 120.0, inputViewHeight);
    self.confirmButton.frame = CGRectMake(leftMarigin - 10.0, CGRectGetMaxY(self.securityCodeInput.frame) + AdaptedHeight(80), inputViewWidth + 20.0, AdaptedHeight(44.0));
}


#pragma mark - getters and setters

- (UILabel *)reminderLabel{
    if (_reminderLabel == nil) {
        _reminderLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:15 alignment:NSTextAlignmentLeft];
        NSString *phoneNumber = [NSString phoneNumberTransform:self.phoneNumber];
        _reminderLabel.text = [NSString stringWithFormat:@"验证码已发送至手机号%@", phoneNumber];
    }
    return _reminderLabel;
}

- (LSInputTextField *)securityCodeInput{
    if (_securityCodeInput == nil) {
        _securityCodeInput = [[LSInputTextField alloc] init];
        _securityCodeInput.inputKeyBoardType = UIKeyboardTypeNumberPad;
        _securityCodeInput.inputPlaceHolder = kVerifyCodeInputReminder;
        _securityCodeInput.leftImageStr = @"verify_code";
    }
    return _securityCodeInput;
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

- (UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _confirmButton.layer.cornerRadius = 3;
        _confirmButton.backgroundColor = K_MainColor;
        _confirmButton.clipsToBounds = YES;
    }
    return _confirmButton;
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
