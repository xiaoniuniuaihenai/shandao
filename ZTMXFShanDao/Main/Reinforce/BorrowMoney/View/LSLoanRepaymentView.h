//
//  LSLoanRepaymentView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSRepaymentPageInfoModel;
@class CounponModel;

@protocol LoanRepaymentViewDelegate <NSObject>

/** 点击优惠券 */
- (void)repaymentViewClickCoupon:(NSString *)repaymentAmount;
/** 点击去付款 */
- (void)repaymentViewClickPayAcutualAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId balance:(NSString *)balance;

@end

@interface LSLoanRepaymentView : UIView

@property (nonatomic, strong) LSRepaymentPageInfoModel *repaymentInfoModel;
/** 当前选中优惠券Model */
@property (nonatomic, strong) CounponModel *selectCouponModel;
/** 还款总金额 */
@property (nonatomic, copy) NSString *repaymentTotalAmount;
/** 借款ID */
@property (nonatomic, copy) NSString *borrowId;
/** 本次还款金额 */
@property (nonatomic, copy) NSString *currentRepaymentAmount;

@property (nonatomic, weak) id<LoanRepaymentViewDelegate> delegate;

/** 还款页面是否可编辑 */
- (void)configRepaymentViewEdit:(BOOL)edit;
/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

- (void)payButtonAction;


@end
