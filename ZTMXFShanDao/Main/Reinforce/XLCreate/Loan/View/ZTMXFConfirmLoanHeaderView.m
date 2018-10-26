//
//  ZTMXFConfirmLoanHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFConfirmLoanHeaderView.h"

@implementation ZTMXFConfirmLoanHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.frame = CGRectMake(12, 16 * PY, KW - 24, 140 * PY);
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12 * PY, self.width, 20 * PY)];
        _textLabel.textColor = COLOR_SRT(@"#666666");
        _textLabel.font = FONT_Regular(14 * PX);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _textLabel.bottom, self.width, 50 * PY)];
        _amountLabel.textColor = COLOR_SRT(@"#F75023");
        _amountLabel.font = FONT_Regular(36 * PX);
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_amountLabel];
        
        _costLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 42 * PY, self.width, 42 * PY)];
        _costLabel.textColor = COLOR_SRT(@"#666666");
        _costLabel.font = FONT_Regular(13 * PX);
        _costLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_costLabel];
        
        UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(0, _costLabel.top + 1, self.width, 1)];
        lineview.backgroundColor = K_LineColor;
        [self addSubview:lineview];
        
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
