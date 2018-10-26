//
//  LSGainBankCodeApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
// 获得银行卡预留手机号验证码

#import "BaseRequestSerivce.h"

@interface LSGainBankCodeApi : BaseRequestSerivce
/**
 @param cardNumber 银行卡号
 @param mobile 手机号
 @param bankCode 银行编号
 @param bankName 银行名称
 */
-(instancetype)initWithCardNumber:(NSString*)cardNumber andMobile:(NSString*)mobile andBankCode:(NSString*)bankCode andBankName:(NSString*)bankName;
@end
