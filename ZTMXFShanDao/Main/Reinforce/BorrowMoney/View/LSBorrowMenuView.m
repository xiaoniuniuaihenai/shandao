//
//  LSBorrowMenuView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBorrowMenuView.h"
#import "UIView+Administer.h"

#define bottomLineWidth 46.0
#define bottomLinePadding 5.0

@interface LSBorrowMenuView ()

@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIImageView *dashImageView;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *borrowLabel;

@end

@implementation LSBorrowMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    //  添加按钮背景view
    [self addSubview:self.buttonView];
    [self addSubview:self.borrowLabel];
    //  添加虚线
    [self addSubview:self.dashImageView];
    //  添加细线
    [self addSubview:self.bottomLine];
}

- (void)setBorrowDays:(NSArray *)borrowDays{
    _borrowDays = borrowDays;
    _borrowLabel.hidden = YES;
    _bottomLine.hidden = NO;
    [self.buttonView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < borrowDays.count; i++) {
        NSString *titleStr = [NSString stringWithFormat:@"%@天",[borrowDays objectAtIndex:i]];
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleBtn setTitle:titleStr forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
        titleBtn.tag = 1000 + i;
        [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:titleBtn];
        
        NSInteger buttonCount = borrowDays.count;
        if (buttonCount == 1) {
            if (i == 0) {
                _borrowLabel.hidden = NO;
                _bottomLine.hidden = YES;
                [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            }
        } else if (buttonCount == 2) {
            if (i == 0) {
                [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            } else if (i == 1) {
                [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            }
        } else if (buttonCount >= 3) {
            if (i == 0) {
                [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            } else if (i == (buttonCount - 1)) {
                [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            } else {
                [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            }
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.buttonView.frame = self.bounds;
    NSArray *buttonArray = self.buttonView.subviews;
    CGFloat btnLeft = 0.0;
    for (int i = 0; i < buttonArray.count; i ++) {
        UIButton *button = buttonArray[i];
        CGFloat btnWith = self.width / buttonArray.count;
        button.frame = CGRectMake(0.0, 0.f, btnWith, self.height);
        button.left = btnLeft;
        
        NSInteger buttonCount = buttonArray.count;
        if (buttonCount == 1) {
            if (i == 0) {
                
            }
        } else if (buttonCount == 2) {
            if (i == 0) {
                button.left = btnLeft + bottomLinePadding;
            } else if (i == 1) {
                button.left = btnLeft - bottomLinePadding;
            }
        } else if (buttonCount >= 3) {
            if (i == 0) {
                button.left = btnLeft + bottomLinePadding;
            } else if (i == (buttonCount - 1)) {
                button.left = btnLeft - bottomLinePadding;
            } else {
            }
        }
        btnLeft += btnWith;

    }
    self.borrowLabel.frame = CGRectMake(0.0, 0.0, 100.0, self.height);
    self.dashImageView.frame = CGRectMake(0.0, self.height - 3.0, self.width, 2.0);
    self.bottomLine.frame = CGRectMake(0, self.height - 4.0, bottomLineWidth, 3.0);

}

- (UIView *)buttonView{
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc] init];
    }
    return _buttonView;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        UIButton *firstBtn = [self viewWithTag:1000];
        _bottomLine = [[UIView alloc] init];
        _bottomLine.width = firstBtn.width - (_borrowDays.count == 2 ? 60 : 46);
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"f9bb43"];
        _bottomLine.layer.cornerRadius = 1.5;
        _bottomLine.layer.masksToBounds = YES;
        _bottomLine.centerX = firstBtn.centerX;
    }
    return _bottomLine;
}

- (UIImageView *)dashImageView{
    if (_dashImageView == nil) {
        _dashImageView = [[UIImageView alloc] init];
        _dashImageView.image = [UIImage imageNamed:@"homePage_dash"];
        _dashImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _dashImageView;
}

- (UILabel *)borrowLabel{
    if (_borrowLabel == nil) {
        _borrowLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:16 alignment:NSTextAlignmentLeft];
        _borrowLabel.text = @"借款天数";
        _borrowLabel.hidden = YES;
    }
    return _borrowLabel;
}

/** 设置当前选中天数 */
- (void)configCurrentIndex:(NSInteger)index animate:(BOOL)animate{
    _currentIndex = index;
    [self startBottomLineAnimationWithIndex:_currentIndex animate:animate];
}

- (void)setCurrentIndex:(NSUInteger)currentIndex{
    _currentIndex = currentIndex;
    [self startBottomLineAnimationWithIndex:currentIndex animate:YES];
}
- (void)titleBtnClicked:(UIButton *)sender{
    NSInteger currentIndex = sender.tag - 1000;
    [self startBottomLineAnimationWithIndex:currentIndex animate:YES];
    NSString *borrowDay = self.borrowDays[currentIndex];
    if ([self.delegate respondsToSelector:@selector(borrowMenuViewSelectBorrowDays:)]) {
        [self.delegate borrowMenuViewSelectBorrowDays:borrowDay];
    }
}

- (void)startBottomLineAnimationWithIndex:(NSInteger)index animate:(BOOL)animate{
    UIButton *currentBtn = [self.buttonView viewWithTag:(1000 + index)];
    NSTimeInterval animateDuration = animate ? 0.38 : 0.0;
    if (_borrowDays.count == 1) {
        [UIView animateWithDuration:animateDuration animations:^{
            self.bottomLine.centerX = currentBtn.centerX;
        }];
    } else if (_borrowDays.count == 2) {
        if (index == 0) {
            [UIView animateWithDuration:animateDuration animations:^{
                self.bottomLine.left = 0.0;
            }];
        } else if (index == 1) {
            [UIView animateWithDuration:animateDuration animations:^{
                self.bottomLine.left = self.width - bottomLineWidth;
            }];
        }
    } else if (_borrowDays.count >= 3) {
        if (index == 0) {
            [UIView animateWithDuration:animateDuration animations:^{
                self.bottomLine.left = 0.0;
            }];
        } else if (index == (_borrowDays.count - 1)) {
            [UIView animateWithDuration:animateDuration animations:^{
                self.bottomLine.left = self.width - bottomLineWidth;
            }];
        } else {
            [UIView animateWithDuration:animateDuration animations:^{
                self.bottomLine.centerX = currentBtn.centerX;
            }];
        }
    }
}


@end
