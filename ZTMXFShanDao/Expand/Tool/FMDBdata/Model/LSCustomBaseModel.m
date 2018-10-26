//
//  LSCustomBaseModel.m
//  AlaSoft
//
//  Created by su on 16/4/15.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "LSCustomBaseModel.h"
#import <objc/runtime.h>
@implementation LSCustomBaseModel

- (NSArray *)filterPropertys
{
    NSMutableArray* props = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
        //        NSLog(@"name:%s",property_getName(property));
        //        NSLog(@"attributes:%s",property_getAttributes(property));
    }
    free(properties);
    return props;
}



#pragma mark 模型中的字符串类型的属性转化为字典


-(NSString *)modelInsertSql:(NSString *)table{
    NSAssert(table , @"table cannot be nil!");
    NSDictionary *dic = [self modelStringPropertiesToDictionary];
    NSMutableArray *columns = [NSMutableArray array];
    NSMutableArray *placeholder = [NSMutableArray array];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj && ![obj isEqual:[NSNull null]]) {
            [columns addObject:key];
            [placeholder addObject:@"?"];
        }
    }];
    
    NSString *sql = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)",  table, [columns componentsJoinedByString:@","], [placeholder componentsJoinedByString:@","]];
    return sql;
}
-(NSDictionary*)modelStringPropertiesToDictionary
{
    NSArray* properties = [self filterPropertys];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString* key = (NSString*)obj;
        id value = [self valueForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString* va =  (NSString*)value;
            if (va) {
                [dic setValue:value forKey:key];
                
            }
            
        }
        
    }];
    return dic;
}
-(NSDictionary *)valueAndSqlTable:(NSString *)table{
    NSAssert(table , @"table cannot be nil!");
    NSDictionary *dic = [self modelStringPropertiesToDictionary];
    NSMutableArray *columns = [NSMutableArray array];
    NSMutableArray *placeholder = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];

    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj && ![obj isEqual:[NSNull null]]) {
            [columns addObject:key];
            [values addObject:obj];
            
            [placeholder addObject:@"?"];
        }else{
            [columns addObject:key];
            [values addObject:@""];
            
            [placeholder addObject:@"?"];
        }
    }];
    
    NSString *sql = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)",  table, [columns componentsJoinedByString:@","], [placeholder componentsJoinedByString:@","]];
    NSMutableDictionary *sqlDic = [[NSMutableDictionary alloc] init];
    [sqlDic setValue:sql forKey:@"sql"];
    [sqlDic setValue:values forKey:@"values"];

    return sqlDic;
}

@end
