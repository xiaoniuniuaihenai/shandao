//
//  MobileRechargeMoneyModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMobileRechargeMoneyModel.h"

@implementation ZTMXFMobileRechargeMoneyModel
-(void)setAmount:(NSString *)amount{
    if ([amount isKindOfClass:[NSString class]]) {
        NSNumber * number = (NSNumber *)amount;
      _amount = [NSString decimalNumberWithAmountStr:number.doubleValue];
    }else{
        _amount = amount;
    }
}


-(void)setActual:(NSString *)actual{
    if ([actual isKindOfClass:[NSString class]]) {
        NSNumber * number = (NSNumber *)actual;
        _actual = [NSString decimalNumberWithAmountStr:number.doubleValue];
        _actual = [NSString stringWithFormat:@"%.2f",[_actual floatValue]];
    }else{
        _actual = actual;
    }
}
@end
