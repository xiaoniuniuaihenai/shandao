//
//  ZTMXFShadowView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFShadowView.h"

@implementation ZTMXFShadowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = COLOR_SRT(@"#EDEAEA").CGColor;
        view.layer.borderWidth = 0.6;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        self.layer.shadowColor = COLOR_SRT(@"#C1C1C1").CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.shadowOpacity = 0.35;
        self.layer.shadowRadius = 13.0;
        self.clipsToBounds = NO;
        
     
        
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
