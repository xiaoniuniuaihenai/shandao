//
//  ApplyRefundInfoModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ApplyRefundInfoModel.h"
#import "ApplyRefundGoodsInfoModel.h"

@implementation ApplyRefundInfoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"reasonList" : [ApplyRefundReasonModel class]};
}

@end


@implementation ApplyRefundReasonModel

@end

