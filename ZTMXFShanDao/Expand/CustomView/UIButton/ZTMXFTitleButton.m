//
//  TitleButton.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/25.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ZTMXFTitleButton.h"

@implementation ZTMXFTitleButton



- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxW:MAXFLOAT];
    
    // 1.计算titleLabel的frame
    CGFloat titleLabelX = (viewWidth - imageSize.width - titleSize.width - 5.0) / 2.0;
    if (_titleType == TitleLeftType) {
        titleLabelX = 0.0;
    }
    CGFloat titleLabelY = 0.0;
    CGFloat titleLabelW = titleSize.width;
    CGFloat titleLabelH = viewHeight;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    // 2.计算imageView的frame
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 5.0, 0.0, imageSize.width + 5.0, viewHeight);
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)setTitleType:(TitleButtonType)titleType{
    if (_titleType != titleType) {
        _titleType = titleType;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
