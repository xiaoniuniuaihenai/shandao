//
//  SetupPayPwdApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "SetupPayPwdApi.h"
#import "NSString+Base64.h"


@interface SetupPayPwdApi ()

/** 原先的密码 */
@property (nonatomic, copy) NSString *oldpwd;
/** 新的密码 */
@property (nonatomic, copy) NSString *newpwd;
/** 身份证号 */
@property (nonatomic, copy) NSString *idnumber;
/** 验证码 */
@property (nonatomic, copy) NSString *verifyCode;
/** 类型 */
@property (nonatomic, copy) NSString *type;
@end

@implementation SetupPayPwdApi

- (instancetype)initWithOriginalPassword:(NSString *)original newPassword:(NSString *)newPwd verifyCode:(NSString *)code idNumber:(NSString *)idNumber type:(NSString *)type{
    self = [super init];
    if (self) {
        _oldpwd = original;
        _newpwd = newPwd;
        _idnumber = idNumber;
        _verifyCode = code;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/setPayPwd";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_newpwd forKey:@"password"];
    if (_verifyCode.length > 0) {
        [paramDict setValue:_verifyCode forKey:@"verifyCode"];
    }
    if (_idnumber.length > 0) {
        [paramDict setValue:_idnumber forKey:@"idNumber"];
    }
    if (_oldpwd.length > 0) {
        [paramDict setValue:_oldpwd forKey:@"oldPwd"];
    }
    [paramDict setValue:_type forKey:@"type"];
    
    return paramDict;
}


@end
