//
//  SetupPayPwdIdVerifyApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "SetupPayPwdIdVerifyApi.h"
#import "NSString+Base64.h"

@interface SetupPayPwdIdVerifyApi ()

/** 身份证号 */
@property (nonatomic, copy) NSString *idNumber;

@end

@implementation SetupPayPwdIdVerifyApi

- (instancetype)initWithIdNumber:(NSString *)idNumber{
    self = [super init];
    if (self) {
        _idNumber = idNumber;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/checkIdNumber";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:[_idNumber base64EncodedString] forKey:@"idNumber"];
    return paramDict;
}
@end
