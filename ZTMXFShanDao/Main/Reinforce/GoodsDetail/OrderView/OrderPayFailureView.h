//
//  OrderPayFailureView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderPayFailureViewDelegate <NSObject>

/** 返回首页 */
- (void)orderPayFailureViewReturnHomePage;

/** 查看订单 */
- (void)orderPayFailureViewCheckOrderDetail;

@end

@interface OrderPayFailureView : UIView
/** 失败title */
@property (nonatomic, strong) UILabel *failureTitleLabel;
/** 失败描述 */
@property (nonatomic, strong) UILabel *failureDescrition;

@property (nonatomic, weak) id<OrderPayFailureViewDelegate> delegate;

@end
