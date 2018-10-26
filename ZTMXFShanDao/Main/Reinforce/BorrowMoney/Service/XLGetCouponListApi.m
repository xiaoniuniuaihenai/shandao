//
//  XLGetCouponListApi.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/6/25.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLGetCouponListApi.h"

@interface XLGetCouponListApi()
@property (nonatomic, assign) float amount;
@end

@implementation XLGetCouponListApi
- (instancetype)initWithAmount:(float)amount{
    if (self = [super init]) {
        _amount = amount;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/borrowCash/getCouponListApi";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:[NSString stringWithFormat:@"%f", _amount] forKey:@"amount"];
    return paramDict;
}

@end
