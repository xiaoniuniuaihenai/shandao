//
//  XLServerStatisticalApi.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/7/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#define lastPageType @"lastPageType"

#import "ZTMXFServerStatisticalApi.h"
#import "UIDevice+FCUUID.h"
#import "NSString+UrlEncode.h"
#import "NSDictionary+JSONString.h"
#import "ZTMXFServerStatisticalHelper.h"

@interface ZTMXFServerStatisticalApi ()

@property (nonatomic, strong) NSString *currentClassName;
@property (nonatomic, strong) NSString *pointSubCode;
@property (nonatomic, strong) NSDate   *date;
@property (nonatomic, strong) NSString *lastPageCode;
@property (nonatomic, assign) BOOL      type;//页面显示/页面消失

@end

@implementation ZTMXFServerStatisticalApi

- (instancetype)initWithClassName:(NSString *)className PointSubCode:(NSString *)pointSubCode Time:(NSDate *)date lastPageCode:(NSString *)lastPageCode type:(BOOL)type{
    if (self = [super init]) {
        self.currentClassName = className;
        self.pointSubCode = pointSubCode;
        self.type = type;
        self.lastPageCode = lastPageCode;
        self.date = date;
    }
    return self;
}

- (NSString *)baseUrl {
    return k_statisticalURL;
}

-(NSString * )requestUrl{
    return @"/pagePoint/add";
}

- (id)requestArgument{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (_type == YES) {
        [params setObject:@([self currentTimeStr:_date]) forKey:@"intoTime"];
    }else{
        [params setObject:@([self currentTimeStr:_date]) forKey:@"outTime"];
    }
    [params setObject:@"" forKey:@"fromPointCode"];
    [params setObject:_pointSubCode forKey:@"pointCode"];
    [params setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber]length] > 0 ?[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber]:[[UIDevice currentDevice] uuid] forKey:@"mobile"];
    [params setObject:@(1001) forKey:@"accessCode"];
    [params setObject:[[[ZTMXFServerStatisticalHelper baseDictionary] mj_JSONString] urlEncode] forKey:@"appInfo"];
//    NSLog(@"\n-----------------\n\n%@\n\n\n-----------------",params);
    return params;
}


//获取当前时间戳
- (NSInteger )currentTimeStr:(NSDate *)date{
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return [timeString integerValue];
}


@end
