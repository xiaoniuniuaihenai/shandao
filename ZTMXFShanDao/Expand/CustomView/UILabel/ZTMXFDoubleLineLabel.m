//
//  DoubleLineLabel.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/4.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "ZTMXFDoubleLineLabel.h"

@implementation ZTMXFDoubleLineLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont boldSystemFontOfSize:15];
        
        self.lineColor = [UIColor clearColor];
        self.lineWidth = 0.0;
        self.lineHeight = 0.0;
        self.lineMarging = 5.0;
        
    }
    return self;
}



- (void)setText:(NSString *)text
{
    [super setText:text];

    [self setupContent];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat textWidth = [self.text sizeWithFont:self.font maxW:MAXFLOAT].width;
    
    if (_lineWidth <= 0 || _lineHeight <= 0 || viewWidth <= 0 || viewHeight <= 0) {
        return ;
    }
    
    //  左边细线
    CGFloat leftLineX = (viewWidth - textWidth) / 2.0 - _lineWidth - _lineMarging;
    CGFloat leftLineY = (viewHeight - _lineHeight) / 2.0;
    self.leftLine.frame = CGRectMake(leftLineX, leftLineY, _lineWidth, _lineHeight);
    
    //  右边细线
    CGFloat rightLineX = (viewWidth + textWidth) / 2.0 + _lineMarging;
    self.rightLine.frame = CGRectMake(rightLineX, leftLineY, _lineWidth, _lineHeight);
    
}
- (void)setLineHeight:(CGFloat)lineHeight{
    if (lineHeight > 0) {
        _lineHeight = lineHeight;
        [self setupContent];
    } else {
        _lineHeight = 0.0;
    }
}

- (void)setLineWidth:(CGFloat)lineWidth{
    if (lineWidth > 0) {
        _lineWidth = lineWidth;
        [self setupContent];
    } else {
        _lineWidth = 0.0;
    }
}

- (void)setLineMarging:(CGFloat)lineMarging{
    if (lineMarging > 0) {
        _lineMarging = lineMarging;
        [self setupContent];
    } else {
        _lineMarging = 0.0;
    }
}

//  设置label内容
- (void)setupContent{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (lineColor) {
        _lineColor = lineColor;
    } else {
        _lineColor = [UIColor clearColor];
    }
    
    self.leftLine.backgroundColor = _lineColor;
    self.rightLine.backgroundColor = _lineColor;
}

/** 设置一个view */
- (UIView *)setupViewWithSuperView:(UIView *)superView withBGColor:(UIColor *)bgColor{
    UIView *view = [[UIView alloc] init];
    if (bgColor) {
        view.backgroundColor = bgColor;
    } else {
        view.backgroundColor = [UIColor whiteColor];
    }
    [superView addSubview:view];
    return view;
}

- (UIView *)leftLine
{
    if (!_leftLine) {
        _leftLine = [self setupViewWithSuperView:self withBGColor:self.lineColor];
    }
    return _leftLine;
}

- (UIView *)rightLine
{
    if (!_rightLine) {
        _rightLine = [self setupViewWithSuperView:self withBGColor:self.lineColor];
    }
    return _rightLine;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
