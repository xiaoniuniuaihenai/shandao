//
//  ZTMXFPayPWDViewController.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPayPWDViewController.h"
#import "PasswordInputView.h"
#import "PasswordFieldView.h"

@interface ZTMXFPayPWDViewController ()<PasswordInputViewDelegate>
/** 密码输入框 */
@property (nonatomic, strong) PasswordInputView         *passwordInputView;
@end

@implementation ZTMXFPayPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    [self.view addSubview:self.passwordInputView];
    

    // Do any additional setup after loading the view.
}



/** 跳过按钮点击 */
- (void)passwordInputViewClickskipButton
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3f animations:^{
        self.passwordInputView.frame = CGRectMake(0, KH, KW, KH / 3 * 2);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (_delegate && [_delegate respondsToSelector:@selector(passwordInputViewClickskipButton)]) {
                [_delegate passwordInputViewClickskipButton];
            }
        }];
    }];
    
}
/** 点击返回按钮 */
- (void)passwordInputViewClickBackButton:(PasswordInputView *)passwordInputView
{
    [self dismissTableView];
}
/** 点击忘记密码 */
- (void)passwordInputViewClickForgetButton
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3f animations:^{
        self.passwordInputView.frame = CGRectMake(0, KH, KW, KH / 3 * 2);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (_delegate && [_delegate respondsToSelector:@selector(clickForgetButton)]) {
                [_delegate clickForgetButton];
            }
        }];
    }];
    
}







- (PasswordInputView *)passwordInputView
{
    if (!_passwordInputView) {
        _passwordInputView = [[PasswordInputView alloc] initWithFrame:CGRectMake(0, KH / 3, KH, KH / 3 * 2)];
        _passwordInputView.delegate = self;
        [_passwordInputView.passwordFieldView.passwordTextField becomeFirstResponder];

    }
    return _passwordInputView;
}
- (void)tapAction
{
    [self dismissTableView];
}

- (void)dismissTableView
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3f animations:^{
        self.passwordInputView.frame = CGRectMake(0, KH, KW, KH / 3 * 2);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
        }];
    }];
}

- (void)showTableView
{
    [UIView animateWithDuration:.3f animations:^{
        self.passwordInputView.frame = CGRectMake(0, KH / 3, KW, KH / 3 * 2);
    }];
}

/** 密码输入完成 */
- (void)passwordInputViewCompleteInputPassword:(PasswordInputView *)passwordInputView password:(NSString *)password
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3f animations:^{
        self.passwordInputView.frame = CGRectMake(0, KH, KW, KH / 3 * 2);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (_delegate && [_delegate respondsToSelector:@selector(passwordPopupViewEnterPassword:)]) {
                [_delegate passwordPopupViewEnterPassword:password];
            }
        }];
    }];
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
