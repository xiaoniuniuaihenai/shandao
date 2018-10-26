//
//  LSInstallmentView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSInstallmentView.h"

@interface LSInstallmentView ()

@end

@implementation LSInstallmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:COLOR_WHITE_STR];
        
        [self setupViews];
    }
    return self;
}

#pragma mark - 点击跳转到分期账单页


//  添加子视图
- (void)setupViews{
    
    UILabel *installmentLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:14.0 alignment:NSTextAlignmentLeft];
    [installmentLabel setFrame:CGRectMake(16.0, 0, 80.0, 41 * PY)];
    installmentLabel.text = @"分期账单";
    [self addSubview:installmentLabel];
    
    // 账单日
    self.returnTimeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:13.0 alignment:NSTextAlignmentRight];
    [self.returnTimeLabel setFrame:CGRectMake(0.0, 0, 120.0, 41 * PY)];
    self.returnTimeLabel.right = SCREEN_WIDTH - 17.0;
    [self addSubview:self.returnTimeLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 41 * PY, Main_Screen_Width-32.0, 1.0)];
    [lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self addSubview:lineLabel];
    
    CGFloat width = Main_Screen_Width/2.;
    //本期应还
    self.nowReturnMoneyLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] fontSize:AdaptedWidth(24.0) alignment:NSTextAlignmentCenter];
    [self.nowReturnMoneyLabel setFont:FONT_Medium(24)];
    [self.nowReturnMoneyLabel setFrame:CGRectMake(0.0, lineLabel.bottom + 17 * PY, width, 33 * PY)];
    [self.nowReturnMoneyLabel setText:@"0.00"];
    [self addSubview:self.nowReturnMoneyLabel];
    
    UILabel *leftLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:12.0 alignment:NSTextAlignmentCenter];
    [leftLabel setFrame:CGRectMake(0.0, self.nowReturnMoneyLabel.bottom+3.0 * PY, width, 17.0 * PY)];
    [leftLabel setText:@"本期应还(元)"];
    [self addSubview:leftLabel];
    
    //剩余应还
    self.residueReturnMoneyLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] fontSize:AdaptedWidth(24.0) alignment:NSTextAlignmentCenter];
    [self.residueReturnMoneyLabel setFont:FONT_Medium(24)];
    [self.residueReturnMoneyLabel setFrame:CGRectMake(width, _nowReturnMoneyLabel.top, width, _nowReturnMoneyLabel.height)];
    [self.residueReturnMoneyLabel setText:@"0.00"];
    [self addSubview:self.residueReturnMoneyLabel];
    
    UILabel *rightLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:12.0 alignment:NSTextAlignmentCenter];
    [rightLabel setFrame:CGRectMake(width, leftLabel.top, width, leftLabel.height)];
    [rightLabel setText:@"剩余应还(元)"];
    [self addSubview:rightLabel];
    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, leftLabel.bottom+17.0, Main_Screen_Width, 10.0)];
//    [bgView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
//    [self addSubview:bgView];
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setFrame:self.bounds];
    [clickButton addTarget:self action:@selector(clickBillList) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickButton];
}
- (void)clickBillList{
    
    if (self.delegete && [self.delegete respondsToSelector:@selector(jumpToBillPeriodsVC)]) {
        [self.delegete jumpToBillPeriodsVC];
    }
}
@end
