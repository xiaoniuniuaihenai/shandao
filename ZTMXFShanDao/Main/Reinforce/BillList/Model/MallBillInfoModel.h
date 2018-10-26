//
//  MallBillInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderInfoModel;
@class BorrowInfoModel;
@class OrderGoodsInfoModel;

@interface MallBillInfoModel : NSObject

/** 商品详情model */
@property (nonatomic, strong) OrderGoodsInfoModel *goodsInfo;
/** 账单详情model */
@property (nonatomic, strong) BorrowInfoModel *borrowInfo;
/** 账单分期列表model */
@property (nonatomic, strong) NSArray *billList;

@end

/**
 商品详情model
 */
@interface OrderInfoModel : NSObject

/** 商品名称 */
@property (nonatomic, copy) NSString *title;
/** 商品图片 */
@property (nonatomic, copy) NSString *goodsIcon;
/** 商品类型 */
@property (nonatomic, copy) NSString *propertyValueNames;
/** 商品数量 */
@property (nonatomic, assign) NSInteger count;
/** 商品原价 */
@property (nonatomic, assign) CGFloat priceAmount;
/** 商品售价 */
@property (nonatomic, assign) CGFloat actualAmount;

@end

/**
 借款详情model
 */
@interface BorrowInfoModel : NSObject

/** 借款ID */
@property (nonatomic, assign) long rid;
/** 应还款总额 */
@property (nonatomic, assign) CGFloat amount;
/** 借款本金 */
@property (nonatomic, assign) CGFloat borrowAmount;
/** 总共几期 */
@property (nonatomic, assign) NSInteger nper;
/** 逾期费 */
@property (nonatomic, assign) CGFloat overdueAmount;
/** 利息 */
@property (nonatomic, assign) CGFloat interest;
/** 借款编号 */
@property (nonatomic, copy) NSString *borrowNo;
/** 借款时间 */
@property (nonatomic, assign) long long gmtBorrow;

@end

@interface MallBillListModel : NSObject

/** 账单ID */
@property (nonatomic, assign) long rid;
/** 还款时间 */
@property (nonatomic, assign) long long gmtRepay;
/** 计划还款时间 */
@property (nonatomic, assign) long long gmtPlanRepay;
/** 账单金额 */
@property (nonatomic, assign) CGFloat billAmount;
/** 第几期 */
@property (nonatomic, assign) NSInteger billNper;
/** 总共几期 */
@property (nonatomic, assign) NSInteger nper;
/** 借款时间 */
@property (nonatomic, assign) long long gmtBorrow;
/** 逾期状态 1:逾期；0：未逾期 */
@property (nonatomic, assign) NSInteger overdueStatus;
/** 账单状态 0:代还款：1:还款成功：2:还款处理中 */
@property (nonatomic, assign) NSInteger status;
/** 本金 */
@property (nonatomic, assign) CGFloat billPrinciple;
/** 利息 */
@property (nonatomic, assign) CGFloat interest;
/** 手续费 */
@property (nonatomic, assign) CGFloat poundageAmount;
/** 逾期费 */
@property (nonatomic, assign) CGFloat overdueAmount;


@end

