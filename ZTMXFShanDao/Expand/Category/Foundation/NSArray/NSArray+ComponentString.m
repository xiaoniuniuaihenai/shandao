//
//  NSArray+ComponentString.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "NSArray+ComponentString.h"

@implementation NSArray (ComponentString)

/** 通过component隔开 组成字符串 */
- (NSString *)componentByString:(NSString *)component{
    NSString *componentString = [NSString string];
    for (int i = 0; i < self.count; i ++) {
        if (i != self.count - 1) {
            componentString = [componentString stringByAppendingString:component];
        }
    }
    return componentString;
}

@end
