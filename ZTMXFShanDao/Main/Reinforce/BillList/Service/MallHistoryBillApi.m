//
//  MallHistoryBillApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MallHistoryBillApi.h"

@interface MallHistoryBillApi ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation MallHistoryBillApi

-(instancetype)initWithPageNum:(NSInteger)page{
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}



- (NSString *)requestUrl{
    return @"/mall/getMallHistoryBillList";
}

- (id)requestArgument{
    
    return @{@"pageNo":[NSString stringWithFormat:@"%ld",_page]};
}

@end
