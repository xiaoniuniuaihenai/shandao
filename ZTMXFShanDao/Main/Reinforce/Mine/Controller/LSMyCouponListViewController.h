//
//  LSMyCouponListViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  我的优惠券列表

#import "BaseViewController.h"
#import "ZTMXFTableViewController.h"
@class CounponModel;

@protocol CouponListViewDelegate <NSObject>

/** 选中优惠券 */
- (void)couponListViewSelectCoupon:(CounponModel *)couponModel;

@end

typedef enum : NSUInteger {
    MyCouponListType,                   //  我的优惠券列表
    RepaymentCouponListType,            //  还款可用优惠券列表
    LoanCouponListType,                 //  借款可用优惠券列表
} couponListType;

@interface LSMyCouponListViewController : ZTMXFTableViewController

@property (nonatomic, assign) couponListType couponType;

#pragma mark - 如果是还款可用优惠券需要下面参数
/** 借款Id */
@property (nonatomic, copy) NSString *borrowId;
/** 还款金额 */
@property (nonatomic, copy) NSString *repaymentAmount;

/** 借款金额 */
@property (nonatomic, assign) float  amount;

@property (nonatomic, weak) id<CouponListViewDelegate> delegate;

@end
