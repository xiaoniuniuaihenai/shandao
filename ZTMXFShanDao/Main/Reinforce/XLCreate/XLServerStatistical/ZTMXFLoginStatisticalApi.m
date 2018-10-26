//
//  ZTMXFLoginStatisticalApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoginStatisticalApi.h"
#import "NSDictionary+JSONString.h"
#import "ZTMXFServerStatisticalHelper.h"
#import "NSString+md5.h"

@interface ZTMXFLoginStatisticalApi ()

/**
 1、统计渠道注册主页面PV/UV
 2、统计图形验证码弹窗PV、UV
 3、统计老用户弹窗PV、UV
 4、记录注册成功页PV/UV
 */
@property (nonatomic, assign)int stepType;

@end
@implementation ZTMXFLoginStatisticalApi

- (instancetype)initWithStepType:(int)stepType
{
    self = [super init];
    if (self) {
        _stepType = stepType;
    }
    return self;
}


-(NSString * )requestUrl{
    return @"/accessRecords/register/addApp";
}

-(id)requestArgument
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@(_stepType) forKey:@"stepType"];
    NSString *userPhone =[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber];
    NSString *userName = [userPhone length] > 0 ? userPhone : @"";
    [dic setValue:userName forKey:@"mobile"];
    NSString * appInfo = [[ZTMXFServerStatisticalHelper baseDictionary] JSONString];
    [dic setObject:appInfo forKey:@"appInfo"];
    
    
    NSArray *keyTemArray = [dic allKeys];
    NSArray *keyArray = [keyTemArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
//    NSLog(@"dic=%@",dic);
    NSMutableArray * infos = [NSMutableArray array];
    for (int i=0;i<keyArray.count;i++ ) {
        NSString * str = [NSString stringWithFormat:@"%@=%@",keyArray[i], [dic[keyArray[i]] description]];
        [infos addObject:str];
    }

    NSString * sign = [infos componentsJoinedByString:@"&"];
    sign = [NSString stringWithFormat:@"%@%@", sign, k_MQsecretKey];
    sign = [sign MD5];
    [dic setObject:sign forKey:@"sign"];

    NSLog(@"注册页服务器埋点  %@", dic);
    return dic;
}

@end
