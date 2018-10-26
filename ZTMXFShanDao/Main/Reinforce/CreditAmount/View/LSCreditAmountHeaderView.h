//
//  LSCreditAmountHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAmountPageModel;
@class LSCreditAuthModel;

@interface LSCreditAmountHeaderView : UIView

/** 额度页面数据Model */
@property (nonatomic, strong) LSAmountPageModel *amountPageModel;

@property (nonatomic, strong) LSCreditAuthModel *creditAuthModel;

//  开始刻度动画
- (void)startCreditProgressAnimation;

@end
