//
//  LSBindBankCardApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  绑定银行卡

#import "BaseRequestSerivce.h"

@interface LSBindBankCardApi : BaseRequestSerivce

/**
 @param bankId 短信给的id
 @param verifyCode 短信验证码
 */
-(instancetype)initWithBankId:(NSString*)bankId andVerifyCode:(NSString*)verifyCode;
/**
 @param bankId 短信给的id
 @param verifyCode 短信验证码
 type 1延签，2绑卡
 */
-(instancetype)initWithBankId:(NSString*)bankId andVerifyCode:(NSString*)verifyCode type:(int)type;

@end
