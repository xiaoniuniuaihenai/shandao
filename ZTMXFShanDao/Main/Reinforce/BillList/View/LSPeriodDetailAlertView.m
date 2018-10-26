//
//  LSPeriodDetailAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodDetailAlertView.h"
#import "MallBillInfoModel.h"

@interface LSPeriodDetailAlertView ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *returnMoneyLabel;

@property (nonatomic, strong) UILabel *interstLabel;

@property (nonatomic, strong) UILabel *ovestatusLabel;

@property (nonatomic, strong) UILabel *lastDateLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LSPeriodDetailAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self configueSubViews];
    }
    return self;
}



-(void)show{
    self.alpha = 1;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
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
- (void)clickCloseBtn:(UIButton *)sender{
    
    [self hidden];
}
#pragma mark - setter
- (void)setMallListModel:(MallBillListModel *)mallListModel{
    _mallListModel = mallListModel;
    if (_mallListModel) {
        
        self.returnMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",[NSDecimalNumber stringWithFloatValue:_mallListModel.billPrinciple]];
        self.interstLabel.text = [NSString stringWithFormat:@"¥ %@",[NSDecimalNumber stringWithFloatValue:_mallListModel.interest]];
        self.ovestatusLabel.text = [NSString stringWithFormat:@"¥ %@",[NSDecimalNumber stringWithFloatValue:_mallListModel.overdueAmount]];
        self.lastDateLabel.text = [NSDate dateYMDacrossStringFromLongDate:_mallListModel.gmtPlanRepay];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-AdaptedWidth(56), AdaptedHeight(260.0))];
    [self.alertView setBackgroundColor:[UIColor whiteColor]];
    self.alertView.center = self.center;
    self.alertView.layer.cornerRadius = 4.0;
    self.alertView.layer.masksToBounds = YES;
    [self addSubview:_alertView];
    
    CGFloat width = (self.alertView.width - AdaptedWidth(32))/2.;
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_WHITE_STR] fontSize:18 alignment:NSTextAlignmentCenter];
    [self.titleLabel setFrame:CGRectMake(0.0, 0.0, _alertView.width, AdaptedHeight(53))];
    self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"2BADF0"];
    self.titleLabel.text = @"应还明细";
    [_alertView addSubview:self.titleLabel];
    
    UILabel *labelOne = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    [labelOne setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.titleLabel.frame), width, AdaptedHeight(48))];
    labelOne.text = @"应还本金";
    [_alertView addSubview:labelOne];
    
    self.returnMoneyLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:17 alignment:NSTextAlignmentRight];
    [self.returnMoneyLabel setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.titleLabel.frame), width, AdaptedHeight(48))];
    self.returnMoneyLabel.right = _alertView.width - AdaptedWidth(16.0);
    [_alertView addSubview:self.returnMoneyLabel];
    
    UILabel *lineOne = [[UILabel alloc] initWithFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.returnMoneyLabel.frame), width*2, 1)];
    [lineOne setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [_alertView addSubview:lineOne];
    
    UILabel *labelTwo = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    [labelTwo setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.returnMoneyLabel.frame)+1.0, width, AdaptedHeight(48))];
    labelTwo.text = @"应还利息";
    [_alertView addSubview:labelTwo];
    
    self.interstLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:17 alignment:NSTextAlignmentRight];
    [self.interstLabel setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.returnMoneyLabel.frame), width, AdaptedHeight(48))];
    self.interstLabel.right = _alertView.width - AdaptedWidth(16.0);
    [_alertView addSubview:self.interstLabel];
    
    UILabel *lineTwo = [[UILabel alloc] initWithFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.interstLabel.frame), width*2, 1)];
    [lineTwo setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [_alertView addSubview:lineTwo];
    
    UILabel *labelThree = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    [labelThree setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.interstLabel.frame)+1.0, width, AdaptedHeight(48))];
    labelThree.text = @"应还逾期费";
    [_alertView addSubview:labelThree];
    
    self.ovestatusLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:17 alignment:NSTextAlignmentRight];
    [self.ovestatusLabel setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.interstLabel.frame), width, AdaptedHeight(48))];
    self.ovestatusLabel.right = _alertView.width - AdaptedWidth(16.0);
    [_alertView addSubview:self.ovestatusLabel];
    
    UILabel *lineThree = [[UILabel alloc] initWithFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.ovestatusLabel.frame), width*2, 1)];
    [lineThree setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [_alertView addSubview:lineThree];
    
    UILabel *labelFour = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    [labelFour setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.ovestatusLabel.frame)+1.0, width, AdaptedHeight(48))];
    labelFour.text = @"最后还款日";
    [_alertView addSubview:labelFour];
    
    self.lastDateLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:17 alignment:NSTextAlignmentRight];
    [self.lastDateLabel setFrame:CGRectMake(AdaptedWidth(16.0), CGRectGetMaxY(self.ovestatusLabel.frame), width, AdaptedHeight(48))];
    self.lastDateLabel.right = _alertView.width - AdaptedWidth(16.0);
    [_alertView addSubview:self.lastDateLabel];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.alertView.frame)+AdaptedHeight(35.0), 26.0, 26.0)];
    self.imageView.centerX = self.width/2.;
    self.imageView.image = [UIImage imageNamed:@"closeWhite"];
    [self addSubview:self.imageView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(0, CGRectGetMaxY(self.alertView.frame)+AdaptedHeight(20.0), AdaptedWidth(60), AdaptedHeight(60))];
    closeButton.centerX = self.width/2.;
    [closeButton addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
}

@end
