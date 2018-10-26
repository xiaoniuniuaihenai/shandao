//
//  ZTMXFPushHelper.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/19.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPushHelper.h"
#import "NSString+DictionaryValue.h"
#import "UIViewController+Visible.h"
#import "LSCreditCheckViewController.h"
#import "LSMessageManager.h"
#import "ZTMXFAuthSuccessViewController.h"
#import "ZTMXFCertificationResultViewController.h"
#import "ZTMXFCertificationListViewController.h"
#import "ZTMXFLSOrderDetailInfoViewController.h"
#import "ZTMXFMessageInfoViewController.h"
#import "AppDelegate.h"
#import "CYLTabBarController.h"
#import "ZTMXFCertificationHelper.h"
#import "ZTMXFCertificationCenterViewController.h"
@implementation ZTMXFPushHelper

+ (void)networkDidReceiveMessage:(NSNotification *)notification
{

}


//  根据收到的推送做相应的处理
+ (void)handlePushMessage:(NSDictionary *)userInfo click:(BOOL)isClick
{
    if (![[userInfo allKeys] containsObject:@"pushJumpType"]) {
        return;
    }
    LSNotificationModel * notModel = [LSNotificationModel notifi_notifiInfoWithPushDictionary:userInfo];
    [ZTMXFPushHelper newsUpadateNotificationModel:notModel];
    UIViewController * VC = [UIViewController currentViewController];
    NSString *pushJumpType = notModel.pushJumpType;
    if([pushJumpType isEqualToString:@"206"]||[pushJumpType isEqualToString:@"207"]||[pushJumpType isEqualToString:@"208"] || [pushJumpType isEqualToString:@"298"] || [pushJumpType isEqualToString:@"299"] || [pushJumpType isEqualToString:@"401"] || [pushJumpType isEqualToString:@"402"]|| [pushJumpType isEqualToString:@"204"]|| [pushJumpType isEqualToString:@"205"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotRefreshBorrowMoneyPage object:nil];
        //        206:还款状态变更        //        298:续借申请成功
        //        207:打款状态变更        //        299:银行放款状态
        //        208:续期状态变更
        if([pushJumpType isEqualToString:@"299"]){
            [ZTMXFUMengHelper mqEvent:k_lend_succ_xf];
        }
        
    }
    else if ([pushJumpType isEqualToString:@"211"]){
        // 运营商认证成功
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthChangePushNotification object:nil];
        [ZTMXFUMengHelper mqEvent:k_operator_succ_xf];
    }
    else if ([pushJumpType isEqualToString:@"212"]){
        [ZTMXFUMengHelper mqEvent:k_operator_fail_xf];
        // 运营商认证失败
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthChangePushNotification object:nil];
    }
    else if ([pushJumpType isEqualToString:@"313"]){
        // 消费分期提交审核
    }
    else if ([pushJumpType isEqualToString:@"314"]){
        // 消费分期审核通过
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthStatusPushNotification object:nil];
    }
    else if ([pushJumpType isEqualToString:@"315"]){
        // 消费分期审核不通过
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthStatusPushNotification object:nil];
    }
    else if ([pushJumpType isEqualToString:@"316"]){
        // 消费贷提交审核
    }
    else if ([pushJumpType isEqualToString:@"319"]){
        // 淘宝认证成功
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthChangePushNotification object:nil];
    }
    else if ([pushJumpType isEqualToString:@"320"]){
        // 淘宝认证失败
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthChangePushNotification object:nil];
    }
    else if ([pushJumpType isEqualToString:@"321"]){
        // 京东认证成功
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthChangePushNotification object:nil];
    }
    else if ([pushJumpType isEqualToString:@"322"]){
        // 京东认证失败
        [[NSNotificationCenter defaultCenter] postNotificationName:kCreditAuthChangePushNotification object:nil];
    }else if ([pushJumpType isEqualToString:@"301"]){
        // 消费贷审核通过
        [ZTMXFUMengHelper mqEvent:k_risk_succ_xf];

        if ([VC isKindOfClass:[LSCreditCheckViewController class]]) {
            ZTMXFCertificationResultViewController * authSuccessVC = [[ZTMXFCertificationResultViewController alloc] init];
            authSuccessVC.isSuccessful = YES;

            NSDictionary * dic = [ZTMXFPushHelper dictionaryWithJsonString:userInfo[@"data"]];
            if ([[dic allKeys] containsObject:@"title"]) {
                authSuccessVC.authDescribe = [dic[@"title"] description];
                authSuccessVC.creditAmount = [dic[@"content"] description];
            }
            [VC.navigationController pushViewController:authSuccessVC animated:YES];
        }
    }else if ([pushJumpType isEqualToString:@"302"]){
        // 消费贷审核不通过
        [ZTMXFUMengHelper mqEvent:k_risk_fail_xf];
        if ([VC isKindOfClass:[LSCreditCheckViewController class]]) {
//            ZTMXFCertificationResultViewController * authSuccessVC = [[ZTMXFCertificationResultViewController alloc] init];
//            NSDictionary * dic = [ZTMXFPushHelper dictionaryWithJsonString:userInfo[@"data"]];
//            authSuccessVC.isSuccessful = NO;
//            authSuccessVC.authDescribe = [dic[@"content"] description];
//
//            [VC.navigationController pushViewController:authSuccessVC animated:YES];
            {
            [ZTMXFUMengHelper mqEvent:k_reject_superMarket_pv];
            LSWebViewController *webVC = [[LSWebViewController alloc] init];
            webVC.isUpRiskWait = YES;
            webVC.webUrlStr = DefineUrlString(strongRiskFail);
            [VC.navigationController pushViewController:webVC animated:YES];
            }
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NotNewNotificationMsg object:nil];
}




/**
 
 根据推送跳转到详情页
 
 */
+(void)pushDetailsPageWithNotificationModel:(LSNotificationModel *)notificationModel controller:(UIViewController *)viewController
{
    NSDictionary * dicData = [notificationModel.data mj_JSONObject];
    NSString * urlStr = [dicData[@"url"] description];
    if ([urlStr length]>0) {
        LSWebViewController * webVc = [[LSWebViewController alloc]init];
        webVc.webUrlStr = urlStr;
        [viewController.navigationController pushViewController:webVc animated:YES];
        return;
    }
    NSString * prefixStr = [notificationModel.pushJumpType substringToIndex:1];
    if (prefixStr.length>0) {
        NSInteger prefix = [prefixStr integerValue];
        if (prefix == 4) {
            if (notificationModel.message.length > 60) {
                ZTMXFMessageInfoViewController * msgInfoVc = [[ZTMXFMessageInfoViewController alloc]init];
                msgInfoVc.navTitle = notificationModel.title;
                msgInfoVc.messageStr = notificationModel.message;
                [viewController.navigationController pushViewController:msgInfoVc animated:YES];
                return;
            }
        }
    }
    
    NSString * pushLandingPage = notificationModel.pushLandingPage;
    NSString * pushJumpType = notificationModel.pushJumpType;
    if ([pushLandingPage isEqualToString:@"1001"]) {
        
        ZTMXFCertificationCenterViewController * certificationCenterVC = [[ZTMXFCertificationCenterViewController alloc] init];
        [viewController.navigationController pushViewController:certificationCenterVC animated:YES];
        
    }else if ([pushLandingPage isEqualToString:@"1002"]) {
        [viewController.navigationController popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [viewController cyl_tabBarController].selectedIndex = 1;
        });
    }else if ([pushLandingPage isEqualToString:@"1003"]) {
        NSString * orderId = [dicData[@"orderId"] description];
        NSInteger orderType = [dicData[@"orderType"] integerValue];
        ZTMXFLSOrderDetailInfoViewController * orderDetailsVC = [[ZTMXFLSOrderDetailInfoViewController alloc] init];
        orderDetailsVC.orderId = orderId;
        orderDetailsVC.orderDetailType = orderType;
        [viewController.navigationController pushViewController:orderDetailsVC animated:YES];
    }else if ([pushLandingPage isEqualToString:@"1004"]) {//版本管理
        
    }else if ([pushLandingPage isEqualToString:@"1005"]) {//消费贷认证列表
        if ([pushJumpType isEqualToString:@"315"] || [pushJumpType isEqualToString:@"314"]|| [pushJumpType isEqualToString:@"319"]|| [pushJumpType isEqualToString:@"320"]|| [pushJumpType isEqualToString:@"321"]|| [pushJumpType isEqualToString:@"322"]) {
            [ZTMXFCertificationHelper certificationPageJumpWithVC:viewController periodAuthType:MallLoanType];
        }else{
            [ZTMXFCertificationHelper certificationPageJumpWithVC:viewController periodAuthType:ConsumeLoanType];
        }
    }
}
/**
 
 点击推送栏 跳转到详情页
 
 */
+(void)pushDetailsPageWithUserInfo:(NSDictionary *)userInfo
{
    if (![[userInfo allKeys] containsObject:@"pushJumpType"]) {
        return;
    }
    LSNotificationModel * notModel = [LSNotificationModel notifi_notifiInfoWithPushDictionary:userInfo];
    [ZTMXFPushHelper newsUpadateNotificationModel:notModel];
    [ZTMXFPushHelper pushDetailsPageWithNotificationModel:notModel controller:[UIViewController currentViewController]];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotNewNotificationMsg object:nil];
    
}
/**
 *  推送处理本地数据以及通知页面刷新页面
 *
 */
+(void)newsUpadateNotificationModel:(LSNotificationModel *)model{
    
    [LSNotificationModel notification_insertArray:@[model]];
    //    消息中心刷新页面
    [[NSNotificationCenter defaultCenter] postNotificationName:newsUpadateNotificationResult object:nil];
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
