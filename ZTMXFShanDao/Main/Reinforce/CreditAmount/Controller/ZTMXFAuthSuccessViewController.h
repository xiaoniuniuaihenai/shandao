//
//  LSAuthSuccessViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  认证结果

#import "BaseViewController.h"

@interface ZTMXFAuthSuccessViewController : BaseViewController

/** 认证描述 */
@property (nonatomic, copy) NSString *authDescribe;
/** 额度 */
@property (nonatomic, copy) NSString *creditAmount;

@end
