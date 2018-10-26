//
//  LSRepaymentCouponListApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface LSRepaymentCouponListApi : BaseRequestSerivce

- (instancetype)initWithBorrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount pageNum:(NSInteger)pageNo;

@end
