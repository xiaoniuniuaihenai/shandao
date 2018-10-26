//
//  LaunchImageApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFLSShareViewLaunchImageApi.h"
@interface ZTMXFLSShareViewLaunchImageApi ()
@property (nonatomic,copy) NSString * blackBox;
@end
@implementation ZTMXFLSShareViewLaunchImageApi
-(instancetype)init{
    if (self = [super init]) {
//        NSString *deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();
//        _blackBox = deviceInfo;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:kChannelId forKey:@"channelName"];
    return paramDict;
}
- (NSString *)requestUrl{
    return @"/system/appLaunchImage";
}


@end
