//
//  HWTitleButton.m
//  黑马微博2期
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWTitleButton.h"

#define HWMargin 5

@implementation HWTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return self;
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxW:MAXFLOAT];

    // 1.计算titleLabel的frame
    CGFloat titleLabelX = (viewWidth - imageSize.width - titleSize.width - HWMargin) / 2.0;
    CGFloat titleLabelY = 0.0;
    CGFloat titleLabelW = titleSize.width;
    CGFloat titleLabelH = viewHeight;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);

    // 2.计算imageView的frame
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + HWMargin, (viewHeight - imageSize.height) / 2.0, imageSize.width, imageSize.height);
}
@end
