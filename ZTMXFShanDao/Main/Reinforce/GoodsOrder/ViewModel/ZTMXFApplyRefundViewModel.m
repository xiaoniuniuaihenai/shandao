//
//  ApplyRefundViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFApplyRefundViewModel.h"
#import "ApplyRefundDataInfoApi.h"
#import "ApplyRefundSubmitApi.h"

#import "ApplyRefundInfoModel.h"

@implementation ZTMXFApplyRefundViewModel

/** 获取申请退款页面信息 */
- (void)requestApplyRefundDataInfoWithOrderId:(NSString *)orderId{
    [SVProgressHUD showLoading];
    ApplyRefundDataInfoApi *applyRefundDataInfoApi = [[ApplyRefundDataInfoApi alloc] initWithOrderId:orderId];
    [applyRefundDataInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            ApplyRefundInfoModel *applyRefundInfoModel = [ApplyRefundInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestApplyRefundDataInfoSuccess:)]) {
                [self.delegate requestApplyRefundDataInfoSuccess:applyRefundInfoModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


/** 提交申请退款 */
- (void)requestApplyRefundSubmitWithOrderId:(NSString *)orderId refundReason:(NSString *)refundReason refundDesc:(NSString *)refundDesc refundAmount:(NSString *)refundAmount latitude:(NSString *)latitudeString longitude:(NSString *)longitudeString{
    [SVProgressHUD showLoading];
    ApplyRefundSubmitApi *applyRefundSubmitApi = [[ApplyRefundSubmitApi alloc] initWithOrderId:orderId refundReason:refundReason refundDesc:refundDesc refundAmount:refundAmount latitude:latitudeString longitude:longitudeString];
    [applyRefundSubmitApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestApplyRefundSubmitSuccess)]) {
                [self.delegate requestApplyRefundSubmitSuccess];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];

}

@end
