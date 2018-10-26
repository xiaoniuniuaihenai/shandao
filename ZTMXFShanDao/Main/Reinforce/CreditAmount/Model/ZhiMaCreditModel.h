//
//  ZhiMaCreditModel.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/10.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhiMaCreditModel : NSObject

/** 是否分数过低,1或者0 */
@property (nonatomic, assign) NSInteger tooLow;
/** 授信额度 */
@property (nonatomic, assign) NSInteger creditAmount;
/** 芝麻信用分 */
@property (nonatomic, assign) NSInteger zmScore;
/** 反欺诈分 */
@property (nonatomic, assign) NSInteger ivsScore;
/** 是否允许分期,1或者0 */
@property (nonatomic, assign) NSInteger allowConsume;
/** 评估时间 */
@property (nonatomic, assign) long long gmtZm;
/** 信用等级 */
@property (nonatomic, copy) NSString *creditLevel;
/** 信用评估时间 */
@property (nonatomic, assign) long long creditAssessTime;

@end
