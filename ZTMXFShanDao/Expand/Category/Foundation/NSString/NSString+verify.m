//
//  NSString+verify.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "NSString+verify.h"
#import "Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <sys/sysctl.h>
@implementation NSString (verify)

/** 判断是否只包含 数字*/
+(BOOL)checkNumber:(NSString*)str{
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:str];
}

/** 字母 数字  符号组合 */
+(BOOL)checkLoginPwdRule:(NSString*)pwdStr{
    if (pwdStr) {
        //    ^(?![^a-zA-Z]+$)(?![^0-9]+$)(?!\\D+$).{6,18}$ 符号 数字 字母
        NSString * regex = @"^(?![^a-zA-Z]+$)(?!\\D+$).{6,18}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return [pred evaluateWithObject:pwdStr];
    } else {
        return NO;
    }
}

+ (BOOL)checkPwRule:(NSString *)string
{
    // 匹配由数字、26个英文字母或者下划线组成的字符串
    NSString *regex2 = @"[0-9A-Za-z]{6,16}";
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    
    return [pred2 evaluateWithObject:string];
}

//交易密码
+ (BOOL)checkTPwRule:(NSString *)string
{
    // 匹配由数字、26个英文字母或者下划线组成的字符串
    NSString *regex2 = @"[0-9A-Za-z]{6,12}";
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    
    return [pred2 evaluateWithObject:string];
}

#pragma mark - 当前手机连接网络类型
+ (NSString *)getNetWorkType
{
    NSString *netconnType = @"";
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {
            netconnType = @"unknown";
        }
            break;
            
        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"WIFI";
        }
            break;
            
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentStatus = info.currentRadioAccessTechnology;
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                netconnType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                netconnType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                netconnType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                netconnType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                netconnType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                netconnType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                netconnType = @"4G";
            }
        }
            break;
        default:
            break;
    }
    return netconnType;
}

// 返回平台类型名字
+ (NSString*)platformName{
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size * sizeof(char));
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);

    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"VerizoniPhone4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone5(GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone5(GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone5c(GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone5c(Global)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone5s(GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone5s(Global)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone7(CDMA)";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone7(GSM)";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus(CDMA)";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone7Plus(GSM)";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone8Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone8Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhoneX";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhoneX";
    // iPod
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPodTouch1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPodTouch5G";
    
    // iPad
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad2(WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad2(GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad2(CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad2(WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPadMini(WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPadMini(GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPadMini(GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad3(WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad3(GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad3(GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad4(WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad4(GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad4(GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPadAir(WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPadAir(Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPadMini2(WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPadMini2(Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPadMini2(Rev)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPadMini3(WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPadMini3(A1600)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPadMini3(A1601)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPadAir2(WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPadAir2(Cellular)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
    
}

#pragma mark - 手机中间四位用****代替
+ (NSString *)phoneNumberTransform:(NSString *)phoneNumber{
    //首先验证是不是手机号码
    NSRange rangeMobile = NSMakeRange(3, 4);
    if (phoneNumber.length >= 7) {
        NSString *replaceStr = [phoneNumber substringWithRange:rangeMobile];
        if (replaceStr.length > 0) {
            NSString *resultNumber = [phoneNumber stringByReplacingOccurrencesOfString:replaceStr withString:@"****"];
            return resultNumber;
        }
    }
    return phoneNumber;
}

+ (NSString *)userNameTransform:(NSString *)userName{
    //首先验证是不是手机号码
    if (userName.length > 1) {
        NSRange rangeMobile = NSMakeRange(0, (userName.length - 1));
        NSString *replaceStr = [userName substringWithRange:rangeMobile];
        if (replaceStr.length > 0) {
            NSString *changeReplaceStr = [NSString string];
            for (int i = 0; i < replaceStr.length ; i ++) {
                changeReplaceStr = [changeReplaceStr stringByAppendingString:@"*"];
            }
            NSString *resultUserName = [userName stringByReplacingOccurrencesOfString:replaceStr withString:changeReplaceStr];
            return resultUserName;
        }
    }
    return userName;
}

#pragma mark - 获取银行卡手机后四位
+ (NSString *)bankCardLastFourNumber:(NSString *)bankCard{
    NSString *lastFourCardNumber = [NSString string];
    if (bankCard) {
        NSInteger fromIndex = bankCard.length - 4;
        if (fromIndex > 0) {
            lastFourCardNumber = [bankCard substringFromIndex:fromIndex];
            return lastFourCardNumber;
        } else {
            return bankCard;
        }
    } else {
        return @"";
    }
}


@end
