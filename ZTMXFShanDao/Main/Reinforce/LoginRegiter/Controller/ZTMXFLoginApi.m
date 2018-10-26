//
//  ZTMXFLoginApi.h.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/7.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoginApi.h"
#import "UIDevice+FCUUID.h"
#import "NSString+Trims.h"


@interface ZTMXFLoginApi()
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *verficationCode;
@property (nonatomic, copy) NSString *deviceInfo;

@end

@implementation ZTMXFLoginApi

- (instancetype)initWithLoginType:(NSString *)type VerficationCode:(NSString *)verficationCode Password:(NSString *)password{
    if (self = [super init]) {
        _type = type;
        _verficationCode = verficationCode;
        _password = password;
        _deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();
    }
    return self;
}

- (NSString *)requestUrl{
    return [_type isEqualToString:@"L"]?@"/user/login":@"/user/phone/login";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_type forKey:@"loginType"];
    [paramDict setValue:[_password MD5] forKey:@"password"];
    NSString * osStr = [[UIDevice currentDevice] systemName];
    osStr = [osStr trimmingWhitespace];
    [paramDict setValue:osStr forKey:@"osType"];
    [paramDict setValue:kChannelId forKey:@"channel"];
    [paramDict setValue:[[NSString platformName]trimmingWhitespace] forKey:@"phoneType"];
    
    [paramDict setValue:_deviceInfo forKey:@"blackBox"];
    [paramDict setValue:kChannelId forKey:@"channel"];
    [paramDict setValue:[[UIDevice currentDevice].uuid trimmingWhitespace] forKey:@"uuid"];
    if (_verficationCode.length > 0) {
        [paramDict setValue:_verficationCode forKey:@"verifyCode"];
    }
//    NSLog(@"登录的请求参数%@",paramDict);
    return paramDict;
}


@end
