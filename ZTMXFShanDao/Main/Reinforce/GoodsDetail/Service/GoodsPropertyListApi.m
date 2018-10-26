//
//  GoodsPropertyListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsPropertyListApi.h"

@interface GoodsPropertyListApi ()

@property (nonatomic, copy) NSString *goodsId;

@end

@implementation GoodsPropertyListApi

- (instancetype)initWithGoodsId:(NSString *)goodsId
{
    self = [super init];
    if (self) {
        _goodsId = goodsId;
    }
    return self;
}

- (NSString * )requestUrl{
    return @"/mall/getGoodsSkuPrice";
}

- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.goodsId forKey:@"goodsId"];
    return paramDict;
}

@end
