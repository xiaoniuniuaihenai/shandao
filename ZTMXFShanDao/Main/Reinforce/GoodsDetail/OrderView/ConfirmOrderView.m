//
//  ConfirmOrderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ConfirmOrderView.h"
#import "AddressInfoView.h"
#import "OrderGoodsInfoView.h"
#import "ALATitleValueCellView.h"
#import "OrderSubmitView.h"
#import "LSAddressModel.h"
#import "GoodsConfirmOrderInfoModel.h"

@interface ConfirmOrderView ()<AddressInfoViewDelegate, OrderSubmitViewDelegate>

/** 地址 */
@property (nonatomic, strong) AddressInfoView      *addressView;
/** 商品信息 */
@property (nonatomic, strong) OrderGoodsInfoView    *goodsInfoView;
/** 商品总价 */
@property (nonatomic, strong) ALATitleValueCellView *goodsPriceView;
/** 优惠券 */
@property (nonatomic, strong) ALATitleValueCellView *couponView;
/** 订单总额 */
@property (nonatomic, strong) ALATitleValueCellView *orderPriceView;
/** 提交订单view */
@property (nonatomic, strong) OrderSubmitView       *submitView;

@end

@implementation ConfirmOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    /** 地址 */
    [self addSubview:self.addressView];
    /** 商品信息 */
    [self addSubview:self.goodsInfoView];
    /** 商品总价 */
    [self addSubview:self.goodsPriceView];
    /** 优惠券 */
    [self addSubview:self.couponView];
    /** 订单总额 */
    [self addSubview:self.orderPriceView];
    /** 提交订单view */
    [self addSubview:self.submitView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    /** 地址 */
    self.addressView.frame = CGRectMake(0.0, AdaptedHeight(10.0), viewWidth, AdaptedHeight(84.0));
    /** 商品信息 */
    self.goodsInfoView.frame = CGRectMake(0.0, CGRectGetMaxY(self.addressView.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(90.0));
    /** 商品总价 */
    self.goodsPriceView.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsInfoView.frame), viewWidth, AdaptedHeight(49.0));
    /** 优惠券 */
    self.couponView.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsPriceView.frame), viewWidth, AdaptedHeight(49.0));
    /** 订单总额 */
    self.orderPriceView.frame = CGRectMake(0.0, CGRectGetMaxY(self.couponView.frame), viewWidth, AdaptedHeight(49.0));
    /** 提交订单view */
    self.submitView.frame = CGRectMake(0.0, viewHeight - AdaptedHeight(49.0) - TabBar_Addition_Height, viewWidth, AdaptedHeight(49.0));
}

#pragma mark - setter/getter
/** 地址 */
- (AddressInfoView *)addressView{
    if (_addressView == nil) {
        _addressView = [[AddressInfoView alloc] init];
//        _addressView.backgroundColor = [UIColor whiteColor];
        _addressView.delegate = self;
    }
    return _addressView;
}
/** 商品信息 */
- (OrderGoodsInfoView *)goodsInfoView{
    if (_goodsInfoView == nil) {
        _goodsInfoView = [[OrderGoodsInfoView alloc] init];
        _goodsInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _goodsInfoView;
}
/** 商品总价 */
- (ALATitleValueCellView *)goodsPriceView{
    if (_goodsPriceView == nil) {
        _goodsPriceView = [[ALATitleValueCellView alloc] initWithTitle:@"商品总额" value:@"9680" target:nil action:nil];
        _goodsPriceView.backgroundColor = [UIColor whiteColor];
        _goodsPriceView.titleColorStr = COLOR_BLACK_STR;
        _goodsPriceView.valueColorStr = COLOR_LIGHT_GRAY_STR;
        _goodsPriceView.titleFont = [UIFont systemFontOfSize:14];
        _goodsPriceView.valueFont = [UIFont systemFontOfSize:14];
        _goodsPriceView.showRowImageView = NO;
        _goodsPriceView.showBottomLineView = YES;
        _goodsPriceView.showMarginBottomLineView = YES;
    }
    return _goodsPriceView;
}

/** 优惠券 */
- (ALATitleValueCellView *)couponView{
    if (_couponView == nil) {
        _couponView = [[ALATitleValueCellView alloc] initWithTitle:@"优惠券" value:@"无优惠券" target:self action:@selector(couponViewAction)];
        _couponView.backgroundColor = [UIColor whiteColor];
        _couponView.titleColorStr = COLOR_BLACK_STR;
        _couponView.valueColorStr = COLOR_LIGHT_GRAY_STR;
        _couponView.titleFont = [UIFont systemFontOfSize:14];
        _couponView.valueFont = [UIFont systemFontOfSize:14];
        _couponView.showBottomLineView = YES;
    }
    return _couponView;
}
/** 订单总额 */
- (ALATitleValueCellView *)orderPriceView{
    if (_orderPriceView == nil) {
        _orderPriceView = [[ALATitleValueCellView alloc] initWithTitle:@"订单总额" value:@"9680" target:nil action:nil];
        _orderPriceView.backgroundColor = [UIColor whiteColor];
        _orderPriceView.titleColorStr = COLOR_BLACK_STR;
        _orderPriceView.valueColorStr = COLOR_RED_STR;
        _orderPriceView.titleFont = [UIFont systemFontOfSize:14];
        _orderPriceView.valueFont = [UIFont systemFontOfSize:14];
        _orderPriceView.showRowImageView = NO;
        _orderPriceView.showBottomLineView = NO;
    }
    return _orderPriceView;
}
/** 提交订单view */
- (OrderSubmitView *)submitView{
    if (_submitView == nil) {
        _submitView = [[OrderSubmitView alloc] init];
        _submitView.backgroundColor = [UIColor whiteColor];
        _submitView.delegate = self;
    }
    return _submitView;
}

/** 设置页面信息 */
- (void)setConfirmOrderInfoModel:(GoodsConfirmOrderInfoModel *)confirmOrderInfoModel{
    if (_confirmOrderInfoModel != confirmOrderInfoModel) {
        _confirmOrderInfoModel = confirmOrderInfoModel;
    }
    
    //  设置地址信息
    if (_confirmOrderInfoModel.address.addressId <= 0) {
        //  没有添加地址
        [self configShowAddressView:NO];
    } else {
        //  有添加地址
        [self configShowAddressView:YES];
        [self configAddressInfo:_confirmOrderInfoModel.address];
    }
    
    //  设置商品信息
    [self configGoodsInfo:_confirmOrderInfoModel.goodsInfo];
    
    //  商品总价
    self.goodsPriceView.valueStr = [NSString stringWithFormat:@"￥%.2f", _confirmOrderInfoModel.totalAmount];
    //  订单总价
    self.orderPriceView.valueStr = [NSString stringWithFormat:@"￥%.2f", _confirmOrderInfoModel.totalAmount];

    //  订单总额
    [self.submitView configOrderTotalPrice:[NSString stringWithFormat:@"%.2f", _confirmOrderInfoModel.totalAmount]];
}

#pragma mark - 代理方法
/** 选择地址 */
- (void)addressInfoViewChoiseAddress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderViewChoiseAddress)]) {
        [self.delegate confirmOrderViewChoiseAddress];
    }
}

/** 添加地址 */
- (void)addressInfoViewAddAddress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderViewAddAddress)]) {
        [self.delegate confirmOrderViewAddAddress];
    }
}

/** 点击提交订单 */
- (void)orderSubmitViewClickSubmitOrder{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderViewClickSubmitOrder)]) {
        [self.delegate confirmOrderViewClickSubmitOrder];
    }
}

/** 点击优惠券 */
- (void)couponViewAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderViewChoiseCoupon)]) {
        [self.delegate confirmOrderViewChoiseCoupon];
    }
}

#pragma mark - 私有方法
/** 显示地址还是显示添加地址 */
- (void)configShowAddressView:(BOOL)showAddress{
    if (showAddress) {
        self.addressView.showAddress = YES;
    } else {
        self.addressView.showAddress = NO;
    }
}

/** 配置地址 */
- (void)configAddressInfo:(LSAddressModel *)addressModel{
    if (addressModel) {
        self.addressView.addressModel = addressModel;
    }
}

/** 配置商品信息 */
- (void)configGoodsInfo:(OrderGoodsInfoModel *)orderGoodsInfoModel{
    if (orderGoodsInfoModel) {
        self.goodsInfoView.orderGoodInfoModel = orderGoodsInfoModel;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
