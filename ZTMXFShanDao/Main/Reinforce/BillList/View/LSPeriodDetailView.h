//
//  LSPeriodDetailView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BorrowInfoModel;

@protocol PeriodDetailViewDelegete <NSObject>

@optional
/** 点击借款编号 */
- (void)clickBorrowNumber;

@end

@interface LSPeriodDetailView : UIView

@property (nonatomic, weak) id <PeriodDetailViewDelegete> delegete;

@property (nonatomic, strong) BorrowInfoModel *borrowInfoModel;

@end
