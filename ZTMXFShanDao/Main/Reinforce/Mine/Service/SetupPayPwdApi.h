//
//  SetupPayPwdApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface SetupPayPwdApi : BaseRequestSerivce

/** F:忘记支付密码设置； （verifyCode、IdNumber 必填）
 S:实名认证过立即设置支付密码；（IdNumber 必填）
 C:修改支付密码；（oldPwd 必填 */
- (instancetype)initWithOriginalPassword:(NSString *)original newPassword:(NSString *)newPwd verifyCode:(NSString *)code idNumber:(NSString *)idNumber type:(NSString *)type;

@end
