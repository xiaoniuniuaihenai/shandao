//
//  NotificationContants.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//  推送通知key

#ifndef NotificationContants_h
#define NotificationContants_h

//审核状态刷新
#define kCreditAuthStatusPushNotification @"kCreditAuthStatusPushNotification"
//认证状态刷新
#define kCreditAuthChangePushNotification @"kCreditAuthChangePushNotification"
//运营商认证成功通知
#define kPhoneOperationPushNotification @"kPhoneOperationSucceed"
//运营商认证失败
#define kPhoneOperationFailurePushNotification @"kPhoneOperationFailure"
//公积金认证成功
#define kFuldSuccessPushNotification @"kFuldSuccessPushNotification"
//公积金认证失败
#define kFuldFailurePushNotification @"kFuldFailurePushNotification"
//社保认证成功
#define kSecuritySuccessPushNotification @"kSecuritySuccessPushNotification"
//社保认证失败
#define kSecurityFailurePushNotification @"kSecurityFailurePushNotification"

/** app 从后台进入前台*/
#define NotAppBgTransitionDesk          @"NotAppBgTransitionDesk"
#define  newsUpadateNotificationResult  @"newsUpadateNotificationResult"

#define  NotNewNotificationMsg          @"newNotificationMsg"  //有新的的消息

#define NotTokenInvalidNotification     @"notTokenInvalidNotification"  //退出登录
#define NotTokenInvalidLoginPushNotification     @"NotTokenInvalidPushLoginNotification"  //token 失效直接弹出登录

/** app 审核状态 */
#define kAppReviewStateNotification     @"kAppReviewStateNotification"

/** 审核状态下显示的借钱记录 */
#define kBorrowMoneyRecord @"借钱记录"
/** 审核状态下显示的信用认证 */
#define kCreditAuthen      @"信用认证"

#endif /* NotificationContants_h */
