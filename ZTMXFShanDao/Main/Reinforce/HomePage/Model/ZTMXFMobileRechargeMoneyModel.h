//
//  MobileRechargeMoneyModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFMobileRechargeMoneyModel : NSObject
//amount    String    充值金额   
@property (nonatomic,copy) NSString * amount;
//actual    String    实际支付金额
@property (nonatomic,copy) NSString * actual;

@end
