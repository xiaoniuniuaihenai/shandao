//
//  LSStatusModel.h
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/20.
//  Copyright © 2016年 ala. All rights reserved.
//

/**
 *  更新信息数据处理
 */
#import <Foundation/Foundation.h>
#import "LSCustomBaseModel.h"

@interface LSStatusModel : LSCustomBaseModel
@property (nonatomic, copy) NSString *statusType; //0、地址同步时间；
@property (nonatomic, copy) NSString *statusUpdate;
@end
