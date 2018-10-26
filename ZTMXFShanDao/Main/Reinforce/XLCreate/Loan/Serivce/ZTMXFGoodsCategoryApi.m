//
//  ZTMXFGoodsCategoryApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 凉 on 2018/7/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFGoodsCategoryApi.h"

@interface ZTMXFGoodsCategoryApi ()

@property (nonatomic, assign)int rank;

@end


@implementation ZTMXFGoodsCategoryApi


- (id)initWithRank:(int)rank
{
    self = [super init];
    if (self) {
        _rank = rank;
    }
    return self;
}



- (id)requestArgument{
    return @{@"rank":@(_rank)};
}
- (NSString *)requestUrl{
    return @"/mall/getGoodsCategory";
}
@end
