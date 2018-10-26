//
//  ALABorrowStateView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/21.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALABorrowDetailManager.h"
@class LSRenewDetailModel;
@class ALATopBottomLabelView;
@class ALATopBottomButtonView;
@protocol ALABorrowStateViewDelegate <NSObject>

/** 点击延期还款 */
- (void)borrowStateViewClickContinueBorrow;

/** 点击查看明细按钮 */
- (void)borrowStateViewClickViewDetail;

@end

@interface ALABorrowStateView : UIView

/** 状态 */
@property (nonatomic, strong) UILabel *stateLabel;
/** 状态描述 */
@property (nonatomic, strong) UILabel *stateDescribeLabel;
/** 灰色间隔view */
@property (nonatomic, strong) UIView  *gapView;
/** 灰色间隔view */
@property (nonatomic, strong) UIView  *bottomGapView;
/** 应还金额 */
@property (nonatomic, strong) ALATopBottomLabelView *shouldRepayView;
/** 已还金额 */
@property (nonatomic, strong) ALATopBottomButtonView *didRepayView;

/** view height */
@property (nonatomic, assign) CGFloat viewHeight;

/** delegate */
@property (nonatomic, weak) id<ALABorrowStateViewDelegate> delegate;

@property (nonatomic, strong) LSLoanDetailModel *loanDetailModel;

@end
