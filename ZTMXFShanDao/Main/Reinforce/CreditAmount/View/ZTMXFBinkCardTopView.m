//
//  ZTMXFBinkCardTopView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFBinkCardTopView.h"

@interface ZTMXFBinkCardTopView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZTMXFBinkCardTopView




- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.backgroundColor = UIColor.clearColor;
    UIView *labelBGView = [[UIView alloc]init];
    labelBGView.backgroundColor = UIColor.whiteColor;
    [self addSubview:labelBGView];
    
    [labelBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(X(-1));
        make.top.mas_equalTo(self).mas_offset(X(20));
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine. backgroundColor = COLOR_SRT(@"E6E6E6");
    [self addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(X(1));
    }];
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = K_MainColor;
    leftView.layer.cornerRadius = 3.f;
    leftView.layer.masksToBounds = YES;
    [labelBGView addSubview:leftView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(X(12));
        make.width.mas_equalTo(@(4));
        make.top.mas_equalTo(self.top).mas_offset(X(12));
        make.bottom.mas_equalTo(self.bottom).mas_offset(X(-12));
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = K_MainColor;
    self.titleLabel.font = FONT_Regular(X(14));
    [labelBGView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_right).mas_offset(X(8));
        make.centerY.mas_equalTo(labelBGView.mas_centerY);
        make.right.mas_equalTo(labelBGView.mas_right);
    }];
}
- (void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
        self.titleLabel.text = title;
    }
}
@end
