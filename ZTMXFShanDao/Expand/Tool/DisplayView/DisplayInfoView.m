//
//  DisplayInfoView.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/30.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "DisplayInfoView.h"

@interface DisplayInfoView ()

/** 蒙版 view */
@property (nonatomic, strong) UIView    *maskBackgroundView;
/** 点击蒙版手势 */
@property (nonatomic, strong) UITapGestureRecognizer    *tapMaskViewGesture;
/** 横向滚动scrollView */
@property (nonatomic, strong) UIView    *whiteBackView;
/** rule textView */
@property (nonatomic, strong) UITextView *ruleTextView;
/** lineView */
@property (nonatomic, strong) UIView *lineView;
/** 其他描述label */
@property (nonatomic, strong) UILabel *otherDescribeLabel;

/** 知道了按钮 */
@property (nonatomic, strong) UIButton *knowButton;

@end

@implementation DisplayInfoView



+ (instancetype)popupViewWithInfo:(NSString *)info{
    DisplayInfoView *popupView = [[DisplayInfoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSString *infoString = [NSString string];
    if (![info isKindOfClass:[NSString class]]) {
        infoString = @"不是字符串";
    } else {
        infoString = info;
    }
    popupView.ruleTextView.attributedText = [[NSAttributedString alloc] initWithString:infoString attributes:attributes];
    [[[UIApplication sharedApplication] keyWindow] addSubview:popupView];
    CGFloat InviteRuleViewW = 280.0;
    CGFloat InviteRuleViewH = 200.0;
    CGFloat buttonWidth = 170.0;
    CGFloat buttonHeight = 32.0;
    popupView.whiteBackView.frame = CGRectMake((Main_Screen_Width - InviteRuleViewW) / 2.0, (Main_Screen_Height - InviteRuleViewH) / 2.0, InviteRuleViewW, InviteRuleViewH);
    popupView.ruleTextView.frame = CGRectMake(14.0, 20.0, InviteRuleViewW - 28.0, 80.0);
    popupView.lineView.frame = CGRectMake(CGRectGetMinX(popupView.ruleTextView.frame), CGRectGetMaxY(popupView.ruleTextView.frame), CGRectGetWidth(popupView.ruleTextView.frame), 1);
    popupView.otherDescribeLabel.frame = CGRectMake(CGRectGetMinX(popupView.ruleTextView.frame), CGRectGetMaxY(popupView.lineView.frame), CGRectGetWidth(popupView.ruleTextView.frame), 30.0);
    popupView.knowButton.frame = CGRectMake((InviteRuleViewW - buttonWidth) / 2.0, CGRectGetMaxY(popupView.otherDescribeLabel.frame) + 15.0, buttonWidth, buttonHeight);
    popupView.whiteBackView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.38 animations:^{
        popupView.maskBackgroundView.alpha = 0.4;
        popupView.whiteBackView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    return popupView;
    
}
//  懒加载手势
- (UITapGestureRecognizer *)tapMaskViewGesture{
    if (_tapMaskViewGesture == nil) {
        _tapMaskViewGesture = [[UITapGestureRecognizer alloc] init];
        [_tapMaskViewGesture addTarget:self action:@selector(hiddenView)];
    }
    return _tapMaskViewGesture;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  添加子控件
        [self setupViews];
    }
    return self;
}

#pragma mark  添加子控件
- (void)setupViews{
    /** 蒙版view */
    self.maskBackgroundView = [[UIView alloc] init];
    self.maskBackgroundView.backgroundColor = [UIColor blackColor];
    self.maskBackgroundView.alpha = 0.0;
    self.maskBackgroundView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.maskBackgroundView];
    //    [self.maskBackgroundView addGestureRecognizer:self.tapMaskViewGesture];
    
    /** 横向scrollView */
    self.whiteBackView = [[UIView alloc] init];
    self.whiteBackView.backgroundColor = [UIColor whiteColor];
    self.whiteBackView.frame = CGRectMake(Main_Screen_Width / 2.0, 365.0, 1.0, 1.0);
    self.whiteBackView.center = self.maskBackgroundView.center;
    self.whiteBackView.layer.cornerRadius = 10.0;
    self.whiteBackView.clipsToBounds = YES;
    [self addSubview:self.whiteBackView];
    
    
    self.ruleTextView = [[UITextView alloc] init];
    self.ruleTextView.frame = CGRectMake(0.0, 0.0, 1.0, 1.0);
    self.ruleTextView.backgroundColor = [UIColor whiteColor];
    self.ruleTextView.font = [UIFont systemFontOfSize:14.0];
    self.ruleTextView.textColor = [UIColor blackColor];
    self.ruleTextView.editable = NO;
    [self.whiteBackView addSubview:self.ruleTextView];
    
    self.lineView = [UIView setupViewWithSuperView:self.whiteBackView withBGColor:COLOR_DEEPBORDER_STR];
    
    self.otherDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_RED_STR fontSize:14 alignment:NSTextAlignmentLeft];
    self.otherDescribeLabel.text = @"本次还款额越高, 延期手续费越低";
    [self.whiteBackView addSubview:self.otherDescribeLabel];
    
    self.knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.knowButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [self.knowButton addTarget:self action:@selector(knowButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.knowButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.knowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.knowButton.backgroundColor = [UIColor clearColor];
    self.knowButton.layer.borderWidth = 1.0;
    self.knowButton.layer.borderColor = [UIColor colorWithHexString:COLOR_DEEPBORDER_STR].CGColor;
    self.knowButton.layer.cornerRadius = 16.0;
    self.knowButton.clipsToBounds = YES;
    [self.whiteBackView addSubview:self.knowButton];
}



#pragma mark  隐藏优惠view
- (void)hiddenView{
    [UIView animateWithDuration:0.38 animations:^{
        self.maskBackgroundView.alpha = 0.0;
        self.whiteBackView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}

#pragma mark  无动画隐藏view
- (void)hiddenViewWithNoAnimation{
    self.maskBackgroundView.alpha = 0.0;
    self.whiteBackView.frame = CGRectMake(0.0, 0.0, 1.0, 1.0);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
#pragma mark - 知道了点击按钮
- (void)knowButtonAction{
    [self hiddenView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
