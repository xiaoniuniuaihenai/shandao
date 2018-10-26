//
//  HomePageMallModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "HomePageMallModel.h"

@implementation HomePageMallModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bannerList" : [MallBannerModel class], @"categoryList" : [MallCategoryModel class],@"bannerListTwo":[MallBannerModel class], @"bannerGoodsList" : [MallBannerGoodsModel class]};
}

@end



@implementation MallBannerModel

@end

@implementation MallCategoryModel

@end

@implementation MallBannerGoodsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bannerList" : [MallBannerModel class], @"goodsList" : [MallGoodsModel class] };
}

@end

@implementation MallGoodsModel

@end
