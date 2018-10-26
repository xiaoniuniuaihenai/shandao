//
//  LSAreaModel+Persistence.m
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/19.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "LSAreaModel+Persistence.h"

@implementation LSAreaModel (Persistence)

#pragma 插入数据库


/**
 *  获取所有省
 *
 *  @return
 */

+(NSArray *)area_selectAllProvince{
  
   NSArray *array = [FMDBHelper query:@"t_area" where:@"type = 'PROVINCE'", nil];
    NSMutableArray *arrayModel = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        LSAreaModel *model = [LSAreaModel area_modelWithDic:dic];
        [arrayModel addObject:model];
    }
    return arrayModel;
}
/**
 *  插入数据库
 *
 *  @param array
 *
 *  @return
 */
+(BOOL)area_insertArray:(NSArray *)array{
    NSMutableArray *marray =[[NSMutableArray alloc] init];
    for (LSAreaModel *userinfo in array) {
        [marray addObject:[userinfo valueAndSqlTable:@"t_area"]];
    }
    
    return [FMDBHelper executeBatch2:marray useTransaction:YES];
}

/**
 *  根据code 获取对应地址信息
 *
 *  @param code
 *
 *  @return
 */
+(LSAreaModel *)area_selectAreaFrom:(NSString *)code{
    LSAreaModel *model = nil;
    NSArray *array = [FMDBHelper query:@"t_area" where:[NSString stringWithFormat:@"parentCode='%@'",code], nil];
    if (array&&array.count>0) {
        NSDictionary *dic = array[0];
        model = [LSAreaModel area_modelWithDic:dic];
    }
    return model;
}




/**
 *  根据code 获取对应下一级地址信息列表
 *
 *  @param code
 *
 *  @return
 */
+(NSArray *)area_selectAreaListFrom:(NSString *)code{
    NSArray *array = [FMDBHelper query:@"t_area" where:[NSString stringWithFormat:@"parentCode='%@'",code], nil];
    NSMutableArray *arrayModel = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        LSAreaModel *model = [LSAreaModel area_modelWithDic:dic];
        [arrayModel addObject:model];
    }
    return arrayModel;
    

}
/**
 *  根据name 获取对应地址信息
 *
 *  @param name
 *
 *  @return
 */
+(LSAreaModel *)area_selectAreaFromName:(NSString *)name{
    LSAreaModel *model = nil;
    NSArray *array = [FMDBHelper query:@"t_area" where:[NSString stringWithFormat:@"name='%@'",name], nil];
    if (array&&array.count>0) {
        NSDictionary *dic = array[0];
        model = [LSAreaModel area_modelWithDic:dic];
    }
    return model;
}
/**
 *  字典转化成model
 *
 *  @param dic
 *
 *  @return
 */

+(LSAreaModel *)area_modelWithDic:(NSDictionary *)dic{
    LSAreaModel *model = [[LSAreaModel alloc] init];
    model.rid =[NSString stringWithFormat:@"%@",dic[@"rid"]] ;
    model.name =[NSString stringWithFormat:@"%@",dic[@"name"]];
    model.firstletter =[NSString stringWithFormat:@"%@",dic[@"firstletter"]];
    model.code =[NSString stringWithFormat:@"%@",dic[@"code"]];
    model.parentCode =[NSString stringWithFormat:@"%@",dic[@"parentCode"]];
    model.pinyin =[NSString stringWithFormat:@"%@",dic[@"pinyin"]];
    model.shengzhixia =[NSString stringWithFormat:@"%@",dic[@"shengzhixia"]];
    model.type =[NSString stringWithFormat:@"%@",dic[@"type"]];
    model.zhixiashi =[NSString stringWithFormat:@"%@",dic[@"zhixiashi"]];
    model.isOpen =[NSString stringWithFormat:@"%@",dic[@"isOpen"]?dic[@"isOpen"]:@"0"];
    return model;
}

@end
