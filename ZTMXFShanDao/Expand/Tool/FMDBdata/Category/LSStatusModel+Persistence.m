//
//  LSStatusModel+Persistence.m
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/20.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "LSStatusModel+Persistence.h"

@implementation LSStatusModel (Persistence)
/**
 *  插入数据库
 *
 *  @param array
 *
 *  @return
 */
+(BOOL)status_insertArray:(NSArray *)array{
    
    NSMutableArray *marray =[[NSMutableArray alloc] init];
    for (LSStatusModel *userinfo in array) {
        [marray addObject:[userinfo valueAndSqlTable:@"t_status"]];
    }
    return [FMDBHelper executeBatch2:marray useTransaction:YES];
}



/**
 *  修改状态信息
 *
 *  @param status 要修改的内容
 *  @param type  修改信息的key
 *
 *  @return
 */
+(BOOL)status_updateStatusInfoStatus:(NSString *)status type:(NSString *)type{
    NSString *sql = [NSString stringWithFormat:@"update t_status set statusUpdate='%@' where statusType='%@'",status,type];
    return [FMDBHelper update:sql];

}
/**
 *  根据type获取状态信息
 *
 *  @param type 0、同步地址时间
 *
 *  @return
 */
+(LSStatusModel *)status_selectStatusInfoByType:(NSString *)type{
    
    NSArray *array = [FMDBHelper query:@"t_status" where:[NSString stringWithFormat:@"statusType = '%@'",type ], nil];
    LSStatusModel *model = nil;
    if (array&&array.count>0) {
        NSDictionary *dic = array[0];
        model = [LSStatusModel status_statusInfoWithDictionary:dic];
    }
    return model;
}

+(LSStatusModel *)status_statusInfoWithDictionary:(NSDictionary *)dic{
    LSStatusModel *model = [[LSStatusModel alloc] init];
    model.statusType = dic[@"statusType"];
    model.statusUpdate = dic[@"statusUpdate"];
    return model;
    
}
@end
