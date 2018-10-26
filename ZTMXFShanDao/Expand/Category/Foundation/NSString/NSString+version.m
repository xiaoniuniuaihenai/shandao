//
//  NSString+version.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "NSString+version.h"

@implementation NSString (version)

//  获取app 版本
+ (long)appVersionLongValue{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appCurrentVersion =[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    long appVersion = [appCurrentVersion longLongValue];
    return appVersion;
}

@end
