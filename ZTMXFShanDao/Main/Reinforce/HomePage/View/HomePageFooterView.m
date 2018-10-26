//
//  HomePageFooterView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "HomePageFooterView.h"

@interface HomePageFooterView ()
/** service label */
@property (nonatomic, strong) UILabel *serviceLabel;

@end

@implementation HomePageFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



- (UILabel *)serviceLabel{
    if (_serviceLabel == nil) {
        _serviceLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:11 alignment:NSTextAlignmentCenter];
    }
    return _serviceLabel;
}


//  添加子控件
- (void)setupViews{
    [self addSubview:self.serviceLabel];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
