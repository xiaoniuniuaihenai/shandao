//
//  NSString+Helpers.m
//  YuCaiShi
//
//  Created by 陈传亮 on 2017/4/11.
//  Copyright © 2017年 陈传亮. All rights reserved.
//

#import "NSString+Helpers.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helpers)
//手机号验证
+ (BOOL)mobileNumVerificationWithNumStr:(NSString *)numStr
{
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString *MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
   return [regextestmobile evaluateWithObject:numStr];
}

//密码验证
+ (BOOL)passqordWithStr:(NSString *)str
{
//    NSLog(@"111%@111", str);
    NSString *regex =@"^[A-Za-z0-9]{6,16}$";
//    NSString * rea = @"^(?:\\d+|[a-zA-Z]+|[\\\\!@#$%^&*-/:;\\[|\\]()\".,?'\\{}+=_|~<>€£¥•]+)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    NSLog(@"=====%d", [pred evaluateWithObject:str]);
    return [pred evaluateWithObject:str];
}

//身份证验证
+ (BOOL)IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}
/** MD5_32加密 */

+ (NSString *)getMd5_32Bit:(NSString *)str
{
    const char * cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)str.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
/** 截取时间字符串 */
+ (NSString *)dateWithDate:(NSString *)str
{
    NSArray *array = [str componentsSeparatedByString:@" "];
    if (array.count) {
        return array[0];
    }
    return str;
}
//数字验证
+ (BOOL)deptNumInputShouldNumberWithStr:(NSString *)str
{
    NSString *regex =@"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //    if (![pred evaluateWithObject:str]) {
    //        return YES;
    //    }
    return [pred evaluateWithObject:str];
}
/** 打电话 */
+ (void)makePhoneCall
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",K_CustomerServiceNum];
    dispatch_after(0.3, dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];//隐私设置
    });
}


+ (NSString *)getAddress:(NSString * )address
{
    NSString * str = [address stringByReplacingOccurrencesOfString:@"," withString:@" "];
    return str;
}


@end
