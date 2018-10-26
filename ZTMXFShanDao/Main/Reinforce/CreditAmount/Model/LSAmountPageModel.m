//
//  LSAmountPageModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAmountPageModel.h"
#import "LSBorrowBannerModel.h"

@implementation LSAmountPageModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bannerList": [LSBorrowBannerModel class]};
}

@end
