//
//  LSStatusModel+Persistence.h
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/20.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "LSStatusModel.h"

@interface LSStatusModel (Persistence)
/**
 *  插入数据库
 *

 */
+(BOOL)status_insertArray:(NSArray *)array;

/**
 *  根据type获取状态信息
 *

 */
+(LSStatusModel *)status_selectStatusInfoByType:(NSString *)type;

/**
 *  修改状态信息
 *
 *  @param status 要修改的内容
 *  @param type  修改信息的key
 *

 */
+(BOOL)status_updateStatusInfoStatus:(NSString *)status type:(NSString *)type;


+(LSStatusModel *)status_statusInfoWithDictionary:(NSDictionary *)dic;

@end
