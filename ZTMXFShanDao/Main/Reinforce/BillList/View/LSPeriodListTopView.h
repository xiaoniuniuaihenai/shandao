//
//  LSPeriodListTopView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPeriodNoDataView.h"
@class LSLoanListTopMenu;
@class LSPeriodBillModel;

@protocol LSPeriodListTopViewDelegete <NSObject>

@optional
- (void)clickTopMenu:(NSInteger)index;

@end

@interface LSPeriodListTopView : UIView

@property (nonatomic, assign) NSInteger tabNum;

@property (nonatomic, strong) LSPeriodBillModel *periodBillModel;

@property (nonatomic, weak) id <LSPeriodListTopViewDelegete> delegete;

@end
