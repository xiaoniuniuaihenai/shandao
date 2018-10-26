//
//  CheckVerifyCodeApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "CheckVerifyCodeApi.h"

@interface CheckVerifyCodeApi ()

@property (nonatomic, copy) NSString *verifyCode;
@property (nonatomic, copy) NSString *type;

@end

@implementation CheckVerifyCodeApi

- (instancetype)initWithCode:(NSString *)code type:(NSString *)type{
    self = [super init];
    if (self) {
        _verifyCode = code;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/checkVerifyCode";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_verifyCode forKey:@"verifyCode"];
    [paramDict setValue:_type forKey:@"type"];
    return paramDict;
}


@end
