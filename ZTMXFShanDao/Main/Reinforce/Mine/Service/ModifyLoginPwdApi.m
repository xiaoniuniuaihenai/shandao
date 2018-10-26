//
//  ModifyLoginPwdApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ModifyLoginPwdApi.h"

@interface ModifyLoginPwdApi ()

@property (nonatomic, copy) NSString *originalPwd;
@property (nonatomic, copy) NSString *newpwd;

@end

@implementation ModifyLoginPwdApi

- (instancetype)initWithOriginalPassword:(NSString *)original newPassword:(NSString *)newPwd{
    self = [super init];
    if (self) {
        _originalPwd = original;
        _newpwd = newPwd;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/changeLoginPwd";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_originalPwd forKey:@"oldPwd"];
    [paramDict setValue:_newpwd forKey:@"newPwd"];
    return paramDict;
}


@end
