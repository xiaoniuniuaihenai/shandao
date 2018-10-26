//
//  ALATitleValueCellView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ALATitleValueCellView.h"

@interface ALATitleValueCellView ()

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** title image */
@property (nonatomic, strong) UIImageView *titleImageView;

/** view button */
@property (nonatomic, strong) UIButton *viewButton;

/** row Image */
@property (nonatomic, strong) UIImageView *rowImageView;

/* bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation ALATitleValueCellView
{
    NSObject *target;
    SEL       viewAction;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showRowImageView = YES;
        
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    /** title */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:16 alignment:NSTextAlignmentLeft];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    if (self.titleStr) {
        self.titleLabel.text = self.titleStr;
    }
    [self addSubview:self.titleLabel];
    
    /** title image */
    self.titleImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self];
    self.titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleImageView.backgroundColor = [UIColor clearColor];
    
    /** value */
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:14 alignment:NSTextAlignmentRight];
    self.valueLabel.backgroundColor = [UIColor clearColor];
    if (self.valueStr) {
        self.valueLabel.text = self.valueStr;
    }
    [self addSubview:self.valueLabel];
    
    /** 箭头 */
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** 细线 */
    self.bottomLineView = [UIView setupViewWithSuperView:self withBGColor:COLOR_BORDER_STR];
    
    /** 按钮 */
    self.viewButton = [UIButton setupButtonWithSuperView:self withObject:target action:viewAction];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat leftMargin = AdaptedWidth(12.0);
    
    CGFloat titleImageX = leftMargin;
    if (self.titleImageStr) {
        self.titleImageView.hidden = NO;
        self.titleImageView.frame = CGRectMake(titleImageX, (cellHeight - 25.0) / 2.0, 25.0, 25.0);
        titleImageX += (25 + self.titleImageMargin);
    } else {
        self.titleImageView.hidden = YES;
    }
    
    self.titleLabel.frame = CGRectMake(titleImageX, 0.0, 200.0, cellHeight);
    
    if (self.showRowImageView) {
        self.rowImageView.hidden = NO;
        self.rowImageView.frame = CGRectMake(viewWidth - 20.0, 0.0, 8.0, cellHeight);
        self.valueLabel.frame = CGRectMake(60.0, 0.0, viewWidth - 90.0, cellHeight);
    } else {
        self.valueLabel.frame = CGRectMake(60.0, 0.0, viewWidth - 72.0, cellHeight);
        self.rowImageView.hidden = YES;
    }
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, viewWidth, 0.5);
    if (self.showMarginBottomLineView) {
        self.bottomLineView.frame = CGRectMake(12.0, cellHeight - 0.5,viewWidth - 24.0, 0.5);
    }
    self.viewButton.frame = CGRectMake(0.0, 0.0, viewWidth, cellHeight);
}

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value target:(NSObject *)obj action:(SEL)action{
   
    self.titleStr = title;
    self.valueStr = value;
    target = obj;
    viewAction = action;

    if (self = [super init]) {
   
    }
    return self;
}


//  设置是否显示底部细线
- (void)setShowBottomLineView:(BOOL)showBottomLineView
{
    _showBottomLineView = showBottomLineView;
    if (_showBottomLineView) {
        self.bottomLineView.hidden = NO;
    } else {
        self.bottomLineView.hidden = YES;
    }
}

- (void)setShowMarginBottomLineView:(BOOL)showMarginBottomLineView{
    _showMarginBottomLineView = showMarginBottomLineView;
    if (_showMarginBottomLineView) {
        self.bottomLineView.hidden = NO;
    } else {
        self.bottomLineView.hidden = YES;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  设置是否显示箭头
- (void)setShowRowImageView:(BOOL)showRowImageView
{
    if (_showRowImageView != showRowImageView) {
        _showRowImageView = showRowImageView;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  设置titleImage 的图片
- (void)setTitleImageStr:(NSString *)titleImageStr
{
    if (_titleImageStr != titleImageStr) {
        _titleImageStr = titleImageStr;
    }
    if ([_titleImageStr rangeOfString:@"http"].location != NSNotFound) {
        //  链接图片
        [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:_titleImageStr]];
    } else {
        self.titleImageView.image = [UIImage imageNamed:_titleImageStr];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  设置title 和 titleImage 的间距
- (void)setTitleImageMargin:(CGFloat)titleImageMargin{
    if (_titleImageMargin != titleImageMargin) {
        _titleImageMargin = titleImageMargin;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

// 设置title 字体颜色
- (void)setTitleColorStr:(NSString *)titleColorStr{
    if (_titleColorStr != titleColorStr) {
        _titleColorStr = titleColorStr;
    }
    
    self.titleLabel.textColor = [UIColor colorWithHexString:_titleColorStr];
}

//  设置value 字体颜色
- (void)setValueColorStr:(NSString *)valueColorStr{
    if (_valueColorStr != valueColorStr) {
        _valueColorStr = valueColorStr;
    }
    
    self.valueLabel.textColor = [UIColor colorWithHexString:_valueColorStr];
}

//  设置title 字体大小
- (void)setTitleFontSize:(CGFloat)titleFontSize{
    if (_titleFontSize != titleFontSize) {
        _titleFontSize = titleFontSize;
    }
    
    if (_titleFontSize > 1) {
        self.titleLabel.font = [UIFont systemFontOfSize:_titleFontSize];
    }
}

//   设置value 字体大小
- (void)setValueFontSize:(CGFloat)valueFontSize{
    if (_valueFontSize != valueFontSize) {
        _valueFontSize = valueFontSize;
    }
    if (_valueFontSize > 1) {
        self.valueLabel.font = [UIFont systemFontOfSize:_valueFontSize];
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
    }
    if (_titleFont) {
        self.titleLabel.font = _titleFont;
    }
}

- (void)setValueFont:(UIFont *)valueFont{
    if (_valueFont != valueFont) {
        _valueFont = valueFont;
    }
    if (_valueFont) {
        self.valueLabel.font = _valueFont;
    }
}

- (void)setValueTextAlignment:(NSTextAlignment)valueTextAlignment{
    self.valueLabel.textAlignment = valueTextAlignment;
}

//  设置title
- (void)setTitleStr:(NSString *)titleStr{
    if (_titleStr != titleStr) {
        _titleStr = titleStr;
    }
    self.titleLabel.text = titleStr;
}

//  设置value
- (void)setValueStr:(NSString *)valueStr{
    if (_valueStr != valueStr) {
        _valueStr = valueStr;
    }
    self.valueLabel.text = valueStr;
}

//  设置是否单行
- (void)setShowSigleLine:(BOOL)showSigleLine{
    _showSigleLine = showSigleLine;
    if (_showSigleLine) {
        self.valueLabel.numberOfLines = 1;
    } else {
        self.valueLabel.numberOfLines = 0;
    }
}

@end
