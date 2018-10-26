//
//  GoodsDetailViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsDetailViewModel.h"
#import "GoodsDetailModel.h"
#import "GoodsSkuPropertyModel.h"

#import "GoodsDetailApi.h"
#import "GoodsPropertyListApi.h"

#import "ZTMXFConsumeGoodsInfoApi.h"

@implementation GoodsDetailViewModel

/** 获取商品详情信息 */
- (void)requestGoodsDetailInfoWithGoodsId:(NSString *)goodsId{
    [SVProgressHUD showLoading];
    GoodsDetailApi *goodsDetialApi = [[GoodsDetailApi alloc] initWithGoodsId:goodsId];
    [goodsDetialApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            GoodsDetailModel *goodsDetailModel = [GoodsDetailModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestGoodsDetailInfoSuccess:)]) {
                [self.delegate requestGoodsDetailInfoSuccess:goodsDetailModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


/** 商品详情添加事件 */
- (void)goodsDetailAddScanEventWithGoodsId:(NSString *)goodsId outType:(GoodsDetailOutType)outType{
    GoodsScanEventApi *goodsScanEventApi = [[GoodsScanEventApi alloc] initWithGoodsId:goodsId goodsDetailEvent:outType];
    goodsScanEventApi.isHideToast = YES;
    [goodsScanEventApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
        }
    } failure:^(__kindof YTKBaseRequest *request) {
    }];
}

/** 获取商品规格属性列表 */
- (void)requestGoodsSkuPropertyListWithGoodsId:(NSString *)goodsId{
    [SVProgressHUD showLoading];
    GoodsPropertyListApi *goodsPropertyApi = [[GoodsPropertyListApi alloc] initWithGoodsId:goodsId];
    [goodsPropertyApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            GoodsSkuPropertyModel *goodsSkuPropertyModel = [GoodsSkuPropertyModel mj_objectWithKeyValues:responseDict[@"data"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestGoodsSkuPropertyListSuccess:)]) {
                [self.delegate requestGoodsSkuPropertyListSuccess:goodsSkuPropertyModel];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
/** 获取消费贷商品详情 */
- (void)requestConsumeGoodsDetailInfoWithGoodsId:(NSString *)goodsId
{
    [SVProgressHUD showLoading];
    ZTMXFConsumeGoodsInfoApi *consumeGoodsInfoApi = [[ZTMXFConsumeGoodsInfoApi alloc] initWithGoodsId:goodsId];
    [consumeGoodsInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
    
}

@end
