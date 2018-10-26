//
//  OrderDetailHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderDetailHeaderView.h"
#import "OrderStatusView.h"
#import "AddressInfoView.h"
#import "OrderGoodsInfoView.h"
#import "OrderDetailInfoModel.h"
#import "LSAddressModel.h"
#import "OrderGoodsInfoModel.h"
#import "MyOrderModel.h"

@interface ZTMXFOrderDetailHeaderView ()<OrderStatusViewDelegate, AddressInfoViewDelegate, OrderGoodsInfoViewDelegate>
/** 订单状态 */
@property (nonatomic, strong) OrderStatusView *statusView;
/** 地址view */
@property (nonatomic, strong) AddressInfoView *addressView;
/** 商品信息view */
@property (nonatomic, strong) OrderGoodsInfoView *goodsInfoView;

@end

@implementation ZTMXFOrderDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
//    CGFloat viewHeight = self.bounds.size.height;
 
    /** 订单状态 */
    self.statusView.frame = CGRectMake(0.0, 0.0, viewWidth, AdaptedHeight(80.0));
    /** 地址view */
    self.addressView.frame = CGRectMake(0.0, CGRectGetMaxY(self.statusView.frame), viewWidth, AdaptedHeight(80.0));
    /** 商品信息view */
    if (self.isHiddenAddressView) {
        self.goodsInfoView.frame = CGRectMake(0.0, CGRectGetMaxY(self.statusView.frame), viewWidth, AdaptedHeight(90.0));
    } else {
        self.goodsInfoView.frame = CGRectMake(0.0, CGRectGetMaxY(self.addressView.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(90.0));
    }
    
    self.height = CGRectGetMaxY(self.goodsInfoView.frame);
}



- (void)setupViews{
    /** 订单状态 */
    [self addSubview:self.statusView];
    /** 地址view */
    [self addSubview:self.addressView];
    /** 商品信息view */
    [self addSubview:self.goodsInfoView];
}
/** 订单状态 */
- (OrderStatusView *)statusView{
    if (_statusView == nil) {
        _statusView = [[OrderStatusView alloc] init];
        _statusView.delegate = self;
        _statusView.backgroundColor = K_MainColor;
    }
    return _statusView;
}

/** 地址view */
- (AddressInfoView *)addressView{
    if (_addressView == nil) {
        _addressView = [[AddressInfoView alloc] init];
        _addressView.backgroundColor = [UIColor whiteColor];
        _addressView.delegate = self;
    }
    return _addressView;
}

/** 商品信息view */
- (OrderGoodsInfoView *)goodsInfoView{
    if (_goodsInfoView == nil) {
        _goodsInfoView = [[OrderGoodsInfoView alloc] init];
        _goodsInfoView.backgroundColor = [UIColor whiteColor];
        _goodsInfoView.delegate = self;
    }
    return _goodsInfoView;
}

#pragma mark - OrderStatusViewDelegate
/** 查看退款详情 */
- (void)orderStatusViewRefundDetail{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailHeaderViewRefundDetail)]) {
        [self.delegate orderDetailHeaderViewRefundDetail];
    }
}

#pragma mark - 设置页面数据
/** 商城订单详情Model */
- (void)setOrderDetailInfoModel:(OrderDetailInfoModel *)orderDetailInfoModel{
    if (_orderDetailInfoModel != orderDetailInfoModel) {
        _orderDetailInfoModel = orderDetailInfoModel;
    }
    
    //  设置状态view数据
    self.statusView.orderDetailInfoModel = _orderDetailInfoModel;
    
    //  地址数据
    LSAddressModel *addressModel = [[LSAddressModel alloc] init];
    addressModel.consignee = _orderDetailInfoModel.consignee;
    addressModel.consigneeMobile = _orderDetailInfoModel.mobile;
    addressModel.detailAddress = _orderDetailInfoModel.address;
    self.addressView.addressModel = addressModel;
    [self.addressView showRowButtonView:NO];
    
    //  设置商品数据
    self.goodsInfoView.orderGoodInfoModel = _orderDetailInfoModel.goodsInfo;
}

/** 消费贷订单详情Model */
- (void)setLoanOrderDetailModel:(MyOrderDetailModel *)loanOrderDetailModel{
    if (loanOrderDetailModel) {
        _loanOrderDetailModel = loanOrderDetailModel;
        
        //  设置状态view数据
        self.statusView.loanOrderDetailModel = _loanOrderDetailModel;
        //  地址数据
        if (kStringIsEmpty(_loanOrderDetailModel.consigneeMobile)) {
            //  没有添加地址
            [self.addressView setShowAddress:NO];
        } else {
            [self.addressView setShowAddress:YES];
            [self.addressView showRowButtonView:NO];
            //  添加了地址
            LSAddressModel *addressModel = [[LSAddressModel alloc] init];
            addressModel.consignee = _loanOrderDetailModel.consignee;
            addressModel.consigneeMobile = _loanOrderDetailModel.consigneeMobile;
            addressModel.detailAddress = _loanOrderDetailModel.address;
            self.addressView.addressModel = addressModel;
        }
        //  设置商品数据
        OrderGoodsInfoModel *goodsInfoModel = [[OrderGoodsInfoModel alloc] init];
        goodsInfoModel.goodsIcon = _loanOrderDetailModel.url;
        goodsInfoModel.title = _loanOrderDetailModel.name;
        goodsInfoModel.propertyValueNames = @"";
        goodsInfoModel.count = 1;
        goodsInfoModel.priceAmount = [_loanOrderDetailModel.originPrice doubleValue];
        self.goodsInfoView.orderGoodInfoModel = goodsInfoModel;;
    }
}

- (void)setIsHiddenAddressView:(BOOL)isHiddenAddressView{
    _isHiddenAddressView = isHiddenAddressView;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - AddressInfoViewDelegate
/** 添加地址 */
- (void)addressInfoViewAddAddress{
    //  添加地址
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailHeaderViewAddAddress)]) {
        [self.delegate orderDetailHeaderViewAddAddress];
    }
}

#pragma mark - OrderGoodsInfoViewDelegate
/** 查看商品详情 */
- (void)orderGoodsInfoViewClickGoodsDetail{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailHeaderViewGoodsDetail)]) {
        [self.delegate orderDetailHeaderViewGoodsDetail];
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
