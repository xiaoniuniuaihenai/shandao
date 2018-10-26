//
//  XLGetXbehaviorSwitchApi.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/8/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFGetXbehaviorSwitchApi.h"

@implementation ZTMXFGetXbehaviorSwitchApi

- (NSString *)requestUrl{
    return @"/system/getXbehaviorSwitch";
}

- (id)requestArgument{
    return @{};
}

@end
