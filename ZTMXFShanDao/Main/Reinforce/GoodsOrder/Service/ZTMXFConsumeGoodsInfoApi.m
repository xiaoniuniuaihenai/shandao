//
//  ConsumeGoodsInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFConsumeGoodsInfoApi.h"

@interface ZTMXFConsumeGoodsInfoApi ()

@property (nonatomic, copy) NSString *goodsId;

@end

@implementation ZTMXFConsumeGoodsInfoApi

- (instancetype)initWithGoodsId:(NSString *)goodsId{
    if (self = [super init]) {
        _goodsId = goodsId;
    }
    return self;
}

- (NSString * )requestUrl{
    return @"/mall/getConsumdebtGoodsDetail";
}



- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.goodsId forKey:@"goodsId"];
    return paramDict;
}

@end
