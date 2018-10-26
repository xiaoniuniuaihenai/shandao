//
//  BillDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BillDetailApi.h"

@interface BillDetailApi ()

@property (nonatomic, assign) long billId;

@end

@implementation BillDetailApi

-(instancetype)initWithBillId:(long)billId{
    self = [super init];
    if (self) {
        _billId = billId;
    }
    return self;
}



- (NSString *)requestUrl{
    return @"/bill/getBillInfo";
}

- (id)requestArgument{
    
    return @{@"billId":[NSString stringWithFormat:@"%ld",_billId]};
}

@end
