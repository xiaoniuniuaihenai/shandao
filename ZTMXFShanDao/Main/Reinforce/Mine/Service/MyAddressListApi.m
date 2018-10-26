//
//  MyAddressListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MyAddressListApi.h"

@interface MyAddressListApi ()

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation MyAddressListApi

- (instancetype)initWithId:(NSString *)addressId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize{
    self = [super init];
    if (self) {
        _id = addressId;
        _pageNum = pageNum;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/getUserAddress";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
//    [paramDict setValue:_id forKey:@"id"];
    [paramDict setValue:[NSString stringWithFormat:@"%ld", _pageSize] forKey:@"pageSize"];
    [paramDict setValue:[NSString stringWithFormat:@"%ld", _pageNum] forKey:@"pageNum"];
    return paramDict;
}

@end
