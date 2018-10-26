//
//  CategoryHeaderCollectionReusableView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CategoryHeaderCollectionReusableView.h"
#import "ZTMXFDoubleLineLabel.h"

@interface CategoryHeaderCollectionReusableView ()
/** 间隔view */
@property (nonatomic, strong) UIView *gapView;
/** title */
@property (nonatomic, strong) ZTMXFDoubleLineLabel *titleLabel;
@end

@implementation CategoryHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    /** 间隔view */
    self.gapView.frame = CGRectMake(0.0, 0.0, viewWidth, AdaptedHeight(10.0));
    /** title */
    self.titleLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.gapView.frame), viewWidth, viewHeight - CGRectGetHeight(self.gapView.frame));

}

/** 间隔view */
- (UIView *)gapView{
    if (_gapView == nil) {
        _gapView = [[UIView alloc] init];
        _gapView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _gapView;
}
- (void)setupViews{
    /** 间隔view */
    [self addSubview:self.gapView];
    /** title */
    [self addSubview:self.titleLabel];
}

/** title */
- (ZTMXFDoubleLineLabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[ZTMXFDoubleLineLabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"小米专区";
        _titleLabel.lineColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _titleLabel.lineWidth = AdaptedWidth(10.0);
        _titleLabel.lineHeight = AdaptedHeight(2.0);
        _titleLabel.lineMarging = 20.0;
    }
    return _titleLabel;
}

@end
