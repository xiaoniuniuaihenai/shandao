//
//  OrderPayProcessView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderPayProcessView.h"

@interface OrderPayProcessView ()

/** 处理中icon */
@property (nonatomic, strong) UIImageView *processIcon;
/** 首页按钮 */
@property (nonatomic, strong) UIButton *homePageButton;

@end

@implementation OrderPayProcessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    /** 处理中icon */
    [self addSubview:self.processIcon];
    /** 处理中title */
    [self addSubview:self.processTitleLabel];
    /** 处理中描述 */
    [self addSubview:self.processDescrition];
    /** 首页按钮 */
    [self addSubview:self.homePageButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = AdaptedWidth(20.0);
    /** 处理中icon */
    CGFloat processIconW = AdaptedWidth(80.0);
    CGFloat processIconX = (Main_Screen_Width - processIconW) / 2.0;
    CGFloat processIconY = AdaptedHeight(30.0);
    self.processIcon.frame = CGRectMake(processIconX, processIconY, processIconW, processIconW);
    /** 处理中title */
    self.processTitleLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.processIcon.frame) + AdaptedHeight(38.0), Main_Screen_Width, AdaptedHeight(22.0));
    /** 处理中描述 */
    CGFloat processDescritionW = Main_Screen_Width - leftMargin * 2;
    CGFloat processDescritionH = [self.processDescrition.text sizeWithFont:self.processDescrition.font maxW:processDescritionW].height;
    self.processDescrition.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.processTitleLabel.frame) + AdaptedHeight(9.0), processDescritionW, processDescritionH);
    /** 首页按钮 */
    CGFloat buttonWidth = AdaptedWidth(136.0);
    CGFloat buttonHeight = AdaptedHeight(36.0);
    CGFloat homePageButtonX = (Main_Screen_Width - buttonWidth) / 2.0;
    CGFloat homePageButtonY = CGRectGetMaxY(self.processDescrition.frame) + AdaptedHeight(50.0);
    self.homePageButton.frame = CGRectMake(homePageButtonX, homePageButtonY, buttonWidth, buttonHeight);

}

#pragma mark - setter/setter
/** 处理中icon */
- (UIImageView *)processIcon{
    if (_processIcon == nil) {
        _processIcon = [[UIImageView alloc] init];
        _processIcon.contentMode = UIViewContentModeScaleAspectFit;
        _processIcon.image = [UIImage imageNamed:@"XL_mallAuth_progress"];
    }
    return _processIcon;
}

/** 处理中title */
- (UILabel *)processTitleLabel{
    if (_processTitleLabel == nil) {
        _processTitleLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:18 alignment:NSTextAlignmentCenter];
        _processTitleLabel.text = @"";
    }
    return _processTitleLabel;
}
/** 处理中描述 */
- (UILabel *)processDescrition{
    if (_processDescrition == nil) {
        _processDescrition = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:14 alignment:NSTextAlignmentCenter];
        _processDescrition.text = @"";
    }
    return _processDescrition;
}
/** 首页按钮 */
- (UIButton *)homePageButton{
    if (_homePageButton == nil) {
        _homePageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_homePageButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
        _homePageButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_homePageButton setTitle:@"首页" forState:UIControlStateNormal];
        _homePageButton.layer.cornerRadius = AdaptedHeight(36.0) / 2.0;
        _homePageButton.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
        _homePageButton.layer.borderWidth = 1.0;
        [_homePageButton addTarget:self action:@selector(homePageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homePageButton;
}

#pragma mark - 按钮点击事件
/** 返回首页 */
- (void)homePageButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderPayProcessViewReturnHomePage)]) {
        [self.delegate orderPayProcessViewReturnHomePage];
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
