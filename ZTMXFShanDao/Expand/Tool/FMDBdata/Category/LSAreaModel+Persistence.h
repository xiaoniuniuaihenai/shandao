//
//  LSAreaModel+Persistence.h
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/19.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "LSAreaModel.h"

@interface LSAreaModel (Persistence)

/**
 *  插入数据库
 *
 *  @param array 插入地区数组
 *

 */
+(BOOL)area_insertArray:(NSArray *)array;

/**
 *  获取所有省
 *

 */

+(NSArray *)area_selectAllProvince;

/**
 *  根据code 获取对应地址信息
 *

 */
+(LSAreaModel *)area_selectAreaFrom:(NSString *)code;
/**
 *  根据name 获取对应地址信息
 *

 */
+(LSAreaModel *)area_selectAreaFromName:(NSString *)name;
/**
 *  根据code 获取对应下一级地址信息列表
 *

 */
+(NSArray *)area_selectAreaListFrom:(NSString *)code;

/**
 *  字典转化成model
 *

 */

+(LSAreaModel *)area_modelWithDic:(NSDictionary *)dic;
@end
