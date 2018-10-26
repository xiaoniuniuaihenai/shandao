//
//  MyOrderCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderModel;

@protocol MyOrderCellDelegete <NSObject>

@optional
- (void)clickWriteAddress:(MyOrderModel *)myOrder;

@end

@interface MyOrderCell : UITableViewCell

@property (nonatomic, strong) MyOrderModel *orderModel;

@property (nonatomic, weak) id <MyOrderCellDelegete>delegete;

@end
