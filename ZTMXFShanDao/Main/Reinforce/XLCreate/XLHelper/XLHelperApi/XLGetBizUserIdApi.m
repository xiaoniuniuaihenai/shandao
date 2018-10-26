//
//  XLGetBizUserIdApi.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/8/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLGetBizUserIdApi.h"

@interface XLGetBizUserIdApi ()

@property (nonatomic, strong) NSString *userName;

@end

@implementation XLGetBizUserIdApi

- (instancetype)initWithUserName:(NSString *)userName{
    if (self = [super init]) {
        _userName = userName;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/getBizUserId";
}

- (id)requestArgument{
    return @{@"userName":_userName};
}

@end
