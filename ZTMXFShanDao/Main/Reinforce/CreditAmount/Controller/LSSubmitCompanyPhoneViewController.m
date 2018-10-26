//
//  LSSubmitCompanyPhoneViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSubmitCompanyPhoneViewController.h"
#import "LSCompanyPhoneAuthApi.h"

@interface LSSubmitCompanyPhoneViewController ()<UITextFieldDelegate>

/** company phone textfield */
@property (nonatomic, strong) UITextField *phoneTextField;
/** 描述 */
@property (nonatomic, strong) UILabel     *companyPhoneDescribe;
/** 提交按钮 */
@property (nonatomic, strong) ZTMXFButton    *submitButton;
@end

@implementation LSSubmitCompanyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写单位电话";
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    [self configSubViews];
}

#pragma mark - UITextFieldDelegate

- (void)phoneTextFieldDidChange:(UITextField *)sender{
    [self submitButtonStateChange];
}

- (void)submitButtonStateChange{
    NSString *phoneNumber = self.phoneTextField.text;
    if (phoneNumber.length > 0) {
        self.submitButton.enabled = YES;
    } else {
        self.submitButton.enabled = NO;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self submitButtonStateChange];
}

#pragma mark - 按钮点击事件
- (void)submitButtonAction{
    
    if (kStringIsEmpty(self.phoneTextField.text)) {
        [self.view makeCenterToast:@"请填写公司号码"];
        return;
    }
    
    LSCompanyPhoneAuthApi * certfyInfoApi =  [[LSCompanyPhoneAuthApi alloc] initWithCompanyPhone:self.phoneTextField.text];
    [SVProgressHUD showLoading];
    [certfyInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(submitCompanyPhoneViewSuccess:)]) {
                [self.delegate submitCompanyPhoneViewSuccess:self.phoneTextField.text];
            }
            [self.view makeCenterToast:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - configsubViews
- (void)configSubViews{
    
    self.phoneTextField.frame = CGRectMake(0.0, k_Navigation_Bar_Height + 10.0, Main_Screen_Width, 50.0);
    CGFloat companyPhoneDescribeX = 15.0;
    CGFloat companyPhoneDescribeW = Main_Screen_Width - companyPhoneDescribeX * 2;
    CGFloat companyPhoneDescribeH = [self.companyPhoneDescribe.text sizeWithFont:self.companyPhoneDescribe.font maxW:companyPhoneDescribeW].height;
    self.companyPhoneDescribe.frame = CGRectMake(companyPhoneDescribeX, CGRectGetMaxY(self.phoneTextField.frame) + 13, companyPhoneDescribeW, companyPhoneDescribeH);
    self.submitButton.frame = CGRectMake(AdaptedWidth(28.0), CGRectGetMaxY(self.companyPhoneDescribe.frame) + 85.0, Main_Screen_Width - AdaptedWidth(28) * 2, AdaptedHeight(44.0));
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.companyPhoneDescribe];
    [self.view addSubview:self.submitButton];
    
    [self.submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - setter getter
- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.font = [UIFont systemFontOfSize:15];
        _phoneTextField.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _phoneTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.placeholder = @"请填写所在单位电话号码 (区号-公司电话)";
        _phoneTextField.delegate = self;
        if (!kStringIsEmpty(_companyPhone)) {
            _phoneTextField.text = _companyPhone;
        }
        
        UIView *leftView = [[UIView alloc] init];
        leftView.frame = CGRectMake(0.0, 0.0, 20.0, 10.0);
        _phoneTextField.leftView = leftView;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneTextField;
}

- (UILabel *)companyPhoneDescribe{
    if (_companyPhoneDescribe == nil) {
        _companyPhoneDescribe = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _companyPhoneDescribe.text = @"包括单位电话在内的数据, 仅用作信用认证, 您的个人信息以严格的认证标准进行保护, 未经授权不会向任何第三方提供.";
    }
    return _companyPhoneDescribe;
}


- (ZTMXFButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    }
    return _submitButton;
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
