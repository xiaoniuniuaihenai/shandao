//
//  ConfirmOrderViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ConfirmOrderViewModel.h"
#import "GoodsConfirmOrderInfoModel.h"
#import "GoodsConfirmOrderApi.h"
#import "GoodsSubmitOrderApi.h"

@implementation ConfirmOrderViewModel



/** 订单下单 */
- (void)requestSubmitOrderWithGoodsId:(NSString *)goodsId skuId:(NSString *)skuId goodsCount:(NSString *)goodsCount addressId:(NSString *)addressId{
    [SVProgressHUD showLoading];
    GoodsSubmitOrderApi *submitOrderApi = [[GoodsSubmitOrderApi alloc] initWithGoodsId:goodsId skuId:skuId goodsCount:goodsCount addressId:addressId];
    [submitOrderApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSString *orderId = [responseDict[@"data"][@"orderId"] description];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestSubmitOrderSuccess:)]) {
                [self.delegate requestSubmitOrderSuccess:orderId];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
/** 确认订单提交 */
- (void)requestConfirmOrderInfoWithGoodsId:(NSString *)goodsId skuId:(NSString *)skuId goodsCount:(NSString *)goodsCount{
    [SVProgressHUD showLoading];
    GoodsConfirmOrderApi *goodsDetialApi = [[GoodsConfirmOrderApi alloc] initWithGoodsId:goodsId skuId:skuId goodsCount:goodsCount];
    [goodsDetialApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            GoodsConfirmOrderInfoModel *confirmOrderInfoModel = [GoodsConfirmOrderInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestConfirmOrderInfoSuccess:)]) {
                [self.delegate requestConfirmOrderInfoSuccess:confirmOrderInfoModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
@end
