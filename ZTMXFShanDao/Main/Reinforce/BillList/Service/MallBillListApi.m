//
//  MallBillListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MallBillListApi.h"

@interface MallBillListApi ()

@property (nonatomic, copy) NSString *billType;

@end

@implementation MallBillListApi

- (instancetype)initWithBillType:(NSString *)billType
{
    self = [super init];
    if (self) {
        _billType = billType;
    }
    return self;
}



- (NSString *)requestUrl{
    return @"/mall/getMallBillList";
}

- (id)requestArgument{
    
    return @{@"type":self.billType};
}

@end
