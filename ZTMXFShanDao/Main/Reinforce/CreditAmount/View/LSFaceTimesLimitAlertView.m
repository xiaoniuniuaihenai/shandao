//
//  LSFaceTimesLimitAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSFaceTimesLimitAlertView.h"

@interface LSFaceTimesLimitAlertView ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, copy) NSString *faceDate;

@end

@implementation LSFaceTimesLimitAlertView



- (void)clickKnowBtn:(UIButton *)sender{
    
    [self hidden];
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickKnowButton)]) {
        [self.delegete clickKnowButton];
    }
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
- (instancetype)initWithFaceDate:(NSString *)faceDate{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        self.faceDate = faceDate;
        [self configueSubViews];
    }
    return self;
}
#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, AdaptedWidth(300), AdaptedWidth(220.0))];
    [self.alertView setBackgroundColor:[UIColor whiteColor]];
    self.alertView.center = self.center;
    self.alertView.layer.cornerRadius = 9.0;
    self.alertView.layer.masksToBounds = YES;
    [self addSubview:_alertView];
    
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"000000"] fontSize:AdaptedWidth(18) alignment:NSTextAlignmentCenter];
    [titleLabel setFrame:CGRectMake(0.0, X(46), _alertView.width, AdaptedWidth(24.0))];
    titleLabel.text = @"人脸识别次数已超限";
    [_alertView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(18) alignment:NSTextAlignmentCenter];
    [subTitleLabel setFrame:CGRectMake(0.0, titleLabel.bottom, _alertView.width, 24.0)];
//    subTitleLabel.text = @"人脸识别次数超限";
    [_alertView addSubview:subTitleLabel];
    NSString *dateStr = [NSString stringWithFormat:@"请于%@再试",self.faceDate];
    NSMutableAttributedString *timeAttStr = [[NSMutableAttributedString alloc]initWithString:dateStr];
    [timeAttStr addAttributes:@{NSForegroundColorAttributeName:K_MainColor} range:[dateStr rangeOfString:self.faceDate]];
    subTitleLabel.attributedText = timeAttStr;
    
    UIButton *knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [knowButton setFrame:CGRectMake(X(35), self.alertView.height - X(78), X(230),X(44))];
    knowButton.bottom = _alertView.height-AdaptedWidth(34);
    knowButton.centerX = _alertView.width/2.;
    [knowButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(14.0)]];
    [knowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [knowButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [knowButton.titleLabel setFont:FONT_Medium(X(16))];
    knowButton.layer.cornerRadius = knowButton.height/2.;
//    knowButton.layer.borderWidth = 1.0;
//    knowButton.layer.borderColor = [UIColor colorWithHexString:@"D9D9D9"].CGColor;
    knowButton.layer.masksToBounds = YES;
    [knowButton setBackgroundColor:K_MainColor];
    [knowButton addTarget:self action:@selector(clickKnowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:knowButton];
}

@end
