//
//  ZTMXFConfirmLoanView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFConfirmLoanView.h"
#import "ZTMXFConfirmLoanHeaderView.h"

@interface ZTMXFConfirmLoanView ()

@property (nonatomic, strong)ZTMXFConfirmLoanHeaderView * confirmLoanHeaderView;

@property (nonatomic, strong)UILabel * bankLabel;


@end

@implementation ZTMXFConfirmLoanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _confirmLoanHeaderView = [[ZTMXFConfirmLoanHeaderView alloc] initWithFrame:CGRectMake(12, 16, KW - 24, 140 * PY)];
        [self addSubview:_confirmLoanHeaderView];
        
        for (int i = 0; i < 2; i++) {
//            UILabel * lab = [UILabel ]
        }
        
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
