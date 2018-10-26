//
//  LoanModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LoanModel.h"

@implementation WhiteStatusInfo

@end

@implementation ScrollbarList

@end

@implementation StatusInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"xlBorrowDays" : @"newBorrowDays", @"xlPoundageRate":@"newPoundageRate"};
}
@end



@implementation BannerList

@end

@implementation LoanModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"scrollbarList" : [ScrollbarList class], @"bannerList" : [BannerList class],@"botBannerList":[BannerList class]};
}

- (void)updateData
{
    NSMutableArray * imgs = [NSMutableArray array];
    for (BannerList * banner in self.bannerList) {
        [imgs addObject:banner.imageUrl];
    }
    self.bannerImgs = [imgs copy];
    NSMutableArray * titles = [NSMutableArray array];
    for (ScrollbarList * scrollbarList in self.scrollbarList) {
        [titles addObject:scrollbarList.content];
        if (self.scrollbarList.count == 1) {
            [titles addObject:scrollbarList.content];
        }
    }
    NSArray * days = [self.statusInfo.xlBorrowDays componentsSeparatedByString:@","];
    if (days.count) {
        self.timeParameter = days[0];
    }
    NSMutableArray * tempArr = [NSMutableArray array];
    for (NSString * dayStr in days) {
        if (dayStr.length) {
            [tempArr addObject:dayStr];
        }
    }
    self.days = [tempArr copy];
    self.amountParameter = self.statusInfo.maxAmount;
    self.titles = [titles copy];
    
}


@end
