//
//  ZTMXFRoundButton.m
//  ZTMXFXunMiaoiOS
//
//  Created by 凉 on 2018/6/19.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFRoundButton.h"

@implementation ZTMXFRoundButton


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.layer.cornerRadius = frame.size.height / 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
