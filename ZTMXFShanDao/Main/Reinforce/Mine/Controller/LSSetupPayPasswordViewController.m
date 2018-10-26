//
//  LSSetupPayPasswordViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSetupPayPasswordViewController.h"
#import "PasswordFieldView.h"
#import "CheckPayPasswordApi.h"
#import "SetupPayPwdApi.h"
#import "RealNameManager.h"
#import "UIViewController+ReturnBack.h"

@interface LSSetupPayPasswordViewController ()<PasswordFieldViewDelegate>

@property (nonatomic, strong) UILabel *passwordDescribeLabel;
@property (nonatomic, strong) PasswordFieldView *passwordView;
/** 忘记密码 */
@property (nonatomic, strong) UIButton          *forgetPasswordButton;

@end

@implementation LSSetupPayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置支付密码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_interactivePopDisabled = YES;
    [self configueSubViews];
}

#pragma mark - 点击返回按钮
- (void)clickReturnBackEvent{
    if (_passwordType == ForgetPasswordSetupPassowrd) {
        //  忘记密码设置支付密码
        [RealNameManager realNameBackSuperVc:self];
    } else if (_passwordType == ModifyPasswordSetupPassword) {
        //  修改支付密码 (返回我的页面)
        [self returnBackWithControllerName:@"LSSettingViewController"];
    } else if (_passwordType == InputOriginalPassword) {
        //  输入原来支付密码
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 代理方法
#pragma mark - 密码输入完代理方法
- (void)passwordFieldViewCompletePasswordInput:(NSString *)passwordStr{
    NSLog(@"%@", passwordStr);
    if (_passwordType == InputOriginalPassword) {
        //  输入原密码
        [self checkPayPassword:passwordStr];
    } else if (_passwordType == ModifyPasswordSetupPassword) {
        //  修改密码输入新的支付密码
        [self setupNewPayPwd:passwordStr type:@"C" verifyCode:nil idNumber:nil];
    } else if (_passwordType == ForgetPasswordSetupPassowrd) {
        //  忘记密码设置新的支付密码
        //  忘记支付密码的时候需要传(验证码和身份证(base64))
        [self setupNewPayPwd:passwordStr type:@"F" verifyCode:self.verifyCode idNumber:self.idNumber];
    }
}

#pragma mark - 接口请求
#pragma mark 校验原来支付密码是否正确
- (void)checkPayPassword:(NSString *)password{
    CheckPayPasswordApi *api = [[CheckPayPasswordApi alloc] initWithPassword:password];
    [SVProgressHUD showLoading];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSSetupPayPasswordViewController *setupPayVC = [[LSSetupPayPasswordViewController alloc] init];
            setupPayVC.passwordType = ModifyPasswordSetupPassword;
            setupPayVC.originalPassword = password;
            [self.navigationController pushViewController:setupPayVC animated:YES];
        }
            
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark 设置新的支付密码
//  设置支付密码
- (void)setupNewPayPwd:(NSString *)newPassword type:(NSString *)type verifyCode:(NSString *)verifyCode idNumber:(NSString *)idNumber{
    SetupPayPwdApi *setupPayApi = [[SetupPayPwdApi alloc] initWithOriginalPassword:self.originalPassword newPassword:newPassword verifyCode:verifyCode idNumber:idNumber type:type];
    [SVProgressHUD showLoading];
    [setupPayApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            [self.view makeCenterToast:@"设置支付密码成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self clickReturnBackEvent];
            });
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 按钮点击事件
- (void)forgetPasswordButtonAction{
    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSetPayPawBackRoot isSaveBackVcName:YES];
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.passwordDescribeLabel];
    [self.view addSubview:self.passwordView];
    [self.passwordView passwordTextFeildBecomeFirstResponder];
    [self.view addSubview:self.forgetPasswordButton];
    
    self.forgetPasswordButton.hidden = YES;
    if (_passwordType == InputOriginalPassword) {
        //  输入原支付密码
        self.passwordDescribeLabel.text = @"请输入原支付密码, 完成身份验证";
        self.forgetPasswordButton.hidden = NO;

    } else if (_passwordType == ModifyPasswordSetupPassword) {
        //  修改密码输入新的支付密码
        self.passwordDescribeLabel.text = @"请输入新的支付密码";
    } else if (_passwordType == ForgetPasswordSetupPassowrd) {
        //  忘记密码设置新的支付密码
        self.passwordDescribeLabel.text = @"请输入新的支付密码";
    }
    
    self.passwordDescribeLabel.frame = CGRectMake(10.0, k_Navigation_Bar_Height + 40.0, Main_Screen_Width - 20.0, 20.0);
    self.passwordView.frame = CGRectMake(20.0, CGRectGetMaxY(self.passwordDescribeLabel.frame) + 20.0, Main_Screen_Width - 40.0, 60.0);
    self.forgetPasswordButton.frame = CGRectMake(CGRectGetMaxX(self.passwordView.frame) - 130.0, CGRectGetMaxY(self.passwordView.frame) + 10, 120.0, 30);
    
    [self.forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - getters and setters
- (UILabel *)passwordDescribeLabel{
    if (_passwordDescribeLabel == nil) {
        _passwordDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:15 alignment:NSTextAlignmentCenter];
    }
    return _passwordDescribeLabel;
}

- (PasswordFieldView *)passwordView{
    if (_passwordView == nil) {
        _passwordView = [[PasswordFieldView alloc] init];
        _passwordView.delegate = self;
    }
    return _passwordView;
}

- (UIButton *)forgetPasswordButton{
    if (_forgetPasswordButton == nil) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        _forgetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _forgetPasswordButton;
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
