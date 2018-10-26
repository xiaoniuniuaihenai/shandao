//
//  LoanDetailApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface LoanDetailApi : BaseRequestSerivce

- (instancetype)initWithBorrowId:(NSString *)borrowId;

@end
