//
//  PickerView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PickerView.h"

@interface PickerView ()

@property (nonatomic, strong) UIView *pickerBgView;

//data
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation PickerView

- (instancetype)initWithTitleArray:(NSArray *)titleArray{
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
        self.titleArray = titleArray;
        [self initSubViews];
    }
    return self;
}

#pragma mark - 点击按钮
- (void)choosePurposeBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    //1.回调
    NSString *title = sender.titleLabel.text;
    if (self.delegete && [self.delegete respondsToSelector:@selector(choosePurposeWithTitle:)]) {
        [self.delegete choosePurposeWithTitle:title];
    }
    //2.隐藏picker
    [self hideMyPicker];
}

#pragma mark - 显示picker
- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *currentView = [window rootViewController].view;
    [currentView addSubview:self];
    self.pickerBgView.top = self.height;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];//不影响子视图的透明度
    [UIView animateWithDuration:0.3 animations:^{
        
        self.pickerBgView.bottom = self.height;
    }];
}

#pragma mark - 隐藏picker
- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.pickerBgView.top = self.height;
    } completion:^(BOOL finished) {
        [self.pickerBgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - init view
- (void)initSubViews {
    
    CGFloat height = 45.0 + 34.0 * self.titleArray.count + 30.0;
    self.pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, height)];
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pickerBgView];
    
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
    [titleLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    titleLabel.text = @"请选择借款用途";
    [self.pickerBgView addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, SCREEN_WIDTH, 1)];
    [lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self.pickerBgView addSubview:lineLabel];
    
    CGFloat buttonTop = 45.0;
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *button = [self creatCellButtonWithTitle:self.titleArray[i]];
        [self.pickerBgView addSubview:button];
        button.top = buttonTop;
        buttonTop = button.bottom;
    }
}

- (UIButton *)creatCellButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(14)]];
    [button setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:COLOR_WHITE_STR]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(choosePurposeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
