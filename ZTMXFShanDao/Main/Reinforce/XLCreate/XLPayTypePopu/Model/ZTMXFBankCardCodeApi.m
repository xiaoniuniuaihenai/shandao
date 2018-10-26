//
//  ZTMXFBankCardCodeApi.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFBankCardCodeApi.h"


@interface ZTMXFBankCardCodeApi ()

@property(nonatomic, copy)NSString * bankCardId;

@end
@implementation ZTMXFBankCardCodeApi



- (NSString *)requestUrl{
    return @"/auth/authBankcard2";
}

- (id)requestArgument
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_bankCardId forKey:@"bankId"];
    return paramDict;
}
- (instancetype)initWithBankCardId:(NSString *)bankCardId
{
    self = [super init];
    if (self) {
        _bankCardId = bankCardId;
    }
    return self;
}
@end

