//
//  OrderGoodsInfoView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderGoodsInfoView.h"
#import "OrderGoodsInfoModel.h"
#import "ApplyRefundGoodsInfoModel.h"

@interface OrderGoodsInfoView ()

/** 商品图片 */
@property (nonatomic, strong) UIImageView *goodsImageView;
/** 商品名 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/** 商品规格 */
@property (nonatomic, strong) UILabel *goodsPropertyLabel;
/** 商品原价 */
@property (nonatomic, strong) UILabel *goodsOriginalPriceLabel;
/** 商品原价上面细线 */
@property (nonatomic, strong) UIView *originalPriceLine;

/** 商品个数 */
@property (nonatomic, strong) UILabel *goodsCountLabel;
/** 底部细线 */
@property (nonatomic, strong) UIView *bottomLineView;

/** 透明按钮 */
@property (nonatomic, strong) UIButton *clearButton;

@end

@implementation OrderGoodsInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    /** 商品图片 */
    [self addSubview:self.goodsImageView];
    /** 商品名 */
    [self addSubview:self.goodsNameLabel];
    /** 商品规格 */
    [self addSubview:self.goodsPropertyLabel];
    /** 商品原价 */
    [self addSubview:self.goodsOriginalPriceLabel];
    /** 商品原价上面细线 */
    [self addSubview:self.originalPriceLine];
    /** 商品个数 */
    [self addSubview:self.goodsCountLabel];
    /** 细线 */
    [self addSubview:self.bottomLineView];
    /** 添加透明按钮 */
    [self addSubview:self.clearButton];
    
    //  默认隐藏
    self.goodsOriginalPriceLabel.hidden = YES;
    self.originalPriceLine.hidden = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    CGFloat leftMargin = AdaptedWidth(12.0);
    CGFloat topMargin = AdaptedHeight(10);
    CGFloat bottomMargin = AdaptedHeight(10.0);
    
    /** 商品图片 */
    CGFloat goodsImageViewW = viewHeight - topMargin - bottomMargin;
    self.goodsImageView.frame = CGRectMake(leftMargin, topMargin, goodsImageViewW, goodsImageViewW);
    /** 商品名 */
    self.goodsNameLabel.frame = CGRectMake(CGRectGetMaxX(self.goodsImageView.frame) + AdaptedWidth(14), CGRectGetMinY(self.goodsImageView.frame) + AdaptedHeight(10.0), viewWidth - CGRectGetMaxX(self.goodsImageView.frame) - 80.0, AdaptedHeight(22.0));
    /** 商品原价 */
    CGFloat goodsOriginalPriceLabelW = [self.goodsOriginalPriceLabel.text sizeWithFont:self.goodsOriginalPriceLabel.font maxW:MAXFLOAT].width;
    CGFloat goodsOriginalPriceLabelX = viewWidth - goodsOriginalPriceLabelW - leftMargin;
    self.goodsOriginalPriceLabel.frame = CGRectMake(goodsOriginalPriceLabelX, CGRectGetMinY(self.goodsNameLabel.frame), goodsOriginalPriceLabelW, AdaptedHeight(20.0));
    /** 商品原价上面细线 */
    CGFloat originalPriceLineW = goodsOriginalPriceLabelW;
    CGFloat originalPriceLineX = viewWidth - originalPriceLineW - leftMargin;
    self.originalPriceLine.frame = CGRectMake(originalPriceLineX, CGRectGetMinY(self.goodsOriginalPriceLabel.frame) + AdaptedHeight(10.0), originalPriceLineW, 1.0);
    /** 商品规格 */
    self.goodsPropertyLabel.frame = CGRectMake(CGRectGetMinX(self.goodsNameLabel.frame), CGRectGetMaxY(self.goodsNameLabel.frame) + AdaptedHeight(10.0), CGRectGetWidth(self.goodsNameLabel.frame), AdaptedHeight(20.0));
    /** 商品个数 */
    self.goodsCountLabel.frame = CGRectMake(viewWidth - leftMargin - 100.0, CGRectGetMinY(self.goodsPropertyLabel.frame), 100.0, CGRectGetHeight(self.goodsPropertyLabel.frame));
    /** 细线 */
    self.bottomLineView.frame = CGRectMake(leftMargin, viewHeight - 0.5, viewWidth - leftMargin, 0.5);
    /** 透明按钮 */
    self.clearButton.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
}

#pragma mark - getter/setter
/** 商品图片 */
- (UIImageView *)goodsImageView{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImageView.image = [UIImage imageNamed:@""];
        _goodsImageView.clipsToBounds = YES;
    }
    return _goodsImageView;
}
/** 商品名 */
- (UILabel *)goodsNameLabel{
    if (_goodsNameLabel == nil) {
        _goodsNameLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
        _goodsNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _goodsNameLabel.text = @"";
    }
    return _goodsNameLabel;
}
/** 商品规格 */
- (UILabel *)goodsPropertyLabel{
    if (_goodsPropertyLabel == nil) {
        _goodsPropertyLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _goodsPropertyLabel.text = @"";
    }
    return _goodsPropertyLabel;
}
/** 商品原价 */
- (UILabel *)goodsOriginalPriceLabel{
    if (_goodsOriginalPriceLabel == nil) {
        _goodsOriginalPriceLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:14 alignment:NSTextAlignmentRight];
        _goodsOriginalPriceLabel.text = @"";
    }
    return _goodsOriginalPriceLabel;
}
/** 商品原价上面细线 */
- (UIView *)originalPriceLine{
    if (_originalPriceLine == nil) {
        _originalPriceLine = [[UIView alloc] init];
        _originalPriceLine.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR];
    }
    return _originalPriceLine;
}
/** 商品个数 */
- (UILabel *)goodsCountLabel{
    if (_goodsCountLabel == nil) {
        _goodsCountLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentRight];
        _goodsCountLabel.text = @"";
    }
    return _goodsCountLabel;
}

/** 细线 */
- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _bottomLineView;
}

- (UIButton *)clearButton{
    if (_clearButton == nil) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearButton.backgroundColor = [UIColor clearColor];
        [_clearButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

/** 设置商品信息 */
- (void)setOrderGoodInfoModel:(OrderGoodsInfoModel *)orderGoodInfoModel{
    if (_orderGoodInfoModel != orderGoodInfoModel) {
        _orderGoodInfoModel = orderGoodInfoModel;
    }
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_orderGoodInfoModel.goodsIcon]];
    self.goodsNameLabel.text = _orderGoodInfoModel.title;
    self.goodsPropertyLabel.text = _orderGoodInfoModel.propertyValueNames;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld", _orderGoodInfoModel.count];
    
    /** 商品原价 */
//    if (_orderGoodInfoModel.priceAmount > 0) {
//        self.goodsOriginalPriceLabel.text =  [NSString stringWithFormat:@"￥%.2f", _orderGoodInfoModel.priceAmount];
//        self.goodsOriginalPriceLabel.hidden = NO;
//        self.originalPriceLine.hidden = NO;
//    } else {
        self.goodsOriginalPriceLabel.hidden = YES;
        self.originalPriceLine.hidden = YES;
//    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/** 设置申请退款页面商品信息Model */
- (void)setApplyRefundGoodsInfoModel:(ApplyRefundGoodsInfoModel *)applyRefundGoodsInfoModel{
    _applyRefundGoodsInfoModel = applyRefundGoodsInfoModel;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_applyRefundGoodsInfoModel.goodsIcon]];
    self.goodsNameLabel.text = _applyRefundGoodsInfoModel.title;
    self.goodsPropertyLabel.text = _applyRefundGoodsInfoModel.propertyValueNames;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld", _applyRefundGoodsInfoModel.count];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  点击按钮
- (void)clearButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderGoodsInfoViewClickGoodsDetail)]) {
        [self.delegate orderGoodsInfoViewClickGoodsDetail];
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
