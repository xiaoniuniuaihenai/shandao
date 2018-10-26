//
//  GetVerifyCodeApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "GetVerifyCodeApi.h"

@interface GetVerifyCodeApi ()

@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *codeType;
@property (nonatomic, copy) NSString *deviceInfo;
@property (nonatomic, copy) NSString *imgCode;


@end

@implementation GetVerifyCodeApi

- (instancetype)initWithUserPhone:(NSString *)userPhone codeType:(NSString *)type imgCode:(NSString*)imgCode{
    self = [super init];
    if (self) {
        _userPhone = userPhone;
        _codeType = type;
        _imgCode = imgCode;
        _deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();

    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/getVerifyCode";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_userPhone forKey:@"mobile"];
    [paramDict setValue:_codeType forKey:@"type"];
    [paramDict setValue:_deviceInfo forKey:@"blackBox"];
    [paramDict setValue:_imgCode forKey:@"imageCode"];
    [paramDict setValue:kChannelId forKey:@"channel"];
    return paramDict;
}

@end
