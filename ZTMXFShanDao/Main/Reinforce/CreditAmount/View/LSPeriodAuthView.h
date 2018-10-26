//
//  LSPeriodAuthView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSCreditAuthModel;

@protocol PeriodAuthViewDelegete <NSObject>

@optional
/** 点击认证类型 */
- (void)clickPeriodAuthWithType:(LoanType)periodAuthType;

/** 点击慢必赔 */
- (void)submitConsumeLoanViewClickSlowPay;

@end

@interface LSPeriodAuthView : UIView

@property (nonatomic, weak) id <PeriodAuthViewDelegete> delegete;

@property (nonatomic, strong) LSCreditAuthModel *creditAuthModel;

@end
