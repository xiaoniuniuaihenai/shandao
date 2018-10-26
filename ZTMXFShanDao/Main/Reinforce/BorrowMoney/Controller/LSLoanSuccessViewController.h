//
//  LSLoanSuccessViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger ,LSLoanSuccessType) {
    LSWhiteCollarType,       //白领贷
    LSConsumerLoanType       //消费贷
};

@interface LSLoanSuccessViewController : BaseViewController

@property (nonatomic,assign) LSLoanSuccessType loanType;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *borrowId;

@end
