//
//  LSUmengHelper.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/31.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "LSUmengHelper.h"
#import <UMAnalytics/MobClick.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/DplusMobClick.h>

@implementation LSUmengHelper



//登录是
+(void)UMSignInWithPUID{
    if ([LoginManager loginState]) {
        [MobClick profileSignInWithPUID:[LoginManager userPhone]];
    }}
// 账号退出
+(void)UMFileSignOff{
//    账号登出时需调用此接口，调用之后不再发送账号相关内容。
    [MobClick profileSignOff];
}
+ (void)UMAnalyticStart {
    
    [UMConfigure initWithAppkey:kUmengKey channel:@"App Store"];
    [MobClick setScenarioType:E_UM_NORMAL];
    //    [MobClick setLogEnabled:YES];
    //    登录统计  因为我们登录一次后 token 不失效 就不会调起登录页面
    [LSUmengHelper UMSignInWithPUID];
    //  启用DPlus功能
    [MobClick setScenarioType:E_UM_DPLUS];
    return;
}
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
    return;
}

+ (void)endLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick endLogPageView:NSStringFromClass(pageView)];
    return;
}



+(void)endLogPageViewName:(NSString *)pageViewName
{
    [MobClick endLogPageView:pageViewName];
    return;
}
+(void)beginLogPageViewName:(NSString *)pageViewName
{
    [MobClick beginLogPageView:pageViewName];
    return;
}
#pragma mark - 添加事件
+ (void)addEventWithId:(NSString *)eventId{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:[LoginManager userPhone] forKey:@"userPhone"];
    [MobClick event:eventId attributes:paramDict];
}

/**
 自定义事件

 @param eventId 监听事件
 @param params 参数
 */
+ (void)addEventWithId:(NSString *)eventId params:(NSDictionary *)params{
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if ([LoginManager loginState]) {
        [paramDict setValue:[LoginManager userPhone] forKey:@"userPhone"];
    }
    [paramDict addEntriesFromDictionary:paramDict];
    [MobClick event:eventId attributes:paramDict];
}
/** 自定义U-DPlus埋点(不带参数) */
+ (void)addUDplusEventWithId:(NSString *)eventId{
    [LSUmengHelper addUDplusEventWithId:eventId params:nil];
}

/** 自定义U-DPlus埋点(带参数的埋点) */
+ (void)addUDplusEventWithId:(NSString *)eventId params:(NSDictionary *)params{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if (![eventId isEqualToString:kBanner]) {
        //  除了点击banner 不需要登陆, 其他都需要登陆才能埋点
        if ([LoginManager loginState]) {
            [paramDict setValue:[LoginManager userPhone] forKey:@"userName"];
            if (!kDictIsEmpty(params)) {
                [paramDict addEntriesFromDictionary:params];
                [DplusMobClick track:@"login" property:paramDict];
            }
        }
    } else {
        if ([LoginManager loginState]) {
            [paramDict setValue:[LoginManager userPhone] forKey:@"userName"];
        } else {
            [paramDict setValue:@"" forKey:@"userName"];
        }
        if (!kDictIsEmpty(params)) {
            [paramDict addEntriesFromDictionary:params];
            [DplusMobClick track:@"login" property:paramDict];
        }
    }
}


@end
