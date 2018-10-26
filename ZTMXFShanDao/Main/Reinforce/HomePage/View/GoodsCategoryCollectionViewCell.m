//
//  GoodsCategoryCollectionViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsCategoryCollectionViewCell.h"
#import "CategoryListModel.h"
#import "HomePageMallModel.h"
#import "UILabel+Attribute.h"
#import "UIImageView+OSS.h"
@interface GoodsCategoryCollectionViewCell ()

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UILabel *goodsPriceLabel;

@end

@implementation GoodsCategoryCollectionViewCell

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
}

#pragma mark - getter/setter
- (UIImageView *)goodsImageView{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.backgroundColor = [UIColor whiteColor];
        _goodsImageView.userInteractionEnabled = YES;
        _goodsImageView.clipsToBounds = YES;
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImageView;
}

- (UILabel *)goodsNameLabel{
    if (_goodsNameLabel == nil) {
        _goodsNameLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _goodsNameLabel.text = @"";
    }
    return _goodsNameLabel;
}
- (void)setupViews{
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.contentView addSubview:self.goodsPriceLabel];
}
- (UILabel *)goodsPriceLabel{
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [UILabel labelWithTitleColorStr:COLOR_RED_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _goodsPriceLabel.text = @"";
    }
    return _goodsPriceLabel;
}

//  设置分期分区页面数据
- (void)setCategoryGoodsInfoModel:(CategoryGoodsInfoModel *)categoryGoodsInfoModel{
    if (_categoryGoodsInfoModel != categoryGoodsInfoModel) {
        _categoryGoodsInfoModel = categoryGoodsInfoModel;
    }

    [self.goodsImageView sd_setImageFadeEffectWithURLstr:_categoryGoodsInfoModel.goodsIcon placeholderImage:@"placeholder_square"];

    UIFont *newFont = [UIFont systemFontOfSize:18];
    self.goodsNameLabel.text = [NSString stringWithFormat:@"%@", _categoryGoodsInfoModel.title];
    
    NSString *nperString = [NSString stringWithFormat:@"/%ld期",_categoryGoodsInfoModel.nper];
    NSString *monthPayStr = [NSString stringWithFormat:@"%.2f",_categoryGoodsInfoModel.monthPay];
    if (![LoginManager appReviewState]) {
        self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@%@", monthPayStr, nperString];
        [UILabel attributeWithLabel:self.goodsPriceLabel text:self.goodsPriceLabel.text textFont:12 attributes:@[monthPayStr] attributeFonts:@[newFont]];
    }
    CGFloat cellWidth  = self.bounds.size.width;
    self.goodsImageView.frame = CGRectMake(0.0, 0.0, cellWidth, cellWidth);
    self.goodsNameLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsImageView.frame) + 15.0, cellWidth, AdaptedHeight(15.0));
    self.goodsPriceLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsNameLabel.frame) + AdaptedHeight(5.0), cellWidth, 20.0);
}

//  设置商城首页Banner+商品模块 商品信息
- (void)setMallGoodsModel:(MallGoodsModel *)mallGoodsModel{
    if (_mallGoodsModel != mallGoodsModel) {
        _mallGoodsModel = mallGoodsModel;
    }
    
//    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_mallGoodsModel.goodsIcon]];
    NSString *placeholderImage = @"";
    if (mallGoodsModel.goodsCount == 1) {
        placeholderImage = @"banner_placeholder_180";
    } else if (mallGoodsModel.goodsCount == 2) {
        placeholderImage = @"goods_placeholder_2";
    } else if (mallGoodsModel.goodsCount >= 3) {
        placeholderImage = @"goods_placeholder_2";
    }
    [self.goodsImageView sd_setImageFadeEffectWithURLstr:_mallGoodsModel.goodsIcon placeholderImage:placeholderImage];

    UIFont *newFont = [UIFont systemFontOfSize:12];
    UIColor *newColor = [UIColor colorWithHexString:COLOR_LIGHT_STR];
    CGFloat orginalFontSize = 14;
    
    if (_mallGoodsModel.goodsCount >= 3) {
        newFont = [UIFont systemFontOfSize:10];
        orginalFontSize = 12;
    }
    
    NSString *goodsName = _mallGoodsModel.name;
    NSString *goodsRemark = _mallGoodsModel.remark;
    if (kStringIsEmpty(goodsName)) {
        goodsName = @"";
    }
    if (kStringIsEmpty(goodsRemark)) {
        goodsRemark = @"";
    }
    
    //  商品名称
    self.goodsNameLabel.text = [NSString stringWithFormat:@"%@ %@", goodsName, goodsRemark];
    if (!kStringIsEmpty(_mallGoodsModel.remark)) {
        [UILabel attributeWithLabel:self.goodsNameLabel text:self.goodsNameLabel.text textColor:COLOR_BLACK_STR attributesOriginalColorStrs:@[_mallGoodsModel.remark] attributeNewColors:@[newColor] textFont:orginalFontSize attributesOriginalFontStrs:@[_mallGoodsModel.remark] attributeNewFonts:@[newFont]];
    }
    //  商品价格
    NSString *nperString = [NSString stringWithFormat:@"/%ld期",_mallGoodsModel.nper];
//    [UILabel attributeWithLabel:self.goodsPriceLabel text:self.goodsPriceLabel.text textFont:orginalFontSize attributes:@[nperString] attributeFonts:@[newFont]];
    if (![LoginManager appReviewState]) {
        self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f%@", _mallGoodsModel.monthPay, nperString];
        [UILabel attributeWithLabel:self.goodsPriceLabel text:self.goodsPriceLabel.text textFont:orginalFontSize attributes:@[nperString] attributeFonts:@[newFont]];
    }

    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat leftMargin = AdaptedWidth(12.0);
    if (_mallGoodsModel.goodsCount == 1) {
        CGFloat goodsImageWidth = Main_Screen_Width - leftMargin * 2;
        CGFloat goodsImageHeight = goodsImageWidth * 135.0 / 351.0;
        self.goodsImageView.frame = CGRectMake(0.0, 0.0, viewWidth, goodsImageHeight);
        self.goodsNameLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsImageView.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(15.0));
        self.goodsPriceLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsNameLabel.frame) + AdaptedHeight(3.0), viewWidth, AdaptedHeight(20.0));
        self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    } else if (_mallGoodsModel.goodsCount == 2) {
        CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(2.0)) / 2.0;
        CGFloat goodsImageHeight = goodsImageWidth * 138.0 / 175.0;
        self.goodsImageView.frame = CGRectMake(0.0, 0.0, viewWidth, goodsImageHeight);
        self.goodsNameLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsImageView.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(15.0));
        self.goodsPriceLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsNameLabel.frame) + AdaptedHeight(3.0), viewWidth, AdaptedHeight(20.0));
        self.goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        self.goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    } else if (_mallGoodsModel.goodsCount == 3) {
        CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(30) * 2) / 3.0;
        CGFloat goodsImageHeight = goodsImageWidth;
        self.goodsImageView.frame = CGRectMake(0.0, 0.0, viewWidth, goodsImageHeight);
        self.goodsNameLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsImageView.frame) + AdaptedHeight(2.0), viewWidth, AdaptedHeight(15.0));
        self.goodsPriceLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsNameLabel.frame) + AdaptedHeight(2.0), viewWidth, AdaptedHeight(16.0));
        self.goodsNameLabel.textAlignment = NSTextAlignmentCenter;
        self.goodsPriceLabel.textAlignment = NSTextAlignmentCenter;
    } else if (_mallGoodsModel.goodsCount >= 4) {
        CGFloat goodsImageWidth = (Main_Screen_Width - leftMargin * 2 - AdaptedWidth(30) * 2) / 3.0;
        CGFloat goodsImageHeight = goodsImageWidth;
        self.goodsImageView.frame = CGRectMake(0.0, 0.0, viewWidth, goodsImageHeight);
        self.goodsNameLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsImageView.frame) + AdaptedHeight(2.0), viewWidth, AdaptedHeight(15.0));
        self.goodsPriceLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsNameLabel.frame) + AdaptedHeight(2.0), viewWidth, AdaptedHeight(16.0));
        self.goodsNameLabel.textAlignment = NSTextAlignmentCenter;
        self.goodsPriceLabel.textAlignment = NSTextAlignmentCenter;
    } else {
    }
}


@end
