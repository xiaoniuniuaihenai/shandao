//
//  ZTMXFSecurityPayViewController.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFSecurityPayViewController.h"
#import "ZTMXFSecurityPayView.h"
#import "ZTMXFSecurityPayHeaderView.h"
#import "XLButton.h"
#import "JKCountDownButton.h"
#import "LSBindBankCardApi.h"
#import "ZTMXFPayPWDViewController.h"
#import "RealNameManager.h"
#import "ZTMXFPayManager.h"
#import "ZTMXFBankCardCodeApi.h"
#import "LSIdfBindCardViewController.h"
@interface ZTMXFSecurityPayViewController ()<UITextFieldDelegate, ZTMXFPayPWDViewControllerDelegate>

@property (nonatomic, strong)ZTMXFSecurityPayView * securityPayView;

@property (nonatomic, strong)XLButton * submitBtn;

@end

@implementation ZTMXFSecurityPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全验证";
    self.view.backgroundColor = K_BackgroundColor;
    _securityPayView = [[ZTMXFSecurityPayView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, KW, KH / 2)];
    [self.view addSubview:_securityPayView];
    _securityPayView.bankInfoDic = _bankInfoDic;
    _securityPayView.codeTF.delegate = self;
    [_securityPayView.codeTF addTarget:self action:@selector(codeTFChange) forControlEvents:UIControlEventEditingChanged];
    [_securityPayView.addBankCard addTarget:self action:@selector(addBankBtnAction) forControlEvents:UIControlEventTouchUpInside];
    MJWeakSelf
    [_securityPayView.getCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [sender startCountDownWithSecond:60];
        [weakSelf httpBankCardCode];
        sender.layer.borderColor = COLOR_SRT(@"999999").CGColor;
        [sender setTitleColor:COLOR_SRT(@"999999") forState:UIControlStateNormal];

    }];
    [self.view addSubview:self.submitBtn];
    
    
    // Do any additional setup after loading the view.
}




- (void)httpBankCardCode
{
    ZTMXFBankCardCodeApi * bindBankCardApi = [[ZTMXFBankCardCodeApi alloc] initWithBankCardId:_bankCardId];
    [bindBankCardApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {

        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

- (void)addBankBtnAction
{
    LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
    bankVc.isSigning = YES;
    bankVc.bindCardType = BindBankCardTypeCommon;
    [self.navigationController pushViewController:bankVc animated:YES];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *strMobile = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSRange rangeStr = [@"1234567890" rangeOfString:string];
    if ([string isEqualToString:@""]) { //删除字符
        return YES;
    } else if ([strMobile length] >= 6|| rangeStr.length <=0) {
        return NO;
    }
    return YES;
    
}
- (void)codeTFChange
{
    if (_securityPayView.codeTF.text.length) {
        _submitBtn.backgroundColor = K_MainColor;
        _submitBtn.userInteractionEnabled = YES;
        if (_securityPayView.codeTF.text.length > 6) {
            _securityPayView.codeTF.text = [_securityPayView.codeTF.text substringToIndex:6];
        }
    }else{
        _submitBtn.backgroundColor = COLOR_SRT(@"#FDCF95");
        _submitBtn.userInteractionEnabled = NO;
    }
}
- (BOOL)hideNavigationBottomLine
{
    return YES;
}

- (void)securityPaySubmitBtnAction
{
    LSBindBankCardApi * bindBankCardApi = [[LSBindBankCardApi alloc] initWithBankId:_bankCardId andVerifyCode:_securityPayView.codeTF.text type:1];
    [bindBankCardApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            [self goPay];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

///** 点击忘记密码 */
//- (void)clickForgetButton
//{
//    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
//
//}
///** 密码输入完成 */
//- (void)passwordPopupViewEnterPassword:(NSString *)password
//{
//    [self.paramDict setObject:password forKey:@"payPwd"];
//    [ZTMXFPayManager delayPayParameters:self.paramDict success:^(id responseObject) {
//        [self payManagerDidPaySuccess:responseObject];
//    } failure:^(id failureObject) {
//        [self payManagerDidPayFail:failureObject];
//    }];
//}



- (XLButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [XLButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = FONT_Medium(16 * PX);
        [_submitBtn addTarget:self action:@selector(securityPaySubmitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.frame = CGRectMake(20, KH - 72 * PX, KW - 40, 44 * PX);
//        #FDCF95 100%
        _submitBtn.userInteractionEnabled = NO;
        _submitBtn.backgroundColor = COLOR_SRT(@"#FDCF95");
    }
    return _submitBtn;
}
- (void)goPay
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(signCompleteBankCardId:)]) {
        [_delegate signCompleteBankCardId:_bankCardId];
    }
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
