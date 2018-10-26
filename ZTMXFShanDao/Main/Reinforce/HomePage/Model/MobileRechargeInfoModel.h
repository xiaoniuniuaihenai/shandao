//
//  MobileRechargeInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/2/1.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  充值信息

#import <Foundation/Foundation.h>
#import "ZTMXFMobileRechargeMoneyModel.h"
@interface MobileRechargeInfoModel : NSObject

/**
 充值金额列表
 */
@property (nonatomic,strong) NSMutableArray * rechargeList;

/** 提示信息*/
@property (nonatomic,copy  ) NSString  * rechargePrompt;

@end
