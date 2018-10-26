//
//  BankCardListModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BankCardListModel.h"
#import "BankCardModel.h"

@implementation BankCardListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bankCardList": [BankCardModel class]};
}

@end

