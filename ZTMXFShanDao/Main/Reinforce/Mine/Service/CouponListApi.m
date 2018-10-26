//
//  CouponListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "CouponListApi.h"

@interface CouponListApi ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation CouponListApi

- (instancetype)initWithPage:(NSInteger)page{
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/getMineCouponList";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:[NSString stringWithFormat:@"%ld", _page] forKey:@"pageNo"];
    return paramDict;
}


@end
