//
//  ConfirmReceiveApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ConfirmReceiveApi.h"

@interface ConfirmReceiveApi ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation ConfirmReceiveApi

- (instancetype)initWithOrderId:(NSString *)orderId{
    if (self = [super init]) {
        _orderId = orderId;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.orderId forKey:@"orderId"];
    return paramDict;
}
- (NSString * )requestUrl{
    return @"/mall/confirmReceive";
}
@end
