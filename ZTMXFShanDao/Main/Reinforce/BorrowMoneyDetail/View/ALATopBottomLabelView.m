//
//  ALATopBottomLabelView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ALATopBottomLabelView.h"

@interface ALATopBottomLabelView ()

/** top label */
@property (nonatomic, strong) UILabel *topLabel;
/** bottom label */
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation ALATopBottomLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



//  按钮点击事件
- (void)viewButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topBottomLabelViewClickButton:)]) {
        [self.delegate topBottomLabelViewClickButton:self];
    }
}


//  添加子控件
- (void)setupViews{
    
    self.topLabel = [UILabel labelWithTitleColor:[UIColor blackColor] fontSize:22 alignment:NSTextAlignmentCenter];
    [self addSubview:self.topLabel];
    
    
    self.bottomLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentCenter];
    [self addSubview:self.bottomLabel];
    
    
    self.viewButton = [UIButton setupButtonWithSuperView:self withTitle:@"延期还款申请中" titleFont:14 corner:0 withObject:self action:@selector(viewButtonAction)];
    [self.viewButton setTitleColor:[UIColor colorWithHexString:COLOR_ORANGE_STR] forState:UIControlStateNormal];
    [self.viewButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.viewButton.hidden = YES;
}
//  布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat topBottomMargin = 12.0;
    CGFloat leftMargin = 16.0;
    NSString *viewButtonTitle = self.viewButton.currentTitle;
    if (SCREEN_WIDTH < 330.0) {
        //  iPhone5 和 iPhone 4
        if (viewButtonTitle.length == 5) {
            leftMargin = 3.0;
        } else if (viewButtonTitle.length == 4){
            leftMargin = 6.0;
        }
    } else if (SCREEN_WIDTH < 380.0) {
        leftMargin = 12.0;
    }

    NSString *topStr = [NSString stringWithFormat:@"0.00"];
    CGFloat topHeight = [topStr sizeWithFont:self.topLabel.font maxW:MAXFLOAT].height;
    
    NSString *bottomStr = [NSString stringWithFormat:@"还款金额"];
    CGFloat bottomHeight = [bottomStr sizeWithFont:self.bottomLabel.font maxW:MAXFLOAT].height;

    
    CGFloat topLabelY = (viewHeight - topBottomMargin - topHeight - bottomHeight) / 2.0;
    self.topLabel.frame = CGRectMake(leftMargin, topLabelY, viewWidth - 2 * leftMargin, topHeight);
    
    self.bottomLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.topLabel.frame) + topBottomMargin, viewWidth - leftMargin * 2, bottomHeight);

    CGFloat buttomRightMargin = 20.0;
    if (SCREEN_WIDTH < 330.0) {
        //  iPhone5 和 iPhone 4
        if (viewButtonTitle.length == 5) {
            buttomRightMargin = 3.0;
        } else if (viewButtonTitle.length == 4){
            buttomRightMargin = 6.0;
        }
    } else if (SCREEN_WIDTH < 380.0) {
        buttomRightMargin = 12.0;
    }
    self.viewButton.frame = CGRectMake(40.0, CGRectGetMinY(self.bottomLabel.frame), viewWidth - 40.0 - buttomRightMargin, bottomHeight);
}

//  设置top text
- (void)setTopStr:(NSString *)topStr
{
    if (_topStr != topStr) {
        _topStr = topStr;
    }
    self.topLabel.text = topStr;
}

- (void)setTopTitleColor:(UIColor *)topTitleColor{
    if (_topTitleColor != topTitleColor) {
        _topTitleColor = topTitleColor;
    }
    self.topLabel.textColor = _topTitleColor;
}

//  设置bottom text
- (void)setBottomStr:(NSString *)bottomStr{
    if (_bottomStr != bottomStr) {
        _bottomStr = bottomStr;
    }
    self.bottomLabel.text = bottomStr;
}

- (void)setBottomTitleColor:(UIColor *)bottomTitleColor{
    if (_bottomTitleColor != bottomTitleColor) {
        _bottomTitleColor = bottomTitleColor;
    }
    self.bottomLabel.textColor = _bottomTitleColor;
}


//  设置top 字体大小
- (void)setTopFontSize:(CGFloat)topFontSize{
    _topFontSize = topFontSize;
    if (_topFontSize < 1) {
        _topFontSize = 14;
    }
    self.topLabel.font = [UIFont systemFontOfSize:_topFontSize];
}

- (void)setBottomFontSize:(CGFloat)bottomFontSize{
    _bottomFontSize = bottomFontSize;
    if (_bottomFontSize < 1) {
        _bottomFontSize = 14;
    }
    self.bottomLabel.font = [UIFont systemFontOfSize:_bottomFontSize];
}

//  设置整体字体对齐方式
- (void)setAllTextAlignment:(NSTextAlignment)textAlignment{
    self.topLabel.textAlignment = textAlignment;
    self.bottomLabel.textAlignment = textAlignment;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
