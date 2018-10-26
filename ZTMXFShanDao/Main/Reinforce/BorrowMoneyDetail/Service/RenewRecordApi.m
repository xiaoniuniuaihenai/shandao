//
//  RenewRecordApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RenewRecordApi.h"

@interface RenewRecordApi ()

@property (nonatomic, copy)     NSString *borrowId;
@property (nonatomic, assign)   NSInteger page;

@end

@implementation RenewRecordApi

- (instancetype)initWithBorrowId:(NSString *)borrowId page:(NSInteger)page{
    self = [super init];
    if (self) {
        _borrowId = borrowId;
        _page = page;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/borrowCash/getRenewalList";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:[NSString stringWithFormat:@"%ld", _page] forKey:@"pageNo"];
    [paramDict setValue:_borrowId forKey:@"borrowId"];
    return paramDict;
}

@end
