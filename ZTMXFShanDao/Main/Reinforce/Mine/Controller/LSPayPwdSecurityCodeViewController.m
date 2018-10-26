//
//  LSPayPwdSecurityCodeViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSPayPwdSecurityCodeViewController.h"
#import "LSPayPwdIdVerifyViewController.h"
#import "LSInputTextField.h"
#import "JKCountDownButton.h"
#import "GetVerifyCodeApi.h"
#import "CheckVerifyCodeApi.h"
#import "ZTMXFCreditxTextField.h"

@interface LSPayPwdSecurityCodeViewController ()
/** 验证码发送提示 */
@property (nonatomic, strong) UILabel *reminderLabel;
/** 验证码 */
@property (nonatomic, strong) LSInputTextField *securityCodeInput;
/** 获取验证码按钮 */
@property (nonatomic, strong) JKCountDownButton *getCodeButton;
/** 确认按钮 */
@property (nonatomic, strong) XLButton         *confirmButton;


@end

@implementation LSPayPwdSecurityCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置支付密码";
    [self configueSubViews];
    //  发送验证码
    [self.getCodeButton touched:self.getCodeButton];

}

#pragma mark - Event Response(按钮,手势点击事件)
//  获取验证码
- (void)gainVerifyCode
{
    GetVerifyCodeApi *verifyCodeApi = [[GetVerifyCodeApi alloc] initWithUserPhone:[LoginManager userPhone] codeType:@"P" imgCode:nil];
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
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        self.getCodeButton.enabled = YES;
    }];
}

//  点击确认按钮
- (void)confirmButtonAction{
    if ([self verifyLogin]) {
        CheckVerifyCodeApi *api = [[CheckVerifyCodeApi alloc] initWithCode:self.securityCodeInput.inputText type:@"P"];
        [SVProgressHUD showLoading];
        [api requestWithSuccess:^(NSDictionary *responseDict) {
            NSLog(@"%@", responseDict);
            [SVProgressHUD dismiss];
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                NSString *userName = [responseDict[@"data"][@"realName"] description];
                LSPayPwdIdVerifyViewController *idVerifyVC = [[LSPayPwdIdVerifyViewController alloc] init];
                idVerifyVC.userName = userName;
                idVerifyVC.verifyCode = self.securityCodeInput.inputText;
                [self.navigationController pushViewController:idVerifyVC animated:YES];
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
    [self.securityCodeInput.inputTextField becomeFirstResponder];
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
    
    self.reminderLabel.frame = CGRectMake(leftMarigin, k_Navigation_Bar_Height + 30.0, inputViewWidth, 45.0);
    self.securityCodeInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.reminderLabel.frame) + AdaptedHeight(25.0), inputViewWidth, inputViewHeight);
    self.getCodeButton.frame = CGRectMake(CGRectGetMaxX(self.securityCodeInput.frame) - 120.0, CGRectGetMinY(self.securityCodeInput.frame), 120.0, inputViewHeight);
    self.confirmButton.frame = CGRectMake(leftMarigin - 10.0, CGRectGetMaxY(self.securityCodeInput.frame) + AdaptedHeight(80), inputViewWidth + 20.0, AdaptedHeight(44.0));
}


#pragma mark - getters and setters

- (UILabel *)reminderLabel{
    if (_reminderLabel == nil) {
        _reminderLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:15 alignment:NSTextAlignmentLeft];
        NSString *phoneNumber = [NSString phoneNumberTransform:[LoginManager userPhone]];
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

- (XLButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [XLButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = FONT_Medium(15);
    }
    return _confirmButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
