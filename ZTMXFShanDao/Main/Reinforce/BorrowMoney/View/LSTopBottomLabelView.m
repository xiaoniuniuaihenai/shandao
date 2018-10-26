//
//  LSTopBottomLabelView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSTopBottomLabelView.h"

@interface LSTopBottomLabelView ()

/** top label */
@property (nonatomic, strong) UILabel *topLabel;
/** bottom label */
@property (nonatomic, strong) UILabel *bottomLabel;

@end


@implementation LSTopBottomLabelView

- (instancetype)initWithTopStr:(NSString *)topStr bottomStr:(NSString *)bottomStr{
    self = [super init];
    if (self) {
        if (!kStringIsEmpty(topStr)) {
            self.topStr = topStr;
        }
        if (!kStringIsEmpty(bottomStr)) {
            self.bottomStr = bottomStr;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _topBottomMargin = 10.0;
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    self.topLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:13 alignment:NSTextAlignmentCenter];
    if (!kStringIsEmpty(_topStr)) {
        self.topLabel.text = _topStr;
    }
    [self addSubview:self.topLabel];
    
    
    self.bottomLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:13 alignment:NSTextAlignmentCenter];
    if (!kStringIsEmpty(_bottomStr)) {
        self.bottomLabel.text = _bottomStr;
    }
    [self addSubview:self.bottomLabel];
    
}

//  布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat leftMargin = 10.0;
    
    NSString *topStr = [NSString stringWithFormat:@"你好"];
    CGFloat topHeight = [topStr sizeWithFont:self.topLabel.font maxW:MAXFLOAT].height;
    
    CGFloat bottomHeight = 30.0;
    
    CGFloat topLabelY = (viewHeight - _topBottomMargin - topHeight - bottomHeight) / 2.0;
    self.topLabel.frame = CGRectMake(leftMargin, topLabelY, viewWidth - 2 * leftMargin, topHeight);
    
    self.bottomLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.topLabel.frame) + _topBottomMargin, viewWidth - leftMargin * 2, bottomHeight);
}

//  设置top text
- (void)setTopStr:(NSString *)topStr
{
    if (_topStr != topStr) {
        _topStr = topStr;
    }
    self.topLabel.text = topStr;
}

- (void)setTopTitleColor:(UIColor *)topTitleColor{
    if (_topTitleColor != topTitleColor) {
        _topTitleColor = topTitleColor;
    }
    self.topLabel.textColor = _topTitleColor;
}

//  设置bottom text
- (void)setBottomStr:(NSString *)bottomStr{
    if (_bottomStr != bottomStr) {
        _bottomStr = bottomStr;
    }
    self.bottomLabel.text = bottomStr;
}

- (void)setBottomTitleColor:(UIColor *)bottomTitleColor{
    if (_bottomTitleColor != bottomTitleColor) {
        _bottomTitleColor = bottomTitleColor;
    }
    self.bottomLabel.textColor = _bottomTitleColor;
}


//  设置top 字体大小
- (void)setTopFontSize:(CGFloat)topFontSize{
    _topFontSize = topFontSize;
    if (_topFontSize < 1) {
        _topFontSize = 14;
    }
    self.topLabel.font = [UIFont systemFontOfSize:_topFontSize];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];

}

- (void)setBottomFontSize:(CGFloat)bottomFontSize{
    _bottomFontSize = bottomFontSize;
    if (_bottomFontSize < 1) {
        _bottomFontSize = 14;
    }
    self.bottomLabel.font = [UIFont systemFontOfSize:_bottomFontSize];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  设置整体字体对齐方式
- (void)setAllTextAlignment:(NSTextAlignment)textAlignment{
    self.topLabel.textAlignment = textAlignment;
    self.bottomLabel.textAlignment = textAlignment;
}

- (void)setTopBottomMargin:(CGFloat)topBottomMargin{
    if (topBottomMargin < 0) {
        return;
    }
    if (_topBottomMargin != topBottomMargin) {
        _topBottomMargin = topBottomMargin;
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
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
