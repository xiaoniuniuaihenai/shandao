//
//  ZTMXFCertificationFirstFooterView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 凉 on 2018/6/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationFirstFooterView.h"

@implementation ZTMXFCertificationFirstFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(12, (self.height - 12) / 2, 4, 12)];
        view.backgroundColor = K_MainColor;
        view.layer.cornerRadius = view.width / 2;
        [self addSubview:view];
        
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(view.right + 6, (self.height - 20) / 2, KW, 20)];
        _lable.textColor = K_333333;
        _lable.font  =FONT_Regular(14 * PX);
        [self addSubview:_lable];
        self.backgroundColor = K_BackgroundColor;
    }
    return self;
}

@end
