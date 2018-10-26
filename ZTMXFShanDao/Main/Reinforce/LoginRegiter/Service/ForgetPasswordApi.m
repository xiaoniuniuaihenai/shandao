//
//  ForgetPasswordApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ForgetPasswordApi.h"

@interface ForgetPasswordApi ()

/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 验证码 */
@property (nonatomic, copy) NSString *securityCode;
@property (nonatomic, copy) NSString *deviceInfo;

@end

@implementation ForgetPasswordApi

- (instancetype)initWithPassword:(NSString *)password securityCode:(NSString *)code{
    self = [super init];
    if (self) {
        _password = password;
        _securityCode = code;
        _deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();

    }
    return self;
}


- (NSString *)requestUrl{
    return @"/user/resetPwd";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_password forKey:@"password"];
    [paramDict setValue:_securityCode forKey:@"verifyCode"];
    [paramDict setValue:_deviceInfo forKey:@"blackBox"];
    return paramDict;
}

@end
