//
//  LSLoanRenewalViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanRenewalViewController.h"
#import "LSPaySuccessViewController.h"
#import "LSPayFailureViewController.h"
#import "LSLoanRenewalView.h"
#import "LSLoanRenewalViewModel.h"
#import "BankCardModel.h"
#import "RealNameManager.h"
#import "PayManager.h"
#import "NSString+DictionaryValue.h"
#import "ZTMXFDeferredGuidePage.h"
#import "LSBrwRenewalaInfoModel.h"
#import "GetUserInfoApi.h"
//#import <TKAlertViewController.h>
#import "LSIdfBindCardViewController.h"
#import "ZTMXFChooseBankViewController.h"
#import "ZTMXFPayPWDViewController.h"
#import "ZTMXFPayManager.h"
#import "ZTMXFSecurityPayViewController.h"

@interface LSLoanRenewalViewController ()<LSLoanRenewalViewModelDelegate, LSLoanRenewalViewDelegate, PayManagerDelegate, ZTMXFChooseBankViewControllerDelegate, ZTMXFPayPWDViewControllerDelegate,ZTMXFSecurityPayViewControllerDelegate>

@property (nonatomic, strong) UILabel                *topDescribeLabel;
@property (nonatomic, strong) LSLoanRenewalView      *loanRenewalView;
@property (nonatomic, strong) LSLoanRenewalViewModel *loanRenewalViewModel;

@property (nonatomic, strong)NSMutableDictionary * paramDict;

@end

@implementation LSLoanRenewalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"延期还款";
    [ZTMXFUMengHelper mqEvent:k_Extendloan_click_xf];
    
    [self configueSubViews];
    //  获取延期页面信息
    [self.loanRenewalViewModel requestLoanRenewalViewInfoWithBorrowId:self.borrowId loanType:self.loanType];
    self.fd_interactivePopDisabled = YES;
}

- (NSMutableDictionary *)paramDict
{
    if (!_paramDict) {
        _paramDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _paramDict;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //判断是不是第一次进入,如果是:弹出引导页
    BOOL result = [USER_DEFAULT boolForKey:@"ZTMXFDeferredGuidePage"];
    if (!result) {
        [ZTMXFDeferredGuidePage show];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ZTMXFDeferredGuidePage"];
        [USER_DEFAULT synchronize];
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        _topDescribeLabel.alpha = 1;
        self.loanRenewalView.frame = CGRectMake(0.0, k_Navigation_Bar_Height + 36.0, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height - 36.0);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)chooseUseBankCardId:(NSString *)bankCardId bankInfoDic:(NSDictionary *)bankInfoDic
{
    ZTMXFSecurityPayViewController * securityPayVC = [[ZTMXFSecurityPayViewController alloc] init];
    securityPayVC.delegate = self;
    securityPayVC.bankInfoDic = bankInfoDic;
    securityPayVC.bankCardId = bankCardId;
    [self.navigationController pushViewController:securityPayVC animated:YES];
}

- (void)signCompleteBankCardId:(NSString *)bankCardId
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self chooseUseBankCardId:bankCardId];
    });
}

#pragma mark - 自定义代理方法
//  延期还款页面信息获取成功
- (void)requestLoanRenewalViewInfoSuccess:(LSBrwRenewalaInfoModel *)renewalInfoModel{
    if (renewalInfoModel) {
        self.loanRenewalView.renewalInfoModel = renewalInfoModel;
        self.topDescribeLabel.text = renewalInfoModel.msgTig;
    }
}

#pragma mark LSLoanRenewalViewDelegate
//  添加银行卡
- (void)boneRenwalViewAddBankCard
{
    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCard isSaveBackVcName:YES];
}

//  点击延期还款
- (void)renewalPoundageRate:(NSString *)poundageRate
{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"submit.hq_yqhk_fk" OtherDict:nil];
    NSString *renewalAmountStr = self.loanRenewalView.renewalAmount;
    NSString *renewalCapitalAmountStr = self.loanRenewalView.renewalCapitalAmount;
    self.paramDict  = [ZTMXFPayManager setLoanRenewalParamsWithBorrowId:self.borrowId cardId:nil renewalAmount:renewalAmountStr repaymentCapital:renewalCapitalAmountStr loanType:self.loanType renewalPoundageRate:poundageRate];
    
    ZTMXFChooseBankViewController * chooseBankVC = [[ZTMXFChooseBankViewController alloc] init];
    chooseBankVC.showOfflinePay = 0;
    chooseBankVC.delegate = self;
    chooseBankVC.amountStr = self.loanRenewalView.payAmount;
    chooseBankVC.bizCode = @"RENEWAL_PAY";
    chooseBankVC.borrowId = self.borrowId;
    chooseBankVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:chooseBankVC animated:NO completion:^{
        chooseBankVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}

//** 选择使用的银行卡id   -6 -4支付宝线下  >0 银行卡支付   -111  添加银行卡  */
- (void)chooseUseBankCardId:(NSString *)bankCardId
{
    NSInteger bankId = [bankCardId integerValue];
    if(bankId == -111){
        [self goBindingBankCard];
    }else if(bankId > 0){
        [self.paramDict setValue:bankCardId forKey:@"cardId"];
        ZTMXFPayPWDViewController * payPWDVC = [[ZTMXFPayPWDViewController alloc] init];
        payPWDVC.delegate = self;
        payPWDVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:payPWDVC animated:NO completion:^{
            payPWDVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        }];
    }else if(bankId == -5){
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = DefineUrlString(otherPayType);
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma ZTMXFPayPWDViewControllerDelegate method
/** 点击忘记密码 */
- (void)clickForgetButton
{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"click.hq_ljhk_fk_wjmm" OtherDict:nil];
    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
    
}
/** 密码输入完成 */
- (void)passwordPopupViewEnterPassword:(NSString *)password
{
    [self.paramDict setObject:password forKey:@"payPwd"];
    [ZTMXFPayManager delayPayParameters:self.paramDict success:^(id responseObject) {
        [self payManagerDidPaySuccess:responseObject];
    } failure:^(id failureObject) {
        [self payManagerDidPayFail:failureObject];
    }];
}


#pragma mark PayManagerDelegate支付结果
/** pay success */
- (void)payManagerDidPaySuccess:(NSDictionary *)successInfo{
    [self paySuccessResult:successInfo];
    [ZTMXFUMengHelper mqEvent:k_Extendloan_pay_succ_xf parameter:@{@"arrears":[NSString stringWithFormat:@"%f",self.repaymentAmount]}];
    
}

//  延期还款成功跳转
- (void)paySuccessResult:(NSDictionary *)resultDict{
    NSDictionary *dataDict = resultDict[@"data"];
    NSString *submitName = [dataDict[@"submitName"] description];
    NSString *submitDesc = [dataDict[@"submitDesc"] description];
    NSString *checkName = [dataDict[@"checkName"] description];
    NSString *checkDesc = [dataDict[@"checkDesc"] description];
    LSPaySuccessViewController *successVC = [[LSPaySuccessViewController alloc] init];
    successVC.submitName = submitName;
    successVC.submitDesc = submitDesc;
    successVC.finishName = checkName;
    successVC.finishDesc = checkDesc;
    successVC.successResultType = PaySuccessResultRenewalType;
    [self.navigationController pushViewController:successVC animated:YES];
}

/** pay fail */
- (void)payManagerDidPayFail:(NSDictionary *)failInfo{
    [self payFailureResult:failInfo];
    [ZTMXFUMengHelper mqEvent:k_Extendloan_pay_fail_xf parameter:@{@"arrears":[NSString stringWithFormat:@"%f",self.repaymentAmount]}];
    
}

//  延期还款成功跳转
- (void)payFailureResult:(NSDictionary *)resultDict{
    NSString *codeStr = [resultDict[@"code"] description];
    NSString *msgJson = resultDict[@"msg"];
    NSString *submitName = [NSString string];
    NSString *submitDesc = [NSString string];
    if (!kStringIsEmpty(msgJson)) {
        NSDictionary *msgDict = [msgJson dictionaryValue];
        if (msgDict[@"submitName"]) {
            submitName = msgDict[@"submitName"];
        }
        if (msgDict[@"submitDesc"]) {
            submitDesc = msgDict[@"submitDesc"];
            
        }
    }
    
    NSString * rBtnStr = @"";
    NSString * lBtnStr = @"";
    if ([codeStr isEqualToString:@"5001"]) {
        rBtnStr = @"拨打电话";
        lBtnStr = @"我知道了";
        
    } else if ([codeStr isEqualToString:@"6001"]) {
        rBtnStr = @"拨打电话";
        lBtnStr = @"我知道了";
        
    } else  if ([codeStr isEqualToString:@"6002"]) {
        lBtnStr = @"再次尝试";
        rBtnStr = @"添加新卡";
        
    } else if ([codeStr isEqualToString:@"6003"]) {
        lBtnStr = @"我知道了";
        rBtnStr = @"添加新卡";
        
    } else if ([codeStr isEqualToString:@"6004"]) {
        
        lBtnStr = @"我知道了";
        rBtnStr = @"添加新卡";
    } else if ([codeStr isEqualToString:@"6005"]) {
        lBtnStr = @"我知道了";
        rBtnStr = @"添加新卡";
    }
    if (lBtnStr.length > 0) {
        submitDesc = [NSString stringWithFormat:@"\n\n%@\n\n", submitDesc];
        
        MJWeakSelf
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:submitDesc preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:lBtnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf showWithTitle:lBtnStr];
            
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:rBtnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf showWithTitle:rBtnStr];
        }];
        [alert addAction:action1];
        [action1 setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
        
        [alert addAction:action2];
        [action2 setValue:K_2B91F0 forKey:@"titleTextColor"];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void)showWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"拨打电话"]) {
        [self goMakePhoneCall];
    }else if ([title isEqualToString:@"添加新卡"]) {
        [self goBindingBankCard];
    }else if ([title isEqualToString:@"再次尝试"]) {
        [self renewalPoundageRate:_loanRenewalView.currentPoundageRate];
    }
}
/**
 去绑卡页面
 */
- (void)goBindingBankCard
{
    LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
    bankVc.bindCardType = BindBankCardTypeCommon;
    bankVc.loanType = ConsumeLoanType;
    [self.navigationController pushViewController:bankVc animated:YES];
    
}
-(void)goMakePhoneCall
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",K_BankCustomerServiceNum];
    dispatch_after(0.3, dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];//隐私设置
    });
}


#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.topDescribeLabel];
    [self.view addSubview:self.loanRenewalView];
}

#pragma mark - getters and setters
- (LSLoanRenewalView *)loanRenewalView{
    if (_loanRenewalView == nil) {
        _loanRenewalView = [[LSLoanRenewalView alloc] initWithFrame:CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height)];
        _loanRenewalView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _loanRenewalView.totalRepaymentCapitalAmount = [NSDecimalNumber stringWithFloatValue:_repaymentAmount];
        _loanRenewalView.loanRenewalViewDelegate = self;
    }
    return _loanRenewalView;
}




- (UILabel *)topDescribeLabel{
    if (_topDescribeLabel == nil) {
        _topDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:X(14) alignment:NSTextAlignmentCenter];
        _topDescribeLabel.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 36.0);
        _topDescribeLabel.alpha = 0;
        _topDescribeLabel.text = @"您必须还掉部分本金与延期手续费才能办理延期还款。";
        _topDescribeLabel.backgroundColor = [K_MainColor colorWithAlphaComponent:0.12];
    }
    return _topDescribeLabel;
}

- (LSLoanRenewalViewModel *)loanRenewalViewModel{
    if (_loanRenewalViewModel == nil) {
        _loanRenewalViewModel = [[LSLoanRenewalViewModel alloc] init];
        _loanRenewalViewModel.delegate = self;
    }
    return _loanRenewalViewModel;
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
