//
//  NSString+Helpers.h
//  YuCaiShi
//
//  Created by 陈传亮 on 2017/4/11.
//  Copyright © 2017年 陈传亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)
/**手机号码验证 */
+ (BOOL)mobileNumVerificationWithNumStr:(NSString *)numStr;
/**纯数字验证  */
+ (BOOL)deptNumInputShouldNumberWithStr:(NSString *)str;
/**密码验证   */
+ (BOOL)passqordWithStr:(NSString *)str;
/**身份证验证   */
+ (BOOL)IsIdentityCard:(NSString *)IDCardNumber;
/** MD加密 */
+ (NSString *)getMd5_32Bit:(NSString *)str;
/** 截取时间字符串 */
+ (NSString *)dateWithDate:(NSString *)str;
/** 打电话 */
+ (void)makePhoneCall;

+ (NSString *)getAddress:(NSString * )address;


@end
