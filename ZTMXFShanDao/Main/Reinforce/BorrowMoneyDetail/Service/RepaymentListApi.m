//
//  RepaymentListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RepaymentListApi.h"

@interface RepaymentListApi ()

@property (nonatomic, copy) NSString *borrowId;

@end

@implementation RepaymentListApi

- (instancetype)initWithBorrowId:(NSString *)borrowId{
    self = [super init];
    if (self) {
        _borrowId = borrowId;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_borrowId forKey:@"borrowId"];
    return paramDict;
}
- (NSString *)requestUrl{
    return @"/repayCash/getRepayCashList";
}

@end
