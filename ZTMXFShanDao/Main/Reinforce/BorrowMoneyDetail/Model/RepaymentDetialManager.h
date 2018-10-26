//
//  RepaymentDetialManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSRepaymentDetailModel;
@class LSBillDetailModel;

@interface RepaymentDetialManager : NSObject

+ (NSArray *)manageWithRenewDetailModel:(LSRepaymentDetailModel *)repaymentDetailModel;

+ (NSArray *)managerWithBillDetailModel:(LSBillDetailModel *)billDetailModel;

@end
