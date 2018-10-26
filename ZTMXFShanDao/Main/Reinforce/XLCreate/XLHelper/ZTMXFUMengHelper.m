//
//  ZTMXFUMengHelper.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFUMengHelper.h"
#import <UMAnalytics/MobClick.h>
#import "ZTMXFPhoneModel.h"
@implementation ZTMXFUMengHelper
//+ (void)mqE
+ (void)mqEvent:(NSString *)eventId
{
    NSMutableDictionary * pDic = (NSMutableDictionary *)[[ZTMXFUMengHelper basicDataDic] mutableCopy];
    NSString * jsonStr = [pDic mj_JSONString];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:set];
    [pDic setValue:jsonStr forKey:@"desc"];
    [MobClick event:eventId attributes:pDic];
}




+ (NSDictionary *)basicDataDic
{
    NSString * time = @"";
    if ([ZTMXFUMengHelper getCurrentTimes]) {
        time = [ZTMXFUMengHelper getCurrentTimes];
    }
    NSString * Phone = @"";
    NSDictionary * dic;
    NSString *version = [UIDevice currentDevice].systemVersion;

    if ([LoginManager userPhone]) {
        Phone = [LoginManager userPhone];
        dic = @{@"appVersion":appMPVersion,@"Channel":kChannelId,@"date":time,@"userName":Phone,@"deviceType":[ZTMXFPhoneModel iphoneType],@"systemVersion":version};
    }else{
        dic = @{@"appVersion":appMPVersion,@"Channel":kChannelId,@"date":time, @"deviceType":[ZTMXFPhoneModel iphoneType],@"systemVersion":version};
    }
    
    return dic;
}
+ (void)mqEvent:(NSString *)eventId parameter:(NSDictionary *)parameter
{
    //    [parameter ]
    NSMutableDictionary * pDic = (NSMutableDictionary *)[parameter mutableCopy];
    [pDic addEntriesFromDictionary:[ZTMXFUMengHelper basicDataDic]];
    NSString * jsonStr = [pDic mj_JSONString];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:set];
    [pDic setValue:jsonStr forKey:@"desc"];
    [MobClick event:eventId attributes:pDic];
}
/** 账号退出
 */
+(void)UMFileSignOff
{
    //账号登出时需调用此接口，调用之后不再发送账号相关内容。
    [MobClick profileSignOff];
}

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
}

@end
