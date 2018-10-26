//
//  RealNameManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//
//实名认证
#import "JBScanIdentityCardViewController.h"
#import "RealNameManager.h"
#import "LSIdfBindCardViewController.h"
#import "LSCreditAuthenViewController.h"
#import "LSPayPwdSecurityCodeViewController.h"
#import "LSSubmitAuthViewController.h"
#import "LSCreditAuthWebViewController.h"
#import "LSPhoneOperationAuthViewController.h"
#import "LSCompanyAuthViewController.h"
#import "ZTMXFSecurityAuthViewController.h"
#import "WJYAlertView.h"
#import "ZTMXFAlertCustomView.h"

@implementation RealNameManager
+ (void)realNameWithCurrentVc:(UIViewController *)currentVc andRealNameProgress:(RealNameProgress)realProgress isSaveBackVcName:(BOOL)isSave{
    if (isSave) {
        if (realProgress == RealNameProgressSetPayPawBackRoot) {
            currentVc =  currentVc.navigationController.viewControllers.firstObject;
        }
        [RealNameManager saveBackVcNameWithBackVc:currentVc];
    }
    switch (realProgress) {
        case RealNameProgressIdf:
        {
            //                实名认证
            JBScanIdentityCardViewController * idVc = [[JBScanIdentityCardViewController alloc]init];
            [currentVc.navigationController pushViewController:idVc animated:YES];
        }
            break;
        case RealNameProgressBindCardMian:
        case RealNameProgressBindCard:{
            
            //            绑定主卡
            LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
            bankVc.bindCardType = realProgress==RealNameProgressBindCardMian?BindBankCardTypeMain:BindBankCardTypeCommon;
            [currentVc.navigationController pushViewController:bankVc animated:YES];
        }break;
        case RealNameProgressCreditReplenishment:
        case RealNameProgressCreditPromote:{
            //            提升信用
            LSCreditAuthenViewController * creditPromoteVc = [[LSCreditAuthenViewController alloc] init];
            creditPromoteVc.authenType = realProgress == RealNameProgressCreditPromote ? WhiteCreditAuthen : ConsumeCreditAuthen;
            [currentVc.navigationController pushViewController:creditPromoteVc animated:YES];
            
        }break;
        case RealNameProgressSetPayPawBackRoot:
        case RealNameProgressSetPayPaw:{
            //            设置支付密码
            LSPayPwdSecurityCodeViewController *codeVC = [[LSPayPwdSecurityCodeViewController alloc] init];
            [currentVc.navigationController pushViewController:codeVC animated:YES];
        }break;
        case RealNameProgressSetPayPawBackCurrent:{
            //            设置支付密码
            LSPayPwdSecurityCodeViewController *codeVC = [[LSPayPwdSecurityCodeViewController alloc] init];
            [currentVc.navigationController pushViewController:codeVC animated:YES];
        }break;
        case RealNameProgressConsumeLoan:{
            //  跳转到消费贷认证
            LSSubmitAuthViewController *consumeVC = [[LSSubmitAuthViewController alloc] init];
            consumeVC.authType = ConsumeLoanType;
            [currentVc.navigationController pushViewController:consumeVC animated:YES];
        }break;
        case RealNameProgressWhiteLoan:{
            //  跳转到白领贷认证
            LSSubmitAuthViewController *consumeVC = [[LSSubmitAuthViewController alloc] init];
            consumeVC.authType = WhiteLoanType;
            [currentVc.navigationController pushViewController:consumeVC animated:YES];
        }break;
        case RealNameProgressZhiMaAuth:{
            //  跳转到芝麻信用认证
            LSCreditAuthWebViewController *VC = [[LSCreditAuthWebViewController alloc] init];
            VC.isJumpFromAuthVC = YES;
            [currentVc.navigationController pushViewController:VC animated:YES];
        }break;
        case RealNameProgressOperatorAuth:{
            //  跳转到运营商认证
            NSString * msgStr = @"运营商认证需获取通讯录权限，稍后请点击“允许”";
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:msgStr];
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_RED_STR] range:[msgStr rangeOfString:@"“允许”"]];
            ZTMXFAlertCustomView * alertCustomView = [[ZTMXFAlertCustomView alloc]initWithMessage:attStr btnTitle:@"我知道了"];
            alertCustomView.btnClick = ^{
                    LSPhoneOperationAuthViewController *VC = [[LSPhoneOperationAuthViewController alloc] init];
                    VC.isJumpFromAuthVC = YES;
                    [currentVc.navigationController pushViewController:VC animated:YES];
            };
            [alertCustomView showAlertView];
        }break;
        case RealNameProgressCompanyAuth:{
            //  跳转到公司认证
            LSCompanyAuthViewController *companyAuthVC = [[LSCompanyAuthViewController alloc] init];
            companyAuthVC.companyAuthStatus = 0;
            [currentVc.navigationController pushViewController:companyAuthVC animated:YES];
        }break;
        case RealNameProgressSecurityAuth:{
            //  跳转到社保、公积金认证
            ZTMXFSecurityAuthViewController *securityAuthVC = [[ZTMXFSecurityAuthViewController alloc] init];
            [currentVc.navigationController pushViewController:securityAuthVC animated:YES];
        }break;
        case RealNameProgressSumitAuth:{
            //  跳转到认证表单页
            LSSubmitAuthViewController *sumitAuthVC = [[LSSubmitAuthViewController alloc] init];
            sumitAuthVC.authType = WhiteLoanType;
            [currentVc.navigationController pushViewController:sumitAuthVC animated:YES];
        }break;
        default:
            break;
    }
}



+(void)realNameBackSuperVc:(UIViewController*)superVc{
   UIViewController* currentVc = (UIViewController*)superVc;
    NSString * inVc =   [[NSUserDefaults standardUserDefaults]objectForKey:kRealNameInVcNameKey];
    NSArray * arrVc = currentVc.navigationController.viewControllers;
    UIViewController * vcEnd = nil;
    for (UIViewController * obj in arrVc) {
        if ([obj isKindOfClass:NSClassFromString(inVc)]) {
            vcEnd = obj;
            break;
        }
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kRealNameInVcNameKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (vcEnd) {
        [currentVc.navigationController popToViewController:vcEnd animated:YES];
    }else{
        [currentVc.navigationController popViewControllerAnimated:YES];
    }
}
+ (void)realNameWithCurrentVc:(UIViewController*)currentVc andRealNameProgress:(RealNameProgress)realProgress isSaveBackVcName:(BOOL)isSave loanType:(LoanType)loanType{
    
    if (isSave) {
        //        currentVc =  currentVc.navigationController.viewControllers.firstObject;
        
        [RealNameManager saveBackVcNameWithBackVc:currentVc];
    }
    switch (realProgress) {
        case RealNameProgressIdf:
        {
            //  实名认证
            JBScanIdentityCardViewController * idVc = [[JBScanIdentityCardViewController alloc]init];
            idVc.loanType = loanType;
            [currentVc.navigationController pushViewController:idVc animated:YES];
        }
            break;
        case RealNameProgressBindCardMian:
        case RealNameProgressBindCard:{
            
            //   绑定主卡
            LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
            bankVc.bindCardType = realProgress==RealNameProgressBindCardMian?BindBankCardTypeMain:BindBankCardTypeCommon;
            bankVc.loanType = loanType;
            [currentVc.navigationController pushViewController:bankVc animated:YES];
        }break;
        case RealNameProgressZhiMaAuth:{
            //  跳转到芝麻信用认证
            LSCreditAuthWebViewController *VC = [[LSCreditAuthWebViewController alloc] init];
            VC.loanType = loanType;
            VC.isJumpFromAuthVC = YES;
            [currentVc.navigationController pushViewController:VC animated:YES];
        }break;
        case RealNameProgressOperatorAuth:{
            //  跳转到运营商认证
            NSString * msgStr = @"运营商认证需获取通讯录权限，稍后请点击“允许”";
            NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:msgStr];
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_RED_STR] range:[msgStr rangeOfString:@"“允许”"]];
            ZTMXFAlertCustomView * alertCustomView = [[ZTMXFAlertCustomView alloc]initWithMessage:attStr btnTitle:@"我知道了"];
            alertCustomView.btnClick = ^{
                LSPhoneOperationAuthViewController *VC = [[LSPhoneOperationAuthViewController alloc] init];
                VC.loanType = loanType;
                VC.isJumpFromAuthVC = YES;
                [currentVc.navigationController pushViewController:VC animated:YES];
                
            };
            [alertCustomView showAlertView];
            
        }break;
        case RealNameProgressCompanyAuth:{
            //  跳转到公司认证
            LSCompanyAuthViewController *companyAuthVC = [[LSCompanyAuthViewController alloc] init];
            companyAuthVC.loanType = loanType;
            companyAuthVC.companyAuthStatus = 0;
            [currentVc.navigationController pushViewController:companyAuthVC animated:YES];
        }break;
        case RealNameProgressSecurityAuth:{
            //  跳转到社保、公积金认证
            ZTMXFSecurityAuthViewController *securityAuthVC = [[ZTMXFSecurityAuthViewController alloc] init];
            securityAuthVC.loanType = loanType;
            [currentVc.navigationController pushViewController:securityAuthVC animated:YES];
        }break;
        case RealNameProgressCreditReplenishment:
        case RealNameProgressCreditPromote:{
            //            提升信用
            LSCreditAuthenViewController * creditPromoteVc = [[LSCreditAuthenViewController alloc]init];
            creditPromoteVc.authenType = realProgress == RealNameProgressCreditPromote ? WhiteCreditAuthen : ConsumeCreditAuthen;
            [currentVc.navigationController pushViewController:creditPromoteVc animated:YES];
        }break;
        case RealNameProgressSetPayPawBackRoot:
        case RealNameProgressSetPayPaw:{
            //            设置支付密码
            LSPayPwdSecurityCodeViewController *codeVC = [[LSPayPwdSecurityCodeViewController alloc] init];
            [currentVc.navigationController pushViewController:codeVC animated:YES];
        }break;
        case RealNameProgressConsumeLoan:
        case RealNameProgressWhiteLoan:
        case RealNameProgressMallLoan:
        case RealNameProgressSumitAuth:
        {
            //  跳转到认证表单页
            LSSubmitAuthViewController *sumitAuthVC = [[LSSubmitAuthViewController alloc] init];
            sumitAuthVC.authType = loanType;
            [currentVc.navigationController pushViewController:sumitAuthVC animated:YES];
        }break;
        default:
            break;
    }
}
+(BOOL)saveBackVcNameWithBackVc:(UIViewController*)backVc{
    [[NSUserDefaults standardUserDefaults]setValue:NSStringFromClass([backVc class]) forKey:kRealNameInVcNameKey];
   return  [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
