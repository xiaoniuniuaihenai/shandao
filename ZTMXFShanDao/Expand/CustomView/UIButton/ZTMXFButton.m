//
//  LSButton.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFButton.h"

@implementation ZTMXFButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];

        self.layer.cornerRadius = 3;
        self.backgroundColor = K_MainColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
