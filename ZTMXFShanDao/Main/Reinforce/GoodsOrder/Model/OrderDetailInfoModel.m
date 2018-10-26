//
//  OrderDetailInfoModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderDetailInfoModel.h"

@implementation OrderDetailInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"stageList" : [OrderGoodsNperInfoModel class]};
}

@end


@implementation OrderGoodsNperInfoModel

@end

