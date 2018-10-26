//
//  NSString+verify.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  字符串验证

#import <Foundation/Foundation.h>

@interface NSString (verify)

#pragma mark - 检验密码格式是否符合要求
/** 判断是否只包含 数字*/
+(BOOL)checkNumber:(NSString*)str;
/** 字母 数字  符号组合 */
+(BOOL)checkLoginPwdRule:(NSString*)pwdStr;

/** 检验密码格式是否符合要求 */
+ (BOOL)checkPwRule:(NSString *)string;
+ (BOOL)checkTPwRule:(NSString *)string;

#pragma mark - 当前手机连接网络类型
+ (NSString *)getNetWorkType;
// 返回平台类型名字
+ (NSString*)platformName;

#pragma mark - 手机中间四位用****代替
+ (NSString *)phoneNumberTransform:(NSString *)phoneNumber;
// 用户名  (杨样->*样)
+ (NSString *)userNameTransform:(NSString *)userName;

#pragma mark - 获取银行卡手机后四位
+ (NSString *)bankCardLastFourNumber:(NSString *)bankCard;


@end
