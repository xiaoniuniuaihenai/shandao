//
//  LSPeriodNoDataView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodNoDataView.h"

@interface LSPeriodNoDataView ()

@end

@implementation LSPeriodNoDataView



- (void)setPeriodType:(LSPeriodNoDataType)periodType{
    _periodType = periodType;
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, AdaptedHeight(25.0), 40.0, 43.0)];
    self.imageView.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageView.image = [UIImage imageNamed:@"XL_residueBill_nodata"];
    self.imageView.centerX = Main_Screen_Width/2.;
    [self addSubview:self.imageView];
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14.0) alignment:NSTextAlignmentCenter];
    [self.titleLabel setFrame:CGRectMake(0.0, CGRectGetMaxY(self.imageView.frame)+AdaptedHeight(16.0), self.width, AdaptedHeight(20.0))];
    [self addSubview:self.titleLabel];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self configueSubViews];
    }
    return self;
}


@end
