//
//  OrderListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderListApi.h"

@interface OrderListApi ()

/** 请求页面(从1开始) */
@property (nonatomic, copy) NSString *pageNumber;

@end

@implementation OrderListApi

- (instancetype)initWithPageNumber:(NSInteger)pageNumber{
    if (self = [super init]) {
        _pageNumber = [NSString stringWithFormat:@"%ld", pageNumber];
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.pageNumber forKey:@"pageNo"];
    return paramDict;
}
- (NSString * )requestUrl{
    return @"/mall/getMallOrderList";
}
@end
