//
//  LSRepaymentPageInfoModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSRepaymentPageInfoModel.h"
#import "BankCardModel.h"

@implementation LSRepaymentPageInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bankList": [BankCardModel class]};
}

@end

