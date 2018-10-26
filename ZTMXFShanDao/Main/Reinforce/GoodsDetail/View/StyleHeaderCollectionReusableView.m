//
//  StyleHeaderCollectionReusableView.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/6.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "StyleHeaderCollectionReusableView.h"

@implementation StyleHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}



- (void)setupViews{
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"111111"];
    self.titleLabel.text = @" 产品规格";
    [self addSubview:self.titleLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewHeight = self.bounds.size.height;
    self.titleLabel.frame = CGRectMake(12.0, 0.0, SCREEN_WIDTH - 40, viewHeight);
}

@end
