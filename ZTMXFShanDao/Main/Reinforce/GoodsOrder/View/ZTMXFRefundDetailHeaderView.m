//
//  RefundDetailHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFRefundDetailHeaderView.h"
#import "OrderStatusView.h"
#import "OrderGoodsInfoView.h"
#import "ZTMXFRefundDetailInfoModel.h"

@interface ZTMXFRefundDetailHeaderView ()
/** 订单状态 */
@property (nonatomic, strong) OrderStatusView *statusView;
/** 商品信息view */
@property (nonatomic, strong) OrderGoodsInfoView *goodsInfoView;

@end

@implementation ZTMXFRefundDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    
    /** 订单状态 */
    self.statusView.frame = CGRectMake(0.0, 0.0, viewWidth, AdaptedHeight(100.0));
    /** 商品信息view */
    self.goodsInfoView.frame = CGRectMake(0.0, CGRectGetMaxY(self.statusView.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(90.0));
}

/** 订单状态 */
- (OrderStatusView *)statusView{
    if (_statusView == nil) {
        _statusView = [[OrderStatusView alloc] init];
        _statusView.backgroundColor = [UIColor orangeColor];
    }
    return _statusView;
}
- (void)setupViews{
    /** 订单状态 */
    [self addSubview:self.statusView];
    /** 商品信息view */
    [self addSubview:self.goodsInfoView];
}
/** 商品信息view */
- (OrderGoodsInfoView *)goodsInfoView{
    if (_goodsInfoView == nil) {
        _goodsInfoView = [[OrderGoodsInfoView alloc] init];
        _goodsInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _goodsInfoView;
}

//  设置页面数据
- (void)setRefundDetailInfoModel:(ZTMXFRefundDetailInfoModel *)refundDetailInfoModel{
    if (refundDetailInfoModel) {
        _refundDetailInfoModel = refundDetailInfoModel;
        //  设置状态数据
        _statusView.refundDetailInfoModel = refundDetailInfoModel;
        //  设置商品信息
        _goodsInfoView.applyRefundGoodsInfoModel = _refundDetailInfoModel.goodsInfo;
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
