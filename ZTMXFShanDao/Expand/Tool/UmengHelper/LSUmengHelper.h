//
//  LSUmengHelper.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/31.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUmengHelper : NSObject

/*!
 * 启动友盟统计功能
 */
+ (void)UMAnalyticStart;
/* 登录是开启针对*/
+(void)UMSignInWithPUID;
/* 账号退出*/
+(void)UMFileSignOff;

/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView;

/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)endLogPageView:(__unsafe_unretained Class)pageView;


/*!
 * 自定义名称
 */
/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+(void)beginLogPageViewName:(NSString *)pageViewName;

/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+(void)endLogPageViewName:(NSString *)pageViewName;

    

/** 自定义统计事件 */
+ (void)addEventWithId:(NSString *)eventId;
/**
 自定义事件  APP统计
 @param eventId 监听事件
 @param params 参数
 */
+ (void)addEventWithId:(NSString *)eventId params:(NSDictionary *)params;

/** 自定义U-DPlus埋点(不带参数) */
+ (void)addUDplusEventWithId:(NSString *)eventId;
/** 自定义U-DPlus埋点(带参数的埋点) */
+ (void)addUDplusEventWithId:(NSString *)eventId params:(NSDictionary *)params;

@end
