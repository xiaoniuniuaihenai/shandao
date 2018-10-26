//
//  ApplyRefundView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApplyRefundInfoModel;

@protocol ApplyRefundViewDelegate <NSObject>

/** 提交申请退款 */
- (void)applyRefundViewSubmitApplyRefundWithRefundCode:(NSString *)refundCode refundDesc:(NSString *)refundDesc refundAmount:(NSString *)refundAmount;

@end

@interface ZTMXFApplyRefundView : UIView
/** 退款页面Model */
@property (nonatomic, strong) ApplyRefundInfoModel *applyRefundInfoModel;

@property (nonatomic, weak) id<ApplyRefundViewDelegate> delegate;

@end
