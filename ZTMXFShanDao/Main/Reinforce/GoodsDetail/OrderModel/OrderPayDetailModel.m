//
//  OrderPayDetailModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderPayDetailModel.h"
#import "GoodsNperInfoModel.h"

@implementation OrderPayDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"nperList" : [GoodsNperInfoModel class]};
}

-(void)setOrderActual:(NSString *)orderActual{
    if ([orderActual isKindOfClass:[NSString class]]) {
        NSNumber * number = (NSNumber *)orderActual;
        _orderActual = [NSString decimalNumberWithAmountStr:number.doubleValue];
        _orderActual = [NSString stringWithFormat:@"%.2f",[_orderActual floatValue]];
    }else{
        _orderActual = orderActual;
    }
}


-(void)setOrderAmount:(NSString *)orderAmount{
    if ([orderAmount isKindOfClass:[NSString class]]) {
        NSNumber * number = (NSNumber *)orderAmount;
        _orderAmount = [NSString decimalNumberWithAmountStr:number.doubleValue];
    }else{
        _orderAmount = orderAmount;
    }
}
@end
