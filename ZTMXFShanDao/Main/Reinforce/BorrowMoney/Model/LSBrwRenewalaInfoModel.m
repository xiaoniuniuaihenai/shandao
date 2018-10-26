//
//  LSBrwRenewalaInfoModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBrwRenewalaInfoModel.h"
#import "BankCardModel.h"

@implementation LSBrwRenewalaInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bankList" : [BankCardModel class], @"renewalList" : [RenewalAmountModel class]};
}

@end

@implementation RenewalAmountModel

@end

