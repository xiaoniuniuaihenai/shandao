//
//  NSDictionary+JSONString.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONString)
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)JSONString;
#pragma mark - 通过 JSON字符串 构造一个字典（JSON字符串 转 字典）
/**
 * 通过 JSON字符串 构造一个字典（JSON字符串 转 字典）
 */
+ (NSDictionary*)initWithJsonString:(NSString*)json;

@end
