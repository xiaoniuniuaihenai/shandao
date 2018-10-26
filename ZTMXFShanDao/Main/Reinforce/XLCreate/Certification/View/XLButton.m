//
//  XLButton.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLButton.h"

@implementation XLButton



-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.layer.cornerRadius = frame.size.height / 2;

}
+(id)buttonWithType:(UIButtonType)buttonType
{
    XLButton * btn = [super buttonWithType:buttonType];
    if (btn) {
        btn.layer.cornerRadius = 3;
        btn.backgroundColor = K_MainColor;
    }
    return btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
