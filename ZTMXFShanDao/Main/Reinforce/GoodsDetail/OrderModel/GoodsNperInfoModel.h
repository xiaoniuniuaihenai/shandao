//
//  GoodsNperInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsNperInfoModel : NSObject

/** 分期id */
@property (nonatomic, copy) NSString *rid;
/** 分期数 */
@property (nonatomic, assign) NSInteger nper;
/** 总手续费 */
@property (nonatomic, assign) double pdgAmount;
/** 每期手续费 */
@property (nonatomic, assign) double monthPdg;
/** 月供 */
@property (nonatomic, assign) double monthAmount;
/** 应还总额 */
@property (nonatomic, assign) double repayAmount;

@end
