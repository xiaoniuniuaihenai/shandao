//
//  RenewDetailHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSRenewDetailModel;
@class LSRepaymentDetailModel;
@class LSBillDetailModel;

@protocol RenewDetailHeaderViewDelegate <NSObject>

- (void)renewDetailHeaderViewClickReturnBack;

@end

@interface RenewDetailHeaderView : UIView

@property (nonatomic, weak) id<RenewDetailHeaderViewDelegate> delegate;

/** 延期还款详情 */
@property (nonatomic, strong) LSRenewDetailModel *renewDetailModel;
/** 还款详情 */
@property (nonatomic, strong) LSRepaymentDetailModel *repaymentDetailModel;
/** 还款详情 */
@property (nonatomic, strong) LSBillDetailModel *billDetailModel;

@end
