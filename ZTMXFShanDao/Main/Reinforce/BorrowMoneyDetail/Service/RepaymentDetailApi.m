//
//  RepaymentDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RepaymentDetailApi.h"

@interface RepaymentDetailApi ()

@property (nonatomic, copy) NSString *repaymentId;

@end

@implementation RepaymentDetailApi

- (instancetype)initWithRepaymentId:(NSString *)repaymentId{
    self = [super init];
    if (self) {
        _repaymentId = repaymentId;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_repaymentId forKey:@"repayId"];
    return paramDict;
}
- (NSString *)requestUrl{
    return @"/repayCash/getRepayCashInfo";
}



@end
