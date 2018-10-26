//
//  LSPeriodDetailAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallBillListModel;

@interface LSPeriodDetailAlertView : UIView

@property (nonatomic, strong) MallBillListModel *mallListModel;

- (void)show;

@end
