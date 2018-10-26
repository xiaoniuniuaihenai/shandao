//
//  LSInstallmentView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSInstallmentViewDelegete <NSObject>

@optional
/** 点击跳转到分期账单页 */
- (void)jumpToBillPeriodsVC;

@end

@interface LSInstallmentView : UIView

/** 账单日 */
@property (nonatomic, strong) UILabel *returnTimeLabel;
/** 本期应还(元) */
@property (nonatomic, strong) UILabel *nowReturnMoneyLabel;
/** 剩余应还(元) */
@property (nonatomic, strong) UILabel *residueReturnMoneyLabel;

@property (nonatomic, weak) id <LSInstallmentViewDelegete> delegete;

@end
