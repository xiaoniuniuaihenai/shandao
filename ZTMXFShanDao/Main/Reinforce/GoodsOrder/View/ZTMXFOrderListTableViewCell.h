//
//  OrderListTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderListModel;
@class ZTMXFOrderListFrame;

@protocol OrderListViewDelegate <NSObject>

#pragma mark 商城订单
/** 去付款 */
- (void)orderListViewClickPay:(OrderListModel *)orderListModel;
/** 取消订单 */
- (void)orderListViewClickCancelOrder:(OrderListModel *)orderListModel;
/** 申请退款 */
- (void)orderListViewClickApplyRefund:(OrderListModel *)orderListModel;
/** 查看退款详情 */
- (void)orderListViewClickViewRefundDetail:(OrderListModel *)orderListModel;
/** 确认收货 */
- (void)orderListViewClickConfirmReceive:(OrderListModel *)orderListModel;
/** 查看物流 */
- (void)orderListViewClickViewLogistics:(OrderListModel *)orderListModel;
/** 重新购买 */
- (void)orderListViewClickViewRepayMobile:(OrderListModel *)orderListModel;

#pragma mark 消费贷订单
/** 填写地址 */
- (void)orderListViewClickWriteAddress:(OrderListModel *)orderListModel;

@end

@interface ZTMXFOrderListTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) OrderListModel *orderListModel;
@property (nonatomic, strong) ZTMXFOrderListFrame *orderListFrame;

@property (nonatomic, weak) id<OrderListViewDelegate> delegate;

@end
