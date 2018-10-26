//
//  LSBorrowConfirmViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"
@class LSBorrwingCashInfoModel;

typedef NS_ENUM(NSInteger, LSBorrowMoneyType) {
    LSWhiteCollarLoanType,
    LSConsumptionLoanType
};

@interface LSBorrowConfirmViewController : BaseViewController

@property (nonatomic, strong) LSBorrwingCashInfoModel * cashInfoModel;

@property (nonatomic, assign) LSBorrowMoneyType borrowMoneyType;

@end
