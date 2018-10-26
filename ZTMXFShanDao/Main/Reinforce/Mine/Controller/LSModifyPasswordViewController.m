//
//  LSModifyPasswordViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSModifyPasswordViewController.h"
#import "LSInputTextField.h"
#import "ModifyLoginPwdApi.h"
#import "ZTMXFCreditxTextField.h"

@interface LSModifyPasswordViewController ()

/** 原密码 */
@property (nonatomic, strong) LSInputTextField  *originalPasswordInput;
/** 原密码 */
@property (nonatomic, strong) LSInputTextField  *newPasswordInput;
/** 提交 */
@property (nonatomic, strong) XLButton          *submitButton;

@end

@implementation LSModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改登录密码";
    [self configueSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮手势通知方法
- (void)submitButtonAction{
    NSLog(@"提交");
    if ([self verifyPassword]) {
        NSString *oldPwd = [self.originalPasswordInput.inputText MD5];
        NSString *newPwd = [self.newPasswordInput.inputText MD5];
        ModifyLoginPwdApi *modifyApi = [[ModifyLoginPwdApi alloc] initWithOriginalPassword:oldPwd newPassword:newPwd];
        [SVProgressHUD showLoading];
        [modifyApi requestWithSuccess:^(NSDictionary *responseDict) {
            NSString *codeStr = [responseDict[@"code"] description];
            [SVProgressHUD dismiss];
            if ([codeStr isEqualToString:@"1000"]) {
                [self.view makeCenterToast:@"修改密码成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

//  原始密码切换明文
- (void)originalPasswordInputAction{
    if (self.originalPasswordInput.inputTextField.isSecureTextEntry) {
        //  设置不明文
        self.originalPasswordInput.rightImageStr = @"login_password";
        self.originalPasswordInput.inputTextField.secureTextEntry = NO;
    } else {
        //  设置明文
        self.originalPasswordInput.rightImageStr = @"login_password_security";
        self.originalPasswordInput.inputTextField.secureTextEntry = YES;
    }
}

//  新密码切换明文
- (void)newPasswordInputAction{
    if (self.newPasswordInput.inputTextField.isSecureTextEntry) {
        //  设置不明文
        self.newPasswordInput.rightImageStr = @"login_password";
        self.newPasswordInput.inputTextField.secureTextEntry = NO;
    } else {
        //  设置明文
        self.newPasswordInput.rightImageStr = @"login_password_security";
        self.newPasswordInput.inputTextField.secureTextEntry = YES;
    }
}

#pragma mark - 私有方法
- (BOOL)verifyPassword{
    
    if (self.originalPasswordInput.inputText.length <= 0) {
        [self.view makeCenterToast:kOriginalPasswordInputRemider];
        return NO;
    }
    if (self.newPasswordInput.inputText.length <= 0) {
        [self.view makeCenterToast:kNewPasswordInputRemider];
        return NO;
    }
    
    BOOL oldPasswordVerify = [NSString checkLoginPwdRule:self.originalPasswordInput.inputText];
    if (self.originalPasswordInput.inputText.length >= 6 && self.originalPasswordInput.inputText.length <= 18 && oldPasswordVerify) {
        BOOL newPasswordVerify = [NSString checkLoginPwdRule:self.newPasswordInput.inputText];
        if (self.newPasswordInput.inputText.length >= 6 && self.newPasswordInput.inputText.length <= 18 && newPasswordVerify) {
            return YES;
        } else {
            [self.view makeCenterToast:kPasswordInputReminder];
            return NO;
        }
    } else {
        [self.view makeCenterToast:kPasswordInputReminder];
        return NO;
    }
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.originalPasswordInput];
    [self.view addSubview:self.newPasswordInput];
    [self.view addSubview:self.submitButton];
    
    [self.submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.originalPasswordInput.rightButton addTarget:self action:@selector(originalPasswordInputAction) forControlEvents:UIControlEventTouchUpInside];
    [self.newPasswordInput.rightButton addTarget:self action:@selector(newPasswordInputAction) forControlEvents:UIControlEventTouchUpInside];
    [self configueSubViewsFrame];
}

#pragma mark - Configue SubViews Frame(设置子视图frame)
//  设置子视图的frame
- (void)configueSubViewsFrame{
    CGFloat leftMarigin = AdaptedWidth(30.0);
    CGFloat inputViewWidth = Main_Screen_Width - 2 * leftMarigin;
    CGFloat inputViewHeight = 40.0;
    
    self.originalPasswordInput.frame = CGRectMake(leftMarigin, k_Navigation_Bar_Height + AdaptedHeight(30.0), inputViewWidth, inputViewHeight);
    self.newPasswordInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.originalPasswordInput.frame) + 15.0, inputViewWidth, inputViewHeight);
    self.submitButton.frame = CGRectMake(leftMarigin - 10.0, CGRectGetMaxY(self.newPasswordInput.frame) + AdaptedHeight(50.0), inputViewWidth + 20.0, AdaptedHeight(44.0));
}


#pragma mark - getters and setters
- (LSInputTextField *)originalPasswordInput{
    if (_originalPasswordInput == nil) {
        _originalPasswordInput = [[LSInputTextField alloc] init];
        _originalPasswordInput.inputTextField.secureTextEntry = YES;
        _originalPasswordInput.inputPlaceHolder = kOriginalPasswordInputRemider;
        _originalPasswordInput.leftImageStr = @"user_passowrd";
        _originalPasswordInput.rightImageStr = @"login_password_security";
    }
    return _originalPasswordInput;
}

- (LSInputTextField *)newPasswordInput{
    if (_newPasswordInput == nil) {
        _newPasswordInput = [[LSInputTextField alloc] init];
        _newPasswordInput.inputTextField.secureTextEntry = YES;
        _newPasswordInput.inputPlaceHolder = kNewPasswordInputRemider;
        _newPasswordInput.leftImageStr = @"user_passowrd";
        _newPasswordInput.rightImageStr = @"login_password_security";
    }
    return _newPasswordInput;
}

- (XLButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [XLButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitButton;
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
