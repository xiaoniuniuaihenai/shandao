//
//  ZTMXFDeferredGuidePage.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFDeferredGuidePage.h"

@implementation ZTMXFDeferredGuidePage

+ (void)show{
    ZTMXFDeferredGuidePage *page = [[ZTMXFDeferredGuidePage alloc]initWithFrame:CGRectMake(0, 0, KW, KH)];
    [kKeyWindow addSubview:page];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UIImageView *imageView = [[UIImageView alloc]init];
    if (IS_IPHONEX) {
        imageView.image = [UIImage imageNamed:@"DeferredGuideImageX"];
    }else{
        imageView.image = [UIImage imageNamed:@"DeferredGuideImage"];
    }
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithColor:UIColor.clearColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColor.clearColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    button.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
}

- (void)buttonClick{
    [self removeFromSuperview];
}

@end
