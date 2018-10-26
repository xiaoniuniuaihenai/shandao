//
//  LSConfirmView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBorrwingCashInfoModel;

@interface LSConfirmView : UIView

@property (nonatomic, strong) LSBorrwingCashInfoModel * cashInfoModel;

/** 借款用途 */
@property (nonatomic, copy) NSString *purposeTitle;

- (instancetype)initWithFrame:(CGRect)frame confirmType:(LoanType)loanType;

@end
