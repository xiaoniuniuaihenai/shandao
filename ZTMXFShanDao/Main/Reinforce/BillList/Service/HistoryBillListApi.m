//
//  HistoryBillListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "HistoryBillListApi.h"

@interface HistoryBillListApi ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation HistoryBillListApi

-(instancetype)initWithPageNum:(NSInteger)page{
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}



- (NSString *)requestUrl{
    return @"/bill/getHistory";
}

- (id)requestArgument{
    
    return @{@"pageNum":[NSString stringWithFormat:@"%ld",(long)_page],@"pageSize":@"10"};
}

@end
