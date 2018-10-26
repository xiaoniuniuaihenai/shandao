//
//  OrderPaySuccessView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderPaySuccessViewDelegate <NSObject>

/** 返回首页 */
- (void)orderPaySuccessViewReturnHomePage;

/** 查看订单 */
- (void)orderPaySuccessViewCheckOrderDetail;

@end

@interface OrderPaySuccessView : UIView
/** 支付title */
@property (nonatomic, strong) UILabel *successTitleLabel;
/** 支付金额 */
@property (nonatomic, strong) UILabel *orderPriceLabel;

@property (nonatomic, weak) id<OrderPaySuccessViewDelegate> delegate;

@end
