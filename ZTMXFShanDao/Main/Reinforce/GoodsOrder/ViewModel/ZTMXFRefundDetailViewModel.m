//
//  RefundDetailViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFRefundDetailViewModel.h"
#import "RefundDetailInfoApi.h"
#import "ZTMXFRefundDetailInfoModel.h"
#import "CancelRefundApi.h"

@implementation ZTMXFRefundDetailViewModel

/** 获取商品详情信息 */
- (void)requestRefundDetailWithOrderId:(NSString *)orderId showLoad:(BOOL)showLoad{
    if (showLoad) {
        [SVProgressHUD showLoading];
    }
    RefundDetailInfoApi *refundDetailInfoApi = [[RefundDetailInfoApi alloc] initWithOrderId:orderId];
    [refundDetailInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            ZTMXFRefundDetailInfoModel *refundDetailInfoModel = [ZTMXFRefundDetailInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestRefundDetailSuccess:)]) {
                [self.delegate requestRefundDetailSuccess:refundDetailInfoModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}



/** 申请撤销退款 */
- (void)requestCancelApplyRefundWithRefundId:(NSString *)refundId{
    [SVProgressHUD showLoading];
    CancelRefundApi *cancelRefundApi = [[CancelRefundApi alloc] initWithRefundId:refundId];
    [cancelRefundApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestCancelApplyRefundSuccess)]) {
                [self.delegate requestCancelApplyRefundSuccess];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


@end
