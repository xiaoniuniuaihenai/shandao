//
//  UnpaidBillListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UnpaidBillListApi.h"

@interface UnpaidBillListApi ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation UnpaidBillListApi

-(instancetype)initWithPageNum:(NSInteger)page{
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}




- (NSString *)requestUrl{
    return @"/bill/getUnpaid";
}

- (id)requestArgument{
    
    return @{@"pageNum":[NSString stringWithFormat:@"%ld",_page],@"pageSize":@"10"};
}



@end
