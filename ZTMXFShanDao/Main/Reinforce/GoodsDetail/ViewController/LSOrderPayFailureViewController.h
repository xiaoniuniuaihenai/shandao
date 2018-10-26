//
//  LSOrderPayFailureViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@interface LSOrderPayFailureViewController : BaseViewController

/** 订单Id */
@property (nonatomic, copy) NSString *orderId;
/** 状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 描述详情 */
@property (nonatomic, copy) NSString *finishDesc;

@end
