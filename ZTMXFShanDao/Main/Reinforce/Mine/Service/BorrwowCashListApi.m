//
//  BorrwowCashListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BorrwowCashListApi.h"

@interface BorrwowCashListApi ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation BorrwowCashListApi

- (instancetype)initWithPage:(NSInteger)page{
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/borrowCash/getBorrowCashListV1";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:[NSString stringWithFormat:@"%ld", _page] forKey:@"pageNo"];
    return paramDict;
}

@end
