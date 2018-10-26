//
//  OrderSubmitView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderSubmitViewDelegate <NSObject>

/** 点击提交订单 */
- (void)orderSubmitViewClickSubmitOrder;

@end

@interface OrderSubmitView : UIView

@property (nonatomic, weak) id<OrderSubmitViewDelegate> delegate;

/** 配置订单总额 */
- (void)configOrderTotalPrice:(NSString *)totalPrice;

@end
