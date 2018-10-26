//
//  LoanDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LoanDetailApi.h"

@interface LoanDetailApi ()

@property (nonatomic, copy) NSString *borrowId;

@end

@implementation LoanDetailApi

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
    return @"/borrowCash/getBorrowCashDetail";
}
@end
