//
//  TopBottomTitleButton.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "TopBottomTitleButton.h"

@interface TopBottomTitleButton ()

/** top ImageView */
@property (nonatomic, strong) UIImageView *topImageView;

/** reminder */
@property (nonatomic, strong) UILabel *reminderLabel;

/** top title label */
@property (nonatomic, strong) UILabel *topTitleLabel;
/** bottom title label */
@property (nonatomic, strong) UILabel *bottomTitleLabel;

@end

@implementation TopBottomTitleButton

- (instancetype)initWithTopTitle:(NSString *)topTitle bottomTitle:(NSString *)bottomTitle{
    _topTitle = topTitle;
    _bottomTtile = bottomTitle;
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

//  添加子视图
- (void)setupViews{
    
    /** top Label */
    self.topTitleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:18 alignment:NSTextAlignmentCenter];
    self.topTitleFont = AdaptedBoldFontSize(18);
    if (_topTitle) {
        self.topTitleLabel.text = _topTitle;
    }
    self.topTitleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topTitleLabel];
    
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.contentMode = UIViewContentModeCenter;
    self.topImageView.userInteractionEnabled = YES;
    [self addSubview:self.topImageView];
    
    /** bottom Label */
    self.bottomTitleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:12 alignment:NSTextAlignmentCenter];
    self.bottomTitleFont = AdaptedFontSize(13);
    if (_bottomTtile) {
        self.bottomTitleLabel.text = _bottomTtile;
    }
    self.bottomTitleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomTitleLabel];
    
    self.reminderLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:12 alignment:NSTextAlignmentCenter];
    self.reminderLabel.backgroundColor = [UIColor colorWithHexString:@"e66647"];
    self.reminderLabel.layer.cornerRadius = 9.0;
    self.reminderLabel.clipsToBounds = YES;
    [self addSubview:_reminderLabel];
    self.reminderLabel.hidden = YES;
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self.clearButton];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat titleMargin = 0.0;
    CGFloat topMargin = 8.0;
    CGFloat bottomMargin = 0.0;
    CGFloat topTitleLabelHeight = (viewHeight - titleMargin - topMargin - bottomMargin) / 2.0;
    CGFloat bottomTitleLabelHeight = (viewHeight - titleMargin - topMargin - bottomMargin) / 2.0;
    
    self.topTitleLabel.frame = CGRectMake(0.0, topMargin, viewWidth, topTitleLabelHeight);
    self.topImageView.frame = CGRectMake(0.0, topMargin, viewWidth, topTitleLabelHeight);
    self.bottomTitleLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.topTitleLabel.frame) + titleMargin, viewWidth, bottomTitleLabelHeight);
    self.clearButton.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    self.reminderLabel.frame = CGRectMake(viewWidth / 2.0 + 12.0, 8.0, 18.0, 18.0);
}

- (void)setTopTitle:(NSString *)topTitle{
    if (_topTitle != topTitle) {
        _topTitle = topTitle;
    }
    if (_topTitle) {
        self.topTitleLabel.text = _topTitle;
    }
}

- (void)setTopImageStr:(NSString *)topImageStr{
    if (_topImageStr != topImageStr) {
        _topImageStr = topImageStr;
    }
    if (!kStringIsEmpty(_topImageStr)) {
        self.topImageView.image = [UIImage imageNamed:_topImageStr];
    } else {
        self.topImageView.image = nil;
    }
}

- (void)setBottomTtile:(NSString *)bottomTtile{
    if (_bottomTtile != bottomTtile) {
        _bottomTtile = bottomTtile;
    }
    if (_bottomTtile) {
        self.bottomTitleLabel.text = _bottomTtile;
    }
}

- (void)setTopTitleColor:(UIColor *)topTitleColor{
    if (_topTitleColor != topTitleColor) {
        _topTitleColor = topTitleColor;
    }
    if (_topTitleColor) {
        self.topTitleLabel.textColor = _topTitleColor;
    }
}

- (void)setBottomTitleColor:(UIColor *)bottomTitleColor{
    if (_bottomTitleColor != bottomTitleColor) {
        _bottomTitleColor = bottomTitleColor;
    }
    if (_bottomTitleColor) {
        self.bottomTitleLabel.textColor = _bottomTitleColor;
    }
}

-(void)setTopTitleFont:(UIFont *)topTitleFont{
    if (_topTitleFont != topTitleFont) {
        _topTitleFont = topTitleFont;
    }
    if (_topTitleFont) {
        self.topTitleLabel.font = _topTitleFont;
    }
}

- (void)setBottomTitleFont:(UIFont *)bottomTitleFont{
    if (_bottomTitleFont != bottomTitleFont) {
        _bottomTitleFont = bottomTitleFont;
    }
    if (_bottomTitleFont) {
        self.bottomTitleLabel.font = _bottomTitleFont;
    }
}

- (void)setReminderCount:(NSString *)reminderCount{
    if (_reminderCount != reminderCount) {
        _reminderCount = reminderCount;
    }
    
    NSInteger count = [_reminderCount integerValue];
    if (count > 0) {
        self.reminderLabel.hidden = NO;
        self.reminderLabel.text = [NSString stringWithFormat:@"%ld", count];
    } else {
        self.reminderLabel.hidden = YES;
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
