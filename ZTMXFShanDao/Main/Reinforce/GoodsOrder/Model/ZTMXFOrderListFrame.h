//
//  OrderListFrame.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderListModel;

@interface ZTMXFOrderListFrame : NSObject

@property (nonatomic, strong) OrderListModel *orderListModel;
/** 按钮背景View */
@property (nonatomic, assign) CGFloat buttonBgViewHeight;

@property (nonatomic, assign) CGFloat cellHeight;

@end
