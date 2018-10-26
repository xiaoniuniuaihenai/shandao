//
//  LSMyOrderApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSMyOrderApi.h"

@interface LSMyOrderApi ()

@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation LSMyOrderApi

- (instancetype)initWithPageNum:(NSInteger)page{
    self = [super init];
    if (self) {
        _pageNum = page;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/user/getConsumdebtOrder";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:[NSString stringWithFormat:@"%ld",_pageNum] forKey:@"pageNum"];
   
    return paramDict;
}

@end
