//
//  LSCustomBaseModel.h
//  AlaSoft
//
//  Created by su on 16/4/15.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCustomBaseModel : NSObject

- (NSArray *)filterPropertys;
-(NSDictionary*)modelStringPropertiesToDictionary;

-(NSString *)modelInsertSql:(NSString *)table;
-(NSDictionary *)valueAndSqlTable:(NSString *)table;
@end
