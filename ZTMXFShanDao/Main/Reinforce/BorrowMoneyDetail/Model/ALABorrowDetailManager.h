//
//  ALABorrowDetailManager.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/21.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSLoanDetailModel;
@class WhiteLoanInfoModel;

@interface ALABorrowDetailManager : NSObject

+ (NSMutableArray *)manageRenewDetailModel:(LSLoanDetailModel *)model;

+ (NSMutableArray *)managerPeriodDetailModel:(WhiteLoanInfoModel *)model;

@end
