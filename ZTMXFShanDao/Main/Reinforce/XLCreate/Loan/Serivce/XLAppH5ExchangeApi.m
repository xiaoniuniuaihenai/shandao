//
//  XLAppH5ExchangeApi.m
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/7/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLAppH5ExchangeApi.h"
#import "UIDevice+FCUUID.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CommonCrypto/CommonDigest.h>
@implementation XLAppH5ExchangeApi
//哈希256
+ (NSString*)signSha256:(NSString *)string
{
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    int lengthData = (int)data.length ;
    CC_SHA256(data.bytes, lengthData, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (NSDictionary *)baseDictionary
{
    NSString *idfv = [UIDevice currentDevice].uuid;
    UInt64 time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appVersion =[version stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *userPhone =[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber];
    
    //用来区分渠道
    NSString * bundleName =  [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    bundleName = [bundleName componentsSeparatedByString:@"."].lastObject;
    
    NSString *userName =[userPhone length] > 0 ? userPhone : idfv;
    NSString *timeString =[NSString stringWithFormat:@"%llu",time] ;
    NSString *onlyId = [NSString stringWithFormat:@"i_%@_%llu_%@",idfv,time,bundleName];
    NSString *netType =[NSString getNetWorkType];
    NSString * app = @"1";
    NSString * sysApp = @"ios";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];

    
    NSString * tokenUser = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAccessToken];
    BOOL isLogin = [tokenUser length] ? YES:NO;
    
    NSMutableString *sign = [[NSMutableString alloc] initWithFormat:@"netType=%@&userName=%@&time=%@&appVersion=%@&app=%@&appName=%@&sysApp=%@",netType,userName,timeString,appVersion,app,appName,sysApp];
//    netType=WIFI&userName=18857099128&time=1524663902853&appVersion=150&app=1&appName=mqfq&sysApp=ios

    if (isLogin) {
        [sign appendString:tokenUser];
    }
    
    NSString * sha256 = [self signSha256:sign];
    
    NSMutableDictionary *headDict =[[NSMutableDictionary alloc] initWithObjectsAndKeys:appVersion,@"appVersion",userName,@"userName",timeString,@"time",  onlyId,@"id",netType,@"netType",sha256, @"sign",kChannelId,@"channel",app,@"app",appName,@"appName",sysApp,@"sysApp", nil];
    
    return headDict;
}



- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

/**
 客户端借还款流程页面H5-原生切换开关
 */
- (NSString *)requestUrl{
    return @"/system/getAppH5ExchangeSwitch";
}
-(NSString *)baseUrl
{
    return BaseUrl;
}


- (id)requestArgument{
    return @{};
}


@end
