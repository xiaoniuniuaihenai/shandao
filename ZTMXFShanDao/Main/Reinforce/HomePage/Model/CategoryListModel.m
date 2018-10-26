//
//  CategoryListModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CategoryListModel.h"

@implementation CategoryListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bannerList":[CategoryBannerModel class], @"categoryList":[CategoryGoodsModel class]};
}

@end

@implementation CategoryBannerModel

@end



@implementation CategoryGoodsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goodsList":[CategoryGoodsInfoModel class]};
}

@end

@implementation CategoryGoodsInfoModel


@end
