//
//  LSLoanDetailHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSLoanDetailModel;

@protocol LoanDetailHeaderViewDelegate <NSObject>
/** 点击延期还款 */
- (void)boneDetailHeaderViewClickRenew;
/** 点击马上提额 */
- (void)boneDetailHeaderViewClickPromoteAmount;
/** 点击马上还款 */
- (void)boneDetailHeaderViewClickRepayment;

@end


@interface LSLoanDetailHeaderView : UIView

@property (nonatomic, strong) LSLoanDetailModel *loanDetailModel;

@property (nonatomic, weak) id<LoanDetailHeaderViewDelegate> delegate;

@end
