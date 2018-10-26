//
//  LSMessageManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSMessageManager.h"
#import "UIViewController+Visible.h"
#import "ZTMXFMessageInfoViewController.h"
#import "ZTMXFLSOrderDetailInfoViewController.h"
#import "YWLTLogisticsInfoViewController.h"
@implementation LSMessageManager
+(void)messagePushViewControllerWithMsgModel:(LSNotificationModel *)notModel{
    NSDictionary * dicData = [notModel.data mj_JSONObject];
    NSString * urlStr = [dicData[@"url"] description];
    UIViewController * superVc = [UIViewController currentViewController];
    if ([urlStr length]>0) {
        LSWebViewController * webVc = [[LSWebViewController alloc]init];
        webVc.webUrlStr = urlStr;
        [superVc.navigationController pushViewController:webVc animated:YES];
        return;
    }
    NSString * prefixStr = [notModel.pushJumpType substringToIndex:1];
    if (prefixStr.length>0) {
        NSInteger prefix = [prefixStr integerValue];
        switch (prefix) {
            case 2:
            case 3:
            case 4:{
                //            系统消息
                if (notModel.message.length>60) {
                    ZTMXFMessageInfoViewController * msgInfoVc = [[ZTMXFMessageInfoViewController alloc]init];
                    msgInfoVc.navTitle = notModel.title;
                    msgInfoVc.messageStr = notModel.message;
                    [superVc.navigationController pushViewController:msgInfoVc animated:YES];
                }
                
            }
                break;
            case 5:
            case 6:{
                //  物流
                NSString * orderId = [dicData[@"orderId"] description];
                NSInteger orderType = [dicData[@"type"] integerValue];
                //  1表示消费贷，2表示积分商城订单（V2.0）
                if (orderId.length>0&&!kStringIsEmpty(orderId)) {
                    NSString *type = @"1";
                    if (orderType==1){
                        //  消费贷
                        type = @"1";
                    }else if (orderType ==2) {
                        // 商城
                    }
                    YWLTLogisticsInfoViewController *logisticsVC = [[YWLTLogisticsInfoViewController alloc] init];
                    logisticsVC.orderId = orderId;
                    logisticsVC.type = type;
                    [superVc.navigationController pushViewController:logisticsVC animated:YES];
                }
            }break;
            case 7:{
                //                活动
            }break;
                
            default:
                break;
        }
    }
}
@end
