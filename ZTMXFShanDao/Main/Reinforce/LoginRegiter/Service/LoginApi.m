//
//  LoginApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LoginApi.h"
#import "UIDevice+FCUUID.h"
#import "NSString+Trims.h"
@interface LoginApi ()

@property (nonatomic, copy) NSString *loginType;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *securityCode;
@property (nonatomic, copy) NSString *deviceInfo;

@end

@implementation LoginApi

- (instancetype)initWithLoginType:(NSString *)type password:(NSString *)password securityCode:(NSString *)code{
    self = [super init];
    if (self) {
        _loginType = type;
        _password = password;
        _securityCode = code;
        _deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();

    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/login";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_loginType forKey:@"loginType"];
    [paramDict setValue:_password forKey:@"password"];
    NSString * osStr = [[UIDevice currentDevice] systemName];
    osStr = [osStr trimmingWhitespace];
    [paramDict setValue:osStr forKey:@"osType"];
    [paramDict setValue:[[NSString platformName]trimmingWhitespace] forKey:@"phoneType"];
    
    [paramDict setValue:_deviceInfo forKey:@"blackBox"];
    [paramDict setValue:[[UIDevice currentDevice].uuid trimmingWhitespace] forKey:@"uuid"];
    if (_securityCode.length > 0) {
        [paramDict setValue:_securityCode forKey:@"verifyCode"];
    }
    return paramDict;
}

@end
