//
//  StyleCollectionViewCell.m
//  Himalaya
//
//  Created by 杨鹏 on 16/8/6.
//  Copyright © 2016年 ala. All rights reserved.
//

#import "StyleCollectionViewCell.h"

@implementation StyleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}



- (void)setSelectedState:(BOOL)selectedState
{
    _selectedState = selectedState;
    if (_selectedState) {
        self.titleLabel.layer.borderColor = K_MainColor.CGColor;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = K_MainColor;
    } else {
        self.titleLabel.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
        self.titleLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        self.titleLabel.backgroundColor = [UIColor whiteColor];

    }
}
- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    // 设置字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    // 设置字体颜色
    self.titleLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    //  设置对齐方式
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.layer.cornerRadius = 3.0;
    self.titleLabel.layer.masksToBounds = YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    self.titleLabel.layer.borderWidth = 1.0;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = @"";
}

@end
