//
//  ModifyLoginPwdApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  修改登录密码

#import "BaseRequestSerivce.h"

@interface ModifyLoginPwdApi : BaseRequestSerivce

- (instancetype)initWithOriginalPassword:(NSString *)original newPassword:(NSString *)newPwd;

@end
