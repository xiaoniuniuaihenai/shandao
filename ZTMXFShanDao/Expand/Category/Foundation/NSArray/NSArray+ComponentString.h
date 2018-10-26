//
//  NSArray+ComponentString.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ComponentString)

/** 通过component隔开 组成字符串 */
- (NSString *)componentByString:(NSString *)component;

@end
