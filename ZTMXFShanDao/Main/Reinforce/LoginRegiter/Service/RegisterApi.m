//
//  RegisterApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RegisterApi.h"

@interface RegisterApi ()

/** 注册手机号 */
@property (nonatomic, copy) NSString *userPhone;
/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 验证码 */
@property (nonatomic, copy) NSString *securityCode;
/** 推荐人 */
@property (nonatomic, copy) NSString *recommender;
@property (nonatomic,copy ) NSString * deviceInfo;
@end

@implementation RegisterApi

- (instancetype)initWithUserPhone:(NSString *)userPhone password:(NSString *)password securityCode:(NSString *)code recommendPhone:(NSString *)recommender{
    self = [super init];
    if (self) {
        _userPhone = userPhone;
        _password = password;
        _securityCode = code;
        _recommender = recommender;
        _deviceInfo = [FMDeviceManager sharedManager]->getDeviceInfo();

    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/register";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_userPhone forKey:@"userName"];
    [paramDict setValue:_password forKey:@"password"];
    [paramDict setValue:_securityCode forKey:@"verifyCode"];
    [paramDict setValue:_recommender forKey:@"recommendUser"];
    [paramDict setValue:_deviceInfo forKey:@"blackBox"];
    [paramDict setValue:kChannelId forKey:@"channel"];
    return paramDict;
}

@end
