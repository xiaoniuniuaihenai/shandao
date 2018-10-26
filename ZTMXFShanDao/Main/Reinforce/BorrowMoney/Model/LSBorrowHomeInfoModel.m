//
//  LSBorrowHomeInfoModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBorrowHomeInfoModel.h"
@implementation LSBorrowHomeInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bannerList" : [LSBorrowBannerModel class], @"scrollbarList" : [LSHornBarModel class]};
}

@end

@implementation ConsumeLoanStatusInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"borrowMoneyDays" : @"newBorrowDays"};
}

@end

@implementation WhiteLoanStatusInfo

@end
