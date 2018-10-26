//
//  ApplyRefundViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ApplyRefundInfoModel;

@protocol ApplyRefundViewModelDelegate <NSObject>

/** 获取申请退款页面信息成功 */
- (void)requestApplyRefundDataInfoSuccess:(ApplyRefundInfoModel *)applyRefundInfoModel;
/** 申请退款成功 */
- (void)requestApplyRefundSubmitSuccess;

@end

@interface ZTMXFApplyRefundViewModel : NSObject

/** 获取申请退款页面信息 */
- (void)requestApplyRefundDataInfoWithOrderId:(NSString *)orderId;
/** 提交申请退款 */
- (void)requestApplyRefundSubmitWithOrderId:(NSString *)orderId refundReason:(NSString *)refundReason refundDesc:(NSString *)refundDesc refundAmount:(NSString *)refundAmount latitude:(NSString *)latitudeString longitude:(NSString *)longitudeString;

@property (nonatomic, weak) id<ApplyRefundViewModelDelegate> delegate;

@end
