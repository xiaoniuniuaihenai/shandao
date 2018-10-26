//
//  ZTMXFFlagView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFFlagView.h"

@implementation ZTMXFFlagView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - 12, 16 * PY, 24, 24)];
        [self addSubview:_numLabel];
        _numLabel.layer.borderColor = COLOR_SRT(@"#4285E9").CGColor;
        _numLabel.layer.borderWidth = 1;
        _numLabel.layer.cornerRadius = _numLabel.height / 2;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.font = FONT_Regular(14 * PY);
        _numLabel.clipsToBounds = YES;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 30 * PY, self.width, 17 * PY)];
        [self addSubview:_titleLabel];
        _titleLabel.font = FONT_Regular(12 * PY);
        _titleLabel.textAlignment = NSTextAlignmentCenter;

        self.selected = NO;
    }
    return self;
}




- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (_selected) {
        _titleLabel.textColor = COLOR_SRT(@"#4285E9");
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.backgroundColor = COLOR_SRT(@"#4285E9");

    }else{
        _titleLabel.textColor = COLOR_SRT(@"#666666");
        _numLabel.textColor = COLOR_SRT(@"#4285E9");
        _numLabel.backgroundColor = COLOR_SRT(@"#F2F2F2");
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
