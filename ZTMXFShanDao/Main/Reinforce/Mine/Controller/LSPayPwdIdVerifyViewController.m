//
//  LSPayPwdIdVerifyViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSPayPwdIdVerifyViewController.h"
#import "LSInputTextField.h"
#import "SetupPayPwdIdVerifyApi.h"
#import "LSSetupPayPasswordViewController.h"
#import "NSString+Base64.h"
#import "ZTMXFCreditxTextField.h"

@interface LSPayPwdIdVerifyViewController ()
/** 验证码发送提示 */
@property (nonatomic, strong) UILabel *reminderLabel;
/** 验证码 */
@property (nonatomic, strong) LSInputTextField *securityCodeInput;
/** 确认按钮 */
@property (nonatomic, strong) XLButton         *confirmButton;

@end

@implementation LSPayPwdIdVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置支付密码";
    [self configueSubViews];

}

//  点击确认按钮
- (void)confirmButtonAction
{
    if ([self verifyIdNumber]) {
        SetupPayPwdIdVerifyApi *api = [[SetupPayPwdIdVerifyApi alloc] initWithIdNumber:self.securityCodeInput.inputText];
        [SVProgressHUD showLoading];
        [api requestWithSuccess:^(NSDictionary *responseDict) {
            NSLog(@"%@", responseDict);
            [SVProgressHUD dismiss];
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                LSSetupPayPasswordViewController *idVerifyVC = [[LSSetupPayPasswordViewController alloc] init];
                idVerifyVC.passwordType = ForgetPasswordSetupPassowrd;
                idVerifyVC.idNumber = [self.securityCodeInput.inputText base64EncodedString];
                idVerifyVC.verifyCode = self.verifyCode;
                [self.navigationController pushViewController:idVerifyVC animated:YES];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

#pragma mark - 私有方法
- (BOOL)verifyIdNumber
{
    if (self.securityCodeInput.inputText.length <= 0) {
        [self.view makeCenterToast:kUserIdNumberInputReminder];
        return NO;
    }
    return YES;
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews
{
    [self.view addSubview:self.reminderLabel];
    [self.view addSubview:self.securityCodeInput];
    [self.view addSubview:self.confirmButton];
    
    [self.securityCodeInput.inputTextField becomeFirstResponder];
    [self.confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self configueSubViewsFrame];
}

#pragma mark - Configue SubViews Frame(设置子视图frame)
//  设置子视图的frame
- (void)configueSubViewsFrame
{
    CGFloat leftMarigin = AdaptedWidth(30.0);
    CGFloat inputViewWidth = Main_Screen_Width - 2 * leftMarigin;
    CGFloat inputViewHeight = 40.0;
    
    self.reminderLabel.frame = CGRectMake(leftMarigin, k_Navigation_Bar_Height + 30.0, inputViewWidth, 20.0);
    self.securityCodeInput.frame = CGRectMake(leftMarigin, CGRectGetMaxY(self.reminderLabel.frame) + AdaptedHeight(30.0), inputViewWidth, inputViewHeight);
    self.confirmButton.frame = CGRectMake(leftMarigin - 10.0, CGRectGetMaxY(self.securityCodeInput.frame) + AdaptedHeight(60), inputViewWidth + 20.0, AdaptedHeight(44.0));
}


#pragma mark - getters and setters

- (UILabel *)reminderLabel
{
    if (_reminderLabel == nil) {
        _reminderLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:15 alignment:NSTextAlignmentLeft];
        NSString *userName = [NSString phoneNumberTransform:self.userName];
        _reminderLabel.text = [NSString stringWithFormat:@"填写%@的身份证号 验证身份", userName];
    }
    return _reminderLabel;
}

- (LSInputTextField *)securityCodeInput
{
    if (_securityCodeInput == nil) {
        _securityCodeInput = [[LSInputTextField alloc] init];
        _securityCodeInput.inputKeyBoardType = UIKeyboardTypeNumbersAndPunctuation;
        _securityCodeInput.inputPlaceHolder = kUserIdNumberInputReminder;
    }
    return _securityCodeInput;
}

- (XLButton *)confirmButton
{
    if (_confirmButton == nil) {
        _confirmButton = [XLButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
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
