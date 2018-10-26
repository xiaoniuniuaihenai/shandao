//
//  WhiteLoanDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "WhiteLoanDetailApi.h"

@interface WhiteLoanDetailApi ()

@property (nonatomic, copy) NSString *borrowId;

@end

@implementation WhiteLoanDetailApi

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
    return @"/borrowCash/getStageBorrowInfo";
}
@end
