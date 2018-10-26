//
//  ALATopBottomButtonView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ALATopBottomButtonView.h"

@interface ALATopBottomButtonView ()

/** top label */
@property (nonatomic, strong) UILabel *topLabel;
/** bottom label */
@property (nonatomic, strong) UILabel *bottomLabel;

/** view button */
@property (nonatomic, strong) UIButton *viewButton;
/** 查看明细按钮 */
@property (nonatomic, strong) UIButton *viewDetailButton;

/** 箭头图片 */
@property (nonatomic, strong) UIImageView *rowImageView;

@end

@implementation ALATopBottomButtonView
{
    NSObject *target;
    SEL       viewAction;
}


- (instancetype)initWithTopTitle:(NSString *)topTitle bottomTitle:(NSString *)bottomTitle target:(NSObject *)obj action:(SEL)action{

    self.topStr = topTitle;
    self.bottomStr = bottomTitle;
    target = obj;
    viewAction = action;
    
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

//  添加子控件
- (void)setupViews{
    
    self.topLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentRight];
    if (self.topStr) {
        self.topLabel.text = self.topStr;
    }
    [self addSubview:self.topLabel];
    
    
    self.bottomLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:12 alignment:NSTextAlignmentRight];
    if (self.bottomStr) {
        self.bottomLabel.text = self.bottomStr;
    }
    [self addSubview:self.bottomLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self];
    self.rowImageView.contentMode = UIViewContentModeCenter;

    self.viewButton = [UIButton setupButtonWithSuperView:self withObject:target action:viewAction];

    self.viewDetailButton = [UIButton setupButtonWithSuperView:self withTitle:@"查看明细" titleFont:14 corner:0 withObject:self action:@selector(viewDetailButtonAction)];
    [self.viewDetailButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
    [self.viewDetailButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.viewDetailButton.hidden = YES;

}

- (void)setTextCenter:(BOOL)textCenter{
    _textCenter = textCenter;
    if (_textCenter) {
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        self.topLabel.textAlignment = NSTextAlignmentRight;
        self.bottomLabel.textAlignment = NSTextAlignmentRight;
    }
}

//  设置整体字体对齐方式
- (void)setAllTextAlignment:(NSTextAlignment)textAlignment{
    self.topLabel.textAlignment = textAlignment;
    self.bottomLabel.textAlignment = textAlignment;
}

- (void)setTopTextColor:(UIColor *)topTextColor{
    if (_topTextColor != topTextColor) {
        _topTextColor = topTextColor;
    }
    self.topLabel.textColor = _topTextColor;
}



- (void)setTopFontSize:(CGFloat)topFontSize{
    _topFontSize = topFontSize;
    if (_topFontSize < 1) {
        _topFontSize = 14;
    }
    self.topLabel.font = [UIFont systemFontOfSize:_topFontSize];
}


- (void)setBottomTextColor:(UIColor *)bottomTextColor{
    if (_bottomTextColor != bottomTextColor) {
        _bottomTextColor = bottomTextColor;
    }
    self.bottomLabel.textColor = _bottomTextColor;
}
- (void)setBottomFontSize:(CGFloat)bottomFontSize{
    _bottomFontSize = bottomFontSize;
    if (_bottomFontSize < 1) {
        _bottomFontSize = 13;
    }
    self.bottomLabel.font = [UIFont systemFontOfSize:_bottomFontSize];
}

//  布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat topBottomMargin = 12.0;
    CGFloat leftMargin = 14.0;
    CGFloat rightMargin = 25.0;
    
    /** top label */
    NSString *topStr = [NSString stringWithFormat:@"0.00"];
    CGFloat topHeight = [topStr sizeWithFont:self.topLabel.font maxW:MAXFLOAT].height;
    
    NSString *bottomStr = [NSString stringWithFormat:@"还款金额"];
    CGFloat bottomHeight = [bottomStr sizeWithFont:self.bottomLabel.font maxW:MAXFLOAT].height;
    
    CGFloat topLabelY = (viewHeight - topBottomMargin - topHeight - bottomHeight) / 2.0;
    self.topLabel.frame = CGRectMake(leftMargin, topLabelY, viewWidth - leftMargin - rightMargin, topHeight);
    
    /** bottom label */
    self.bottomLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.topLabel.frame) + topBottomMargin, CGRectGetWidth(self.topLabel.frame), bottomHeight);
    
    /** 箭头 */
    self.rowImageView.frame = CGRectMake(viewWidth - 20.0, 0.0, 8.0, viewHeight);

    self.viewButton.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    self.viewDetailButton.frame = CGRectMake(60.0, CGRectGetMinY(self.bottomLabel.frame), viewWidth - 80.0, CGRectGetHeight(self.bottomLabel.frame));

}

//  设置top text
- (void)setTopStr:(NSString *)topStr
{
    if (_topStr != topStr) {
        _topStr = topStr;
    }
    self.topLabel.text = topStr;
}

//  设置bottom text
- (void)setBottomStr:(NSString *)bottomStr{
    if (_bottomStr != bottomStr) {
        _bottomStr = bottomStr;
    }
    self.bottomLabel.text = bottomStr;
}

#pragma mark - 查看明细按钮点击事件
- (void)viewDetailButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topBottomButtonViewClickViewDetail)]) {
        [self.delegate topBottomButtonViewClickViewDetail];
    }
}

- (void)setShowViewDetailButton:(BOOL)showViewDetailButton{
    _showViewDetailButton = showViewDetailButton;
    if (_showViewDetailButton) {
        self.viewDetailButton.hidden = YES;
    } else {
        self.viewDetailButton.hidden = NO;
    }
}

- (void)setShowRowImageView:(BOOL)showRowImageView{
    _showRowImageView = showRowImageView;
    if (_showRowImageView) {
        self.rowImageView.hidden = YES;
    } else {
        self.rowImageView.hidden = NO;
    }
}
@end
