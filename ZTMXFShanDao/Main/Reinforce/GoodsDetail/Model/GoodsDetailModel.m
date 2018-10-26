//
//  GoodsDetailModel.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/8.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel

@end

@implementation GoodsDetailInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"detailImages": [GoodsDetailImageInfoModel class]};
}

@end


@implementation GoodsDetailImageInfoModel

@end

@implementation GoodsDetailBannerImageModel

@end
