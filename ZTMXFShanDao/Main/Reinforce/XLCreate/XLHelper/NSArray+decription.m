//
//  NSArray+decription.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "NSArray+decription.h"

@implementation NSArray (decription)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    for (id obj in self) {
        
        [str appendFormat:@"\t%@, \n", obj];
    }
    [str appendString:@")"];
    return str;
    
}
@end
