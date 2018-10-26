//
//  NSDictionary+JSONString.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSDictionary+JSONString.h"

@implementation NSDictionary (JSONString)
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)JSONString{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
#pragma mark - 通过 JSON字符串 构造一个字典（JSON字符串 转 字典）
+ (NSDictionary*)initWithJsonString:(NSString*)json
{
    NSData* infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (!infoData) {
        return nil;
    }
    NSDictionary* info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:nil];
    return info;
}

@end
