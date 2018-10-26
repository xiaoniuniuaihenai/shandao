//
//  ChoiseBankCardPopupView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/17.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ChoiseBankCardPopupView.h"
#import "ChoiseBankCardView.h"
#import "BankCardModel.h"

@interface ChoiseBankCardPopupView ()<ChoiseBankCardViewDelegate>

/** 蒙版 view */
@property (nonatomic, strong) UIView                *maskBackgroundView;
/** 点击蒙版手势 */
@property (nonatomic, strong) UITapGestureRecognizer *tapMaskViewGesture;
/** 横向滚动scrollView */
@property (nonatomic, strong) UIView                *whiteBackView;
/** 分期view */
@property (nonatomic, strong) ChoiseBankCardView    *choiseBankCardView;

@end

@implementation ChoiseBankCardPopupView

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

//  撤销弹出框
- (void)dismissPopView{
    [self hiddenView];
}

#pragma mark  添加子控件
- (void)setupViews{
    /** 蒙版view */
    self.maskBackgroundView = [[UIView alloc] init];
    self.maskBackgroundView.backgroundColor = [UIColor blackColor];
    self.maskBackgroundView.alpha = 0.0;
    self.maskBackgroundView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.maskBackgroundView];
    [self.maskBackgroundView addGestureRecognizer:self.tapMaskViewGesture];
    
    /** 横向scrollView */
    self.whiteBackView = [[UIView alloc] init];
    self.whiteBackView.backgroundColor = [UIColor whiteColor];
    self.whiteBackView.frame = CGRectMake(0.0, Main_Screen_Height, Main_Screen_Width, PayTypeViewHeight);
    [self addSubview:self.whiteBackView];
    
    /** 分期view */
    self.choiseBankCardView = [[ChoiseBankCardView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.whiteBackView.frame), CGRectGetHeight(self.whiteBackView.frame)) choiseBankCardViewType:CHOISE_BANK_CARD_VIEW_DEFERRED_PAYMENT];
    self.choiseBankCardView.delegate = self;
    [self.whiteBackView addSubview:self.choiseBankCardView];
    
    
}

#pragma mark  弹出付款view
+ (instancetype)popupView{
    ChoiseBankCardPopupView *popupView = [[ChoiseBankCardPopupView alloc] init];
    popupView.frame = [UIScreen mainScreen].bounds;
    popupView.backgroundColor = [UIColor clearColor];
    [kKeyWindow addSubview:popupView];
    CGRect whiteBackViewFrame = popupView.whiteBackView.frame;
    whiteBackViewFrame.origin.y = Main_Screen_Height - PayTypeViewHeight;
    [UIView animateWithDuration:0.38 animations:^{
        popupView.maskBackgroundView.alpha = 0.4;
        popupView.whiteBackView.frame = whiteBackViewFrame;
    }];
    return popupView;
}

//  撤销弹出的密码框
- (void)dismiss{
    [self hiddenView];
}

#pragma mark - 操作页面逻辑
#pragma mark  隐藏优惠view
- (void)hiddenView{
    [UIView animateWithDuration:0.28 animations:^{
        self.maskBackgroundView.alpha = 0.0;
        self.whiteBackView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, PayTypeViewHeight);
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
    self.whiteBackView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, PayTypeViewHeight);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (void)setSelectedBankCardModel:(BankCardModel *)selectedBankCardModel{
    if (_selectedBankCardModel != selectedBankCardModel) {
        _selectedBankCardModel = selectedBankCardModel;
    }
    self.choiseBankCardView.selectBankCardId = _selectedBankCardModel.rid;
}

#pragma mark - ChoiseBankCardViewDelegate 选择银行卡代理方法
//  点击返回按钮
- (void)choiseBankCardViewClickBackButton{
    [self hiddenView];
}
//  选中银行卡
- (void)choiseBankCardViewDidSelectedBankCard:(BankCardModel *)bankCardModel{
    if (bankCardModel) {
        _selectedBankCardModel = bankCardModel;
        if (self.delegate && [self.delegate respondsToSelector:@selector(choiseBankCardPopupViewSelectBankCard:)]) {
            [self.delegate choiseBankCardPopupViewSelectBankCard:bankCardModel];
        }
    }
    [self hiddenView];
}
//  添加银行卡
- (void)choiseBankCardViewAddBankCard{
    [self hiddenViewWithNoAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(choiseBankCardPopupViewAddBankCard)]) {
        [self.delegate choiseBankCardPopupViewAddBankCard];
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
