//
//  GoodsInfoView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderDetailModel;
@class GoodsInfoModel;

typedef NS_ENUM(NSInteger,LSGoodsInfoType) {
    LSGoodsInfoLoanType,  //确认借钱
    LSGoodsInfoOrderType  //订单详情
};

@protocol GoodsInfoDelegete <NSObject>

@optional
- (void)clickGoodsDetailButton;

@end

@interface GoodsInfoView : UIView

@property (nonatomic, strong) MyOrderDetailModel *orderDetailModel;

@property (nonatomic, strong) GoodsInfoModel *goodsInfoModel;

@property (nonatomic, assign) LSGoodsInfoType goodsInfoType;

@property (nonatomic, weak) id <GoodsInfoDelegete> delegete;

@end
