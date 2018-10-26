//
//  LSTitleValueCellView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "LSTitleValueCellView.h"

@interface LSTitleValueCellView ()

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** title image */
@property (nonatomic, strong) UIImageView *titleImageView;
/** value label */
@property (nonatomic, strong) UILabel *valueLabel;

/** view button */
@property (nonatomic, strong) UIButton *viewButton;

/** row Image */
@property (nonatomic, strong) UIImageView *rowImageView;

/* bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation LSTitleValueCellView
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



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat viewWidth = self.bounds.size.width;
    
    CGFloat titleImageX = 12.0;
    if (self.titleImageStr) {
        self.titleImageView.hidden = NO;
        self.titleImageView.frame = CGRectMake(titleImageX, (cellHeight - 20.0) / 2.0, 20.0, 20.0);
        titleImageX += (20 + self.titleImageMargin);
    } else {
        self.titleImageView.hidden = YES;
    }
    
    self.titleLabel.frame = CGRectMake(titleImageX, 0.0, 200.0, cellHeight);
    
    if (self.showRowImageView) {
        self.rowImageView.hidden = NO;
        self.rowImageView.frame = CGRectMake(viewWidth - 20.0, 0.0, 8.0, cellHeight);
        self.valueLabel.frame = CGRectMake(100.0, 0.0, viewWidth - 130.0, cellHeight);
    } else {
        self.valueLabel.frame = CGRectMake(100, 0.0, viewWidth - 112, cellHeight);
        self.rowImageView.hidden = YES;
    }
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, viewWidth, 0.5);
    if (self.showMarginBottomLineView) {
        self.bottomLineView.frame = CGRectMake(12.0, cellHeight - 0.5,viewWidth - 24.0, 0.5);
    }
    self.viewButton.frame = CGRectMake(0.0, 0.0, viewWidth, cellHeight);
}

- (void)setupViewsFrame{
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat viewWidth = self.bounds.size.width;
    
    CGFloat titleImageX = 12.0;
    if (self.titleImageStr) {
        self.titleImageView.hidden = NO;
        self.titleImageView.frame = CGRectMake(titleImageX, (cellHeight - 25.0) / 2.0, 20.0, 20.0);
        titleImageX += (20 + self.titleImageMargin);
    } else {
        self.titleImageView.hidden = YES;
    }
    
    self.titleLabel.frame = CGRectMake(titleImageX, 0.0, 200.0, cellHeight);
    
    if (self.showRowImageView) {
        self.rowImageView.hidden = NO;
        self.rowImageView.frame = CGRectMake(viewWidth - 20.0, 0.0, 8.0, cellHeight);
        self.valueLabel.frame = CGRectMake(viewWidth - 200.0, 0.0, 170.0, cellHeight);
    } else {
        self.valueLabel.frame = CGRectMake(viewWidth - 200.0, 0.0, 188.0, cellHeight);
        self.rowImageView.hidden = YES;
    }
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, viewWidth, 0.5);
    if (self.showMarginBottomLineView) {
        self.bottomLineView.frame = CGRectMake(12.0, cellHeight - 0.5,viewWidth - 24.0, 0.5);
    }
    self.viewButton.frame = CGRectMake(0.0, 0.0, viewWidth, cellHeight);

}
//  添加子控件
- (void)setupViews{
    
    /** title */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:15 alignment:NSTextAlignmentLeft];
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
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:15 alignment:NSTextAlignmentRight];
    self.valueLabel.backgroundColor = [UIColor clearColor];
    if (self.valueStr) {
        self.valueLabel.text = self.valueStr;
    }
    [self addSubview:self.valueLabel];
    
    /** 箭头 */
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** 细线 */
    self.bottomLineView = [UIView setupViewWithSuperView:self withBGColor:@"afafaf"];
    
    /** 按钮 */
    self.viewButton = [UIButton setupButtonWithSuperView:self withObject:target action:viewAction];
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
}


//  设置是否显示箭头
- (void)setShowRowImageView:(BOOL)showRowImageView
{
    if (_showRowImageView != showRowImageView) {
        _showRowImageView = showRowImageView;
    }
    
    [self setupViewsFrame];
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
    
    [self setupViewsFrame];
}

//  设置title 和 titleImage 的间距
- (void)setTitleImageMargin:(CGFloat)titleImageMargin{
    if (_titleImageMargin != titleImageMargin) {
        _titleImageMargin = titleImageMargin;
    }
    [self setupViewsFrame];
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
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

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    if (bottomLineColor) {
        self.bottomLineView.backgroundColor = bottomLineColor;
    }
}

@end
