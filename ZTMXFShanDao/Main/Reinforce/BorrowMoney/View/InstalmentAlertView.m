//
//  InstalmentAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "InstalmentAlertView.h"

@interface InstalmentAlertView ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic,assign) NSInteger periodNum;

@property (nonatomic, assign) CGFloat amountMoney;

@end

@implementation InstalmentAlertView

- (instancetype)initWithInstalmentDays:(NSString *)days amountMoney:(CGFloat)amount{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        self.periodNum = [days integerValue]/30;
        self.amountMoney = amount;
        
        [self configueSubViews];
    }
    return self;
}

- (void)clickKnowBtn:(UIButton *)sender{
    
    [self hidden];
}

-(void)show{
    self.alpha = 1;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:.2 animations:^{
        _alertView.alpha = 1;
    }];
}
-(void)hidden{
    [UIView animateWithDuration:.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    CGFloat totalHeight = 152.0 + 30.0*self.periodNum + 90.0;
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AdaptedWidth(300), totalHeight)];
    [self.alertView setBackgroundColor:[UIColor whiteColor]];
    self.alertView.center = self.center;
    self.alertView.layer.cornerRadius = 8.0;
    self.alertView.layer.masksToBounds = YES;
    
    [self addSubview:_alertView];
    
//    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [titleButton setFrame:CGRectMake(0, 15, 100, 28)];
//    titleButton.centerX = self.alertView.width/2.0;
//    [titleButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
//    [titleButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
//    [titleButton setTitle:@"分期明细" forState:UIControlStateNormal];
    UILabel * lbTitle = [[UILabel alloc]init];
    [lbTitle setFrame:CGRectMake(0, 0, _alertView.width, AdaptedWidth(50))];
    [lbTitle setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
    [lbTitle setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = @"分期明细";
    [_alertView addSubview:lbTitle];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, lbTitle.bottom, _alertView.width - 10.0, 1)];
    [lineLabel setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [_alertView addSubview:lineLabel];
    
    UILabel *leftLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
    [leftLabel setFrame:CGRectMake(0, lineLabel.bottom+11, _alertView.width/2.0-1.0, 20)];
    leftLabel.text = @"分期金额";
    [_alertView addSubview:leftLabel];
    
    UILabel *amountLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
    [amountLabel setFrame:CGRectMake(0, leftLabel.bottom+2, _alertView.width/2.0-1.0, 22)];
    amountLabel.text = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:self.amountMoney]];
    [_alertView addSubview:amountLabel];
    
    UILabel *centerLine = [[UILabel alloc] initWithFrame:CGRectMake(_alertView.width/2., lineLabel.bottom+AdaptedWidth(18), 1, AdaptedWidth(30))];
    [centerLine setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [_alertView addSubview:centerLine];
    
    UILabel *rightLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
    [rightLabel setFrame:CGRectMake(_alertView.width/2.0+1.0, lineLabel.bottom+11, _alertView.width/2.0-1.0, 20)];
    rightLabel.text = @"分期期数";
    [_alertView addSubview:rightLabel];
    
    UILabel *periodLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
    [periodLabel setFrame:CGRectMake(_alertView.width/2.0+1.0, rightLabel.bottom+2, _alertView.width/2.0-1.0, 22)];
    periodLabel.text = [NSString stringWithFormat:@"%ld期",self.periodNum];
    [_alertView addSubview:periodLabel];
    
    UILabel *lineLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(5.0, lineLabel.bottom+AdaptedWidth(64), _alertView.width-10.0, 1)];
    [lineLabelTwo setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [_alertView addSubview:lineLabelTwo];
    
    CGFloat width = _alertView.width/3.;
    
    UILabel *firstLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
    [firstLabel setFrame:CGRectMake(0, lineLabelTwo.bottom+19, width, 20)];
    firstLabel.text = @"期数";
    [_alertView addSubview:firstLabel];
    
    UILabel *secondLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
    [secondLabel setFrame:CGRectMake(firstLabel.right, firstLabel.top, width, 20)];
    secondLabel.text = @"还款日期";
    [_alertView addSubview:secondLabel];
    
    UILabel *thirdLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
    [thirdLabel setFrame:CGRectMake(secondLabel.right, secondLabel.top, width, 20)];
    thirdLabel.text = @"还款金额";
    [_alertView addSubview:thirdLabel];
    
    CGFloat top = firstLabel.bottom + 4.0;
    for (int i=0; i<self.periodNum; i++) {
        UIView *view = [self createPeriodViewWithPeriod:i+1];
        [_alertView addSubview:view];
        view.top = top;
        top = view.bottom;
    }
    
//    UILabel *lineLabelThird = [[UILabel alloc] initWithFrame:CGRectMake(10.0, top+15.0, _alertView.width-20.0, 1)];
//    [lineLabelThird setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
//    [_alertView addSubview:lineLabelThird];
    
    UIButton *knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [knowButton setFrame:CGRectMake(0,0, AdaptedWidth(260), AdaptedWidth(44))];
    knowButton.centerX = _alertView.width/2.;
    [knowButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
    [knowButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [knowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [knowButton setBackgroundColor:[UIColor colorWithHexString:@"2BADF0"]];
    [knowButton addTarget:self action:@selector(clickKnowBtn:) forControlEvents:UIControlEventTouchUpInside];
    knowButton.layer.cornerRadius = knowButton.height/2.;
    knowButton.bottom = _alertView.height - AdaptedWidth(20.);
    [_alertView addSubview:knowButton];
}

- (UIView *)createPeriodViewWithPeriod:(NSInteger)period{
    UIView *periodView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [periodView setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat width = _alertView.width/3.;
    CGFloat amount = self.amountMoney/self.periodNum;
    
    NSString *periodStr = [NSString stringWithFormat:@"第%ld期",period];
    NSString *periodDate = [self getPeriodDateWithPeriod:period];
    
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
    [titleLabel setFrame:CGRectMake(0, 0, width, 30)];
    titleLabel.text = periodStr;
    [periodView addSubview:titleLabel];
    
    UILabel *periodDateLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
    [periodDateLabel setFrame:CGRectMake(titleLabel.right, 0, width, 30)];
    periodDateLabel.text = periodDate;
    [periodView addSubview:periodDateLabel];
    
    UILabel *amountLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
    [amountLabel setFrame:CGRectMake(periodDateLabel.right, 0, width, 30)];
    NSString *amountStr = [NSString stringWithFormat:@"%.2f",amount];;
    amountLabel.text = [NSString stringWithFormat:@"%@元",amountStr];
    [periodView addSubview:amountLabel];
    
    return periodView;
}

#pragma mark - 获取分期还款时间
- (NSString *)getPeriodDateWithPeriod:(NSInteger)period{
    
    NSTimeInterval firstPeriod = 24*60*60*1*29;  //1期的长度
    NSTimeInterval otherPeriod = 24*60*60*1*30;  //1期的长度
    NSDate *periodDate = [[NSDate date] initWithTimeIntervalSinceNow: + (firstPeriod+otherPeriod*(period-1))];
    
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSString*dateTime = [formatter stringFromDate:periodDate];
    
    return dateTime;
}

@end
