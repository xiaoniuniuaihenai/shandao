//
//  HotSaleView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "HotSaleView.h"

@interface HotSaleView ()

@property (nonatomic, strong) UIView  *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *hotImageView;

@end

@implementation HotSaleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.titleLabel];
    [self addSubview:self.hotImageView];
    
}



- (UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _titleView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithTitleColorStr:COLOR_RED_STR fontSize:16 alignment:NSTextAlignmentCenter];
        _titleLabel.text = @"今日特惠";
    }
    return _titleLabel;
}



- (UIView *)hotImageView{
    if (_hotImageView == nil) {
        _hotImageView = [[UIView alloc] init];
        _hotImageView.backgroundColor = [UIColor yellowColor];
    }
    return _hotImageView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewHeight = self.bounds.size.height;
    
    self.titleView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(47.0));
    self.titleLabel.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.titleView.frame), CGRectGetHeight(self.titleView.frame));
    self.hotImageView.frame = CGRectMake(AdaptedWidth(12.0), CGRectGetMaxY(self.titleView.frame) + AdaptedHeight(10.0), Main_Screen_Width - AdaptedWidth(12.0) * 2, viewHeight - CGRectGetMaxY(self.titleView.frame) - AdaptedHeight(20.0));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
