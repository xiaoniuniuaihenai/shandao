//
//  BorderButton.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/25.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ZTMXFBorderButton.h"

@implementation ZTMXFBorderButton



- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.layer.borderColor = [UIColor colorWithHexString:COLOR_BLUE_STR].CGColor;
    } else {
        self.layer.borderColor = [UIColor colorWithHexString:@"DFDFDF"].CGColor;
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] forState:UIControlStateNormal];
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithHexString:@"DFDFDF"].CGColor;
        self.layer.cornerRadius = 4.0;
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
