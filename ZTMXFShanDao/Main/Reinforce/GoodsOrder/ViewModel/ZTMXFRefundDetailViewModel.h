//
//  RefundDetailViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZTMXFRefundDetailInfoModel;

@protocol RefundDetailViewModelDelegate <NSObject>

/** 获取退款详情成功 */
- (void)requestRefundDetailSuccess:(ZTMXFRefundDetailInfoModel *)refundDetailInfoModel;

/** 申请撤销退款成功 */
- (void)requestCancelApplyRefundSuccess;

@end

@interface ZTMXFRefundDetailViewModel : NSObject

/** 获取退款详情 */
- (void)requestRefundDetailWithOrderId:(NSString *)orderId showLoad:(BOOL)showLoad;

/** 申请撤销退款 */
- (void)requestCancelApplyRefundWithRefundId:(NSString *)refundId;

@property (nonatomic, weak) id<RefundDetailViewModelDelegate> delegate;

@end
