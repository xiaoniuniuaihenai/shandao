//
//  ZTMXFUPSErrorHelper.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/21.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFUPSErrorHelper.h"
#import "LSWebViewController.h"
#import "UIViewController+Visible.h"
#import "LSIdfBindCardViewController.h"
@implementation ZTMXFUPSErrorHelper


+ (void)showAlterWithUPSErrorHelperType:(ZTMXFUPSErrorHelperType)UPSErrorHelperType
                               ErrorDic:(NSDictionary *)UPSErrorDic
                                infoDic:(NSDictionary *)infoDic
{
    [ZTMXFUPSErrorHelper showWithErrorDic:UPSErrorDic UPSErrorHelperType:ZTMXFUPSErrorHelperBankCardBinding];

}


+ (void)showWithErrorDic:(NSDictionary *)UPSErrorDic UPSErrorHelperType:(ZTMXFUPSErrorHelperType)UPSErrorHelperType
{
    NSInteger code = [UPSErrorDic[@"code"] integerValue];
    NSString * msg = [UPSErrorDic[@"msg"] description];
    NSString * rBtnStr = @"";
    NSString * lBtnStr = @"";
    if (UPSErrorHelperType == ZTMXFUPSErrorHelperPay) {
        if (code == 3103 || code == 3342 || code == 3705 || code == 3104 || code == 3127 || code == 3001 || code == 3234 || code == 3342 || code == 3103) {
            rBtnStr = @"支付宝还款";
        }
        if (code == 3103 || code == 3342 || code == 3705 || code == 3104 || code == 3123 || code == 3108 || code == 3127 || code == 3233 || code == 3234 || code == 3002 || code == 3234) {
            lBtnStr = @"添加新卡";
        }
        if (code == 3232) {
            rBtnStr = @"拨打电话";
        }
        if (code == 3232 || code == 3001) {
            lBtnStr = @"我知道了";
        }
        if (code == 3123 || code == 3108 || code == 3233 || code == 3234 ) {
            rBtnStr = @"联系客服";
        }
    }else if (UPSErrorHelperType == ZTMXFUPSErrorHelperBankCardBinding) {
        
        if (code == 3123) {
            lBtnStr = @"添加新卡";
        }
        if (code == 3108 || code == 3127) {
            lBtnStr = @"联系客服";
        }
        if (code == 3123) {
            rBtnStr = @"联系客服";
        }
        if (code == 3108 || code == 3127) {
            lBtnStr = @"换一张卡";
        }
       
    }else if (UPSErrorHelperType == ZTMXFUPSErrorHelperDelayPay) {
        
        if (code == 3232 || code == 3342 || code == 3705 || code == 3104 || code == 3127 || code == 3234 || code == 3351 || code == 3001 || code == 3002 || code == 3103) {
            lBtnStr = @"我知道了";
        }
        if (code == 3123 || code == 3108 || code == 3233) {
            lBtnStr = @"添加新卡";
        }
        /**
         再次尝试 没有添加事件 😆
         */
        if (code == 3103) {
            rBtnStr = @"再次尝试";
        }
        
        
        if (code == 3103 || code == 3342 || code == 3705 || code == 3104 || code == 3127 || code == 3234 || code == 3351 || code == 3001 || code == 3002) {
            rBtnStr = @"添加新卡";
        }
        if (code == 3232) {
            rBtnStr = @"拨打电话";
        }
        if (code == 3123 || code == 3108 || code == 3233) {
            rBtnStr = @"联系客服";
        }
        
    }

    if (rBtnStr.length == 0) {
        [kKeyWindow makeCenterToast:msg];
        return;
    }
   
   
}



+(void)goMakePhoneCall
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",K_BankCustomerServiceNum];
    dispatch_after(0.3, dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];//隐私设置
    });
}


/**
 去绑卡页面
 */
+ (void)goBindingBankCard
{

    LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
    bankVc.bindCardType = BindBankCardTypeCommon;
    bankVc.loanType = ConsumeLoanType;
    [[UIViewController currentViewController].navigationController pushViewController:bankVc animated:YES];

}

/**
 去服务中心页面
 */
+ (void)goServiceCenter
{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(serviceCenter_que_first);
    [[UIViewController currentViewController].navigationController pushViewController:webVC animated:YES];

}
+ (void)showWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"联系客服"]) {
        [ZTMXFUPSErrorHelper goServiceCenter];
    }else if ([title isEqualToString:@"添加新卡"]) {
        [ZTMXFUPSErrorHelper goBindingBankCard];
    }else if ([title isEqualToString:@"换一张卡"]) {
        //        [ZTMXFUPSErrorHelper goServiceCenter];
    }else if ([title isEqualToString:@"支付宝还款"]) {
        [ZTMXFUPSErrorHelper goAlipay];
    } else if ([title isEqualToString:@"拨打电话"]) {
        [ZTMXFUPSErrorHelper goMakePhoneCall];
    }
}
/**
 去支付宝还款页面
 */
+ (void)goAlipay
{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
//    webVC.webUrlStr = DefineUrlString(alipayPayment);
    [[UIViewController currentViewController].navigationController pushViewController:webVC animated:YES];
}


@end
