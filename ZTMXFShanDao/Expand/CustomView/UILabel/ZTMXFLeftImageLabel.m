//
//  LeftImageLabel.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/7.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "ZTMXFLeftImageLabel.h"

@interface ZTMXFLeftImageLabel ()
{
    CGFloat _imageTitleMargin;
    UIFont* _titleFont;
}
/** 左边图片 */
@property (nonatomic, strong) UIImageView *leftImageView;
/** 右边title */
@property (nonatomic, strong) UILabel *rightTitleLabel;

@end

@implementation ZTMXFLeftImageLabel



- (CGFloat)imageTitleMargin
{
    if (_imageTitleMargin < 1) {
        _imageTitleMargin = 10.0;
    }
    return _imageTitleMargin;
}


- (UIFont *)titleFont
{
    if (_titleFont == nil) {
        _titleFont = [UIFont systemFontOfSize:14];
    }
    return _titleFont;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (UIImageView *)leftImageView
{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor clearColor];
        _leftImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (UILabel *)rightTitleLabel
{
    if (_rightTitleLabel == nil) {
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.font = self.titleFont;
        _rightTitleLabel.numberOfLines = 0;
        [self addSubview:_rightTitleLabel];
    }
    return _rightTitleLabel;
}

- (void)setLeftImageStr:(NSString *)leftImageStr
{
    if (_leftImageStr != leftImageStr) {
        _leftImageStr = leftImageStr;
        
        _leftImageView.image = [UIImage imageNamed:_leftImageStr];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setImageTitleMargin:(CGFloat)imageTitleMargin
{
    if (_imageTitleMargin != imageTitleMargin) {
        _imageTitleMargin = imageTitleMargin;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
        self.rightTitleLabel.textColor = _titleColor;
    }
}

- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
        self.rightTitleLabel.text = _title;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/** 设置对齐 */
- (void)setContentTextAlignment:(ContentTextAlignment)contentTextAlignment{
    _contentTextAlignment = contentTextAlignment;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

+ (instancetype)leftImageLabelWithImageStr:(NSString *)imageStr title:(NSString *)title origin:(CGPoint)origin{
    
    ZTMXFLeftImageLabel *view = [[ZTMXFLeftImageLabel alloc] init];
    view.leftImageView.image = [UIImage imageNamed:imageStr];
    view.rightTitleLabel.text = title;
    view.rightTitleLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    
    CGSize imageSzie = view.leftImageView.image.size;
    CGSize labelStrSize = [view.rightTitleLabel.text sizeWithFont:view.rightTitleLabel.font maxW:MAXFLOAT];
    CGFloat labelHeight = MAX(imageSzie.height, labelStrSize.height);
    if (labelHeight < 10.0) {
        labelHeight = 20.0;
    }
    view.leftImageView.frame = CGRectMake(0.0, 0.0, imageSzie.width, labelHeight);
    view.rightTitleLabel.frame = CGRectMake(imageSzie.width + view.imageTitleMargin, 0.0, labelStrSize.width, labelHeight);
    
    return view;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    self.rightTitleLabel.font = self.titleFont;
    self.rightTitleLabel.textColor = self.titleColor ? self.titleColor : [UIColor colorWithHexString:COLOR_GRAY_STR];
    CGSize imageSzie = self.leftImageView.image.size;
    CGSize labelStrSize = [self.rightTitleLabel.text sizeWithFont:self.rightTitleLabel.font maxW:MAXFLOAT];
    CGFloat labelHeight = MAX(imageSzie.height, labelStrSize.height);
    if (labelHeight < 10.0) {
        labelHeight = 20.0;
    }
    
    CGFloat leftImageViewX = 0.0;
    CGFloat leftImageViewY = (viewHeight - labelHeight) / 2.0;

    if (_contentTextAlignment == ContentTextAlignmentLeft) {

    } else if (_contentTextAlignment == ContentTextAlignmentCenter) {
        leftImageViewX = (viewWidth - imageSzie.width - self.imageTitleMargin - labelStrSize.width) / 2.0;
        if (leftImageViewX <= 0) {
            leftImageViewX = 0;
        }
    } else {
        leftImageViewX = viewWidth - imageSzie.width - self.imageTitleMargin - labelStrSize.width;
        if (leftImageViewX <= 0) {
            leftImageViewX = 0;
        }
    }
    
    self.leftImageView.frame = CGRectMake(leftImageViewX, leftImageViewY, imageSzie.width, labelHeight);
    self.rightTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame) + self.imageTitleMargin, leftImageViewY, labelStrSize.width, labelHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
