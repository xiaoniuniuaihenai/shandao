//
//  RepaymentDetailApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface RepaymentDetailApi : BaseRequestSerivce

- (instancetype)initWithRepaymentId:(NSString *)repaymentId;

@end
