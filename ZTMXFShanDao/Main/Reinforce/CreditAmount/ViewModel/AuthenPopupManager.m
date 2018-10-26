//
//  AuthenPopupManager.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/23.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "AuthenPopupManager.h"
#import "LSIdCardView.h"
#import "UIViewController+Visible.h"
#import "NTalkerChatViewController.h"
#import "NTalker.h"
#import "WJYAlertView.h"

@implementation AuthenPopupManager


/** 显示身份证扫描次数超限制 */
+ (void)showScanIdentityOverTimes{
    [WJYAlertView showTwoButtonsWithTitle:@"" Message:@"身份证扫描次数超限，您可联系客服重置扫描次数！" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"下次再说" Click:^{
        NSLog(@"您点取消事件");
    } ButtonType:WJYAlertViewButtonTypeNone ButtonTitle:@"在线客服" Click:^{
        //跳转到人工客服页面
        if ([LoginManager loginState]) {
            UIViewController *currentController = [UIViewController currentViewController];
            NTalkerChatViewController *chat = [[NTalker standardIntegration] startChatWithSettingId:kXNSettingId];
            chat.pushOrPresent = YES;
            chat.isHaveVoice = NO;
            [currentController.navigationController pushViewController:chat animated:YES];
        }
    }];
}


@end
