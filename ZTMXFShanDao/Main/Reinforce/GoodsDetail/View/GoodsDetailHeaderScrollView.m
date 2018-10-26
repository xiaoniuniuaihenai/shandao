//
//  GoodsDetailHeaderScrollView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailHeaderScrollView.h"
#import "SDCycleScrollView.h"
#import "GoodsDetailModel.h"
#import "ALATitleValueCellView.h"
#import "ZTMXFLeftImageLabel.h"
#import "UIButton+JKImagePosition.h"
#import "UILabel+Attribute.h"
@interface GoodsDetailHeaderScrollView ()<SDCycleScrollViewDelegate>
/** 轮播图 */
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView            *pageView;
/** 当前页label */
@property (nonatomic, strong) UILabel           *pageLabel;

/** 商品名 */
@property (nonatomic, strong) UILabel           *goodsNameLabel;
/** 商品价格 */
@property (nonatomic, strong) UILabel           *goodsPriceLabel;
/** 细线 */
@property (nonatomic, strong) UIView            *lineView;
/** 选择规格及数量背景view */
@property (nonatomic, strong) ALATitleValueCellView *propertyView;
/** 间隔view */
@property (nonatomic, strong) UIView            *gapView;
/** 特性view */
@property (nonatomic, strong) UIView            *featureView;
/** 正品保证 */
@property (nonatomic, strong) ZTMXFLeftImageLabel    *featureOneLabel;
/** featureLineOne */
@property (nonatomic, strong) UIView *featureLineOne;
/** 顺丰包邮 */
@property (nonatomic, strong) ZTMXFLeftImageLabel    *featureTwoLabel;
/** featureLineTwo */
@property (nonatomic, strong) UIView *featureLineTwo;
/** 无理由退换 */
@property (nonatomic, strong) ZTMXFLeftImageLabel    *featureThreeLabel;

/** 间隔商品详情图片 */
@property (nonatomic, strong) UIImageView       *gapGoodsPictureImageView;
@property (nonatomic, strong) UIImageView       *goodsDetailIconImageView;

/** 轮播图片数组 */
@property (nonatomic, strong) NSMutableArray    *cycleImageModelArray;

@end

@implementation GoodsDetailHeaderScrollView

- (NSMutableArray *)cycleImageModelArray
{
    if (_cycleImageModelArray == nil) {
        _cycleImageModelArray = [NSMutableArray array];
    }
    return _cycleImageModelArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    //  添加轮播图
    [self addSubview:self.cycleScrollView];
    [self.cycleScrollView addSubview:self.pageView];
    [self.cycleScrollView addSubview:self.pageLabel];
    
    /** 商品名称 */
    [self addSubview:self.goodsNameLabel];
    /** 商品价格 */
    [self addSubview:self.goodsPriceLabel];
    /** 细线 */
    [self addSubview:self.lineView];
    /** 选择规格及数量背景view */
    [self addSubview:self.propertyView];
    /** 间隔view */
    [self addSubview:self.gapView];
//    /** 特性view */
    [self addSubview:self.featureView];
//    /** 正品保证 */
//    [self.featureView addSubview:self.featureOneLabel];
//    /** 顺丰包邮 */
//    [self.featureView addSubview:self.featureTwoLabel];
//    /** 无理由退换 */
//    [self.featureView addSubview:self.featureThreeLabel];
//    [self.featureView addSubview:self.featureLineOne];
//    [self.featureView addSubview:self.featureLineTwo];
    NSArray * titles = @[@"正品保障",@"租期灵活",@"服务贴心",@"顺丰包邮"];
    NSArray * imgs = @[@"feature_one_icon",@"feature_one_icon",@"feature_one_icon",@"feature_one_icon"];
    for (int i = 0; i < titles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * KW / 4.0, 0, KW / 4.0, 70 * PX);
        [btn setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        [btn setTitleColor:K_666666 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_Regular(12 * PX);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [self.featureView addSubview:btn];
        [btn jk_setImagePosition:LXMImagePositionTop spacing:3];

        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(btn.left - 1, 15 * PX, 1, 40 * PX)];
        [self.featureView addSubview:line];
        line.backgroundColor = COLOR_SRT(@"#EDEFF0");
        
    }

    /** 间隔商品详情图片 */
    [self addSubview:self.gapGoodsPictureImageView];
    [self.gapGoodsPictureImageView addSubview:self.goodsDetailIconImageView];
}




-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect cycleScrollViewRect = CGRectMake(0.0 ,0.0, Main_Screen_Width, Main_Screen_Width);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:cycleScrollViewRect delegate:self placeholderImage:[UIImage imageNamed:@"placeholder_square"]];
        [_cycleScrollView setBackgroundColor:[UIColor whiteColor]];
        _cycleScrollView.autoScrollTimeInterval = 5;
        //设置轮播视图的分页控件的显示
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.layer.shadowColor = [UIColor blackColor].CGColor;
        _cycleScrollView.layer.shadowOffset = CGSizeMake(0,0);
        _cycleScrollView.layer.shadowOpacity = 0.2;
        _cycleScrollView.layer.shadowRadius = 3.0;
    }
    return _cycleScrollView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = AdaptedWidth(12.0);
    
    /** 轮播图 */
    self.cycleScrollView.frame = CGRectMake(0.0 ,0.0, Main_Screen_Width, Main_Screen_Width);
    CGFloat pageLabelW = AdaptedWidth(40.0);
    CGFloat pageLabelH = AdaptedWidth(20.0);
    self.pageLabel.frame = CGRectMake(Main_Screen_Width - pageLabelW - AdaptedWidth(14.0), CGRectGetHeight(self.cycleScrollView.frame) - AdaptedHeight(20) - pageLabelH, pageLabelW, pageLabelH);
    self.pageView.frame = self.pageLabel.frame;
    
    /** 商品名 */
    CGFloat goodsNameLabelW = Main_Screen_Width - leftMargin * 2;
    CGFloat goodsNameLabelH = [self.goodsNameLabel.text sizeWithFont:self.goodsNameLabel.font maxW:goodsNameLabelW].height;
    self.goodsNameLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.cycleScrollView.frame) + AdaptedHeight(15.0), goodsNameLabelW, goodsNameLabelH);
    /** 商品价格 */
    self.goodsPriceLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.goodsNameLabel.frame), Main_Screen_Width, AdaptedHeight(46.0));
    /** 细线 */
    self.lineView.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.goodsPriceLabel.frame), Main_Screen_Width - leftMargin, 0.5);
    /** 选择规格及数量背景view */
    self.propertyView.frame = CGRectMake(0.0, CGRectGetMaxY(self.lineView.frame), Main_Screen_Width, AdaptedHeight(49.0));
    /** 间隔view */
    self.gapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.propertyView.frame), Main_Screen_Width, AdaptedHeight(10.0));
    /** 特性view */
    self.featureView.frame = CGRectMake(0.0, CGRectGetMaxY(self.gapView.frame), Main_Screen_Width, AdaptedHeight(70.0));
    //    /** 正品保证 */
    //    CGFloat featureLabelW = Main_Screen_Width / 3.0;
    //    CGFloat featureLableH = AdaptedHeight(18.0);
    //    CGFloat featureLabelY = (CGRectGetHeight(self.featureView.frame) - featureLableH) / 2.0;
    //
    //    self.featureOneLabel.frame = CGRectMake(AdaptedWidth(15.0), featureLabelY, featureLabelW - AdaptedWidth(15.0), featureLableH);
    //    /** 顺丰包邮 */
    //    self.featureTwoLabel.frame = CGRectMake(CGRectGetMaxX(self.featureOneLabel.frame), featureLabelY, featureLabelW, featureLableH);
    //    /** 无理由退换 */
    //    self.featureThreeLabel.frame = CGRectMake(CGRectGetMaxX(self.featureTwoLabel.frame), featureLabelY, featureLabelW - AdaptedWidth(15.0), featureLableH);
    //    CGFloat featureLineW = 1.0;
    //    CGFloat featureLineH = 12.0;
    //    CGFloat featureLineY = (CGRectGetHeight(self.featureView.frame) - featureLineH) / 2.0;
    //    self.featureLineOne.frame = CGRectMake(CGRectGetMaxX(self.featureOneLabel.frame), featureLineY, featureLineW, featureLineH);
    //    self.featureLineTwo.frame = CGRectMake(CGRectGetMaxX(self.featureTwoLabel.frame), featureLineY, featureLineW, featureLineH);
    
    
    /** 间隔商品详情图片 */
    self.gapGoodsPictureImageView.frame = CGRectMake(0.0, CGRectGetMaxY(self.featureView.frame), Main_Screen_Width, AdaptedHeight(40.0));
    self.goodsDetailIconImageView.frame = CGRectMake((Main_Screen_Width - 42.0) / 2.0, 0.0, 42.0, CGRectGetHeight(self.gapGoodsPictureImageView.frame));
    
    //  设置总的高度
    self.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, CGRectGetMaxY(self.gapGoodsPictureImageView.frame));
}
/** pageView */
- (UIView *)pageView{
    if (_pageView == nil) {
        _pageView = [[UIView alloc] init];
        _pageView.backgroundColor = K_888888;
        _pageView.layer.cornerRadius = 10.0;
        _pageView.alpha = 0.6;
        _pageView.clipsToBounds = YES;
        _pageView.hidden = YES;
    }
    return _pageView;
}

/** pageLabel */
- (UILabel *)pageLabel{
    if (_pageLabel == nil) {
        _pageLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:10 alignment:NSTextAlignmentCenter];
        _pageLabel.hidden = YES;
    }
    return _pageLabel;
}

/** 商品名 */
- (UILabel *)goodsNameLabel{
    if (_goodsNameLabel == nil) {
        _goodsNameLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:18 alignment:NSTextAlignmentLeft];
        _goodsNameLabel.text = @"";
    }
    return _goodsNameLabel;
}

/** 商品价格 */
- (UILabel *)goodsPriceLabel{
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [UILabel labelWithTitleColorStr:COLOR_RED_STR fontSize:26 alignment:NSTextAlignmentLeft];
        _goodsPriceLabel.text = @"";
    }
    return _goodsPriceLabel;
}
/** 细线 */
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

/** 选择规格及数量背景view */
- (ALATitleValueCellView *)propertyView{
    if (_propertyView == nil) {
        _propertyView = [[ALATitleValueCellView alloc] initWithTitle:@"已选  |" value:@"" target:self action:@selector(propertyViewAction)];
        _propertyView.frame = CGRectMake(0.0, 10.0, SCREEN_WIDTH, 48.0);
        _propertyView.backgroundColor = [UIColor whiteColor];
        _propertyView.valueTextAlignment = NSTextAlignmentLeft;
        _propertyView.titleColorStr = COLOR_LIGHT_STR;
        _propertyView.valueColorStr = COLOR_BLACK_STR;
        _propertyView.titleFont = [UIFont systemFontOfSize:14];
        _propertyView.valueFont = [UIFont systemFontOfSize:14];
        _propertyView.showBottomLineView = NO;
    }
    return _propertyView;
}
/** 间隔view */
- (UIView *)gapView{
    if (_gapView == nil) {
        _gapView = [[UIView alloc] init];
        _gapView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _gapView;
}

/** 特性view */
- (UIView *)featureView{
    if (_featureView == nil) {
        _featureView = [[UIView alloc] init];
        _featureView.backgroundColor = [UIColor whiteColor];
    }
    return _featureView;
}

/** 正品保证 */
- (ZTMXFLeftImageLabel *)featureOneLabel{
    if (_featureOneLabel == nil) {
        _featureOneLabel = [ZTMXFLeftImageLabel leftImageLabelWithImageStr:@"feature_one_icon" title:@"正品保证" origin:CGPointMake(0.0, 0.0)];
        _featureOneLabel.imageTitleMargin = 2.0;
        _featureOneLabel.titleFont = [UIFont systemFontOfSize:12];
        _featureOneLabel.titleColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        _featureOneLabel.contentTextAlignment = ContentTextAlignmentLeft;
    }
    return _featureOneLabel;
}
- (UIView *)featureLineOne{
    if (_featureLineOne == nil) {
        _featureLineOne = [[UIView alloc] init];
        _featureLineOne.backgroundColor = [UIColor colorWithHexString:@"EDEFF0"];
    }
    return _featureLineOne;
}
/** 顺丰包邮 */
- (ZTMXFLeftImageLabel *)featureTwoLabel{
    if (_featureTwoLabel == nil) {
        _featureTwoLabel = [ZTMXFLeftImageLabel leftImageLabelWithImageStr:@"feature_two_icon" title:@"快递包邮" origin:CGPointMake(0.0, 0.0)];
        _featureTwoLabel.imageTitleMargin = 2.0;
        _featureTwoLabel.titleFont = [UIFont systemFontOfSize:12];
        _featureTwoLabel.titleColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        _featureTwoLabel.contentTextAlignment = ContentTextAlignmentCenter;
    }
    return _featureTwoLabel;
}
- (UIView *)featureLineTwo{
    if (_featureLineTwo == nil) {
        _featureLineTwo = [[UIView alloc] init];
        _featureLineTwo.backgroundColor = [UIColor colorWithHexString:@"EDEFF0"];
    }
    return _featureLineTwo;
}
/** 无理由退换 */
- (ZTMXFLeftImageLabel *)featureThreeLabel{
    if (_featureThreeLabel == nil) {
        _featureThreeLabel = [ZTMXFLeftImageLabel leftImageLabelWithImageStr:@"feature_three_icon" title:@"尖货优选" origin:CGPointMake(0.0, 0.0)];
        _featureThreeLabel.imageTitleMargin = 5.0;
        _featureThreeLabel.titleFont = [UIFont systemFontOfSize:12];
        _featureThreeLabel.titleColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        _featureThreeLabel.contentTextAlignment = ContentTextAlignmentRight;
    }
    return _featureThreeLabel;
}

/** 间隔商品详情图片 */
- (UIImageView *)gapGoodsPictureImageView{
    if (_gapGoodsPictureImageView == nil) {
        _gapGoodsPictureImageView = [[UIImageView alloc] init];
        _gapGoodsPictureImageView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _gapGoodsPictureImageView.userInteractionEnabled = YES;
        _gapGoodsPictureImageView.contentMode = UIViewContentModeScaleAspectFit;
        _gapGoodsPictureImageView.image = [UIImage imageNamed:@"XL_line_dash"];
    }
    return _gapGoodsPictureImageView;
}
- (UIImageView *)goodsDetailIconImageView{
    if (_goodsDetailIconImageView == nil) {
        _goodsDetailIconImageView = [[UIImageView alloc] init];
        _goodsDetailIconImageView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _goodsDetailIconImageView.userInteractionEnabled = YES;
        _goodsDetailIconImageView.contentMode = UIViewContentModeCenter;
        _goodsDetailIconImageView.image = [UIImage imageNamed:@"goodsDetail_shop_icon"];
    }
    return _goodsDetailIconImageView;
}

/** 设置商品详情数据model */
- (void)setGoodsDetailModel:(GoodsDetailModel *)goodsDetailModel{
    if (_goodsDetailModel != goodsDetailModel) {
        _goodsDetailModel = goodsDetailModel;
    }
    //  轮播图的数据
    NSArray *cycleImageArray = _goodsDetailModel.goodsInfo.bannerImages;
    [self.cycleImageModelArray removeAllObjects];
    for (NSString *urlStr in cycleImageArray) {
        [self.cycleImageModelArray addObject:urlStr];
    }
    
    if (self.cycleImageModelArray.count > 0) {
        self.cycleScrollView.imageURLStringsGroup = self.cycleImageModelArray;
        self.pageLabel.hidden = NO;
        self.pageView.hidden = NO;
        self.pageLabel.text = [NSString stringWithFormat:@"1/%ld", self.cycleImageModelArray.count];
    } else {
        self.pageLabel.hidden = YES;
        self.pageView.hidden = YES;
    }
    
    self.goodsNameLabel.text = _goodsDetailModel.goodsInfo.name;
    NSString *goodsPrice = [NSString stringWithFormat:@"￥%.2f", _goodsDetailModel.price];
    UIFont *moneyFont = [UIFont systemFontOfSize:14];
    self.goodsPriceLabel.attributedText = [NSString changeStringWithStr:goodsPrice fontStr:@"￥" withFont:moneyFont];
    
    
    
    NSString *propertyString = [NSString string];
    for (NSString *property in _goodsDetailModel.propertyValues) {
        if (!kStringIsEmpty(property)) {
            propertyString = [propertyString stringByAppendingString:[NSString stringWithFormat:@" %@",property]];
        }
    }
    self.propertyView.valueStr = propertyString;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/** 配置选择规格属性 */
- (void)configGoodsPropertyName:(NSString *)propertyName{
    self.propertyView.valueStr = propertyName;
}

#pragma mark - 按钮点击事件
/** 选择规格数量按钮点击 */
- (void)propertyViewAction{
    if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(goodsDetailHeaderScrollViewClickChoiseProperty)]) {
        [self.headerDelegate goodsDetailHeaderScrollViewClickChoiseProperty];
    }
}

#pragma mark - 代理方法
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", (index + 1),self.cycleImageModelArray.count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
