//
//  LSIdentityAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSIdentityAlertView.h"

@interface LSIdentityAlertView ()

@property (nonatomic, strong) UIView *alertView;

@end

@implementation LSIdentityAlertView

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        [self configueSubViews];
    }
    return self;
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
- (void)clicTryButton:(UIButton *)sender{
    
    [self hidden];
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickTryButton)]) {
        [self.delegete clickTryButton];
    }
}
#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,AdaptedWidth(300), AdaptedWidth(320))];
    [self.alertView setBackgroundColor:[UIColor whiteColor]];
    self.alertView.center = self.center;
    self.alertView.layer.cornerRadius = 8.0;
    self.alertView.layer.masksToBounds = YES;
    
    [self addSubview:_alertView];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AdaptedWidth(79), 12.0, 16.0, 16.0)];
//    imageView.image = [UIImage imageNamed:@"identity_remind"];
//    [_alertView addSubview:imageView];
    
    UILabel *titltleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(18.0) alignment:NSTextAlignmentCenter];
    [titltleLabel setFrame:CGRectMake(AdaptedWidth(8.0), AdaptedWidth(12.0), _alertView.width-AdaptedWidth(16), AdaptedWidth(22.0))];
    titltleLabel.text = @"怎么样提高识别率";
    [_alertView addSubview:titltleLabel];
//    imageView.centerY = titltleLabel.centerY;
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, titltleLabel.bottom+AdaptedWidth(12.0), _alertView.width, 1.0)];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"F2F4F5"];
    [_alertView addSubview:lineLabel];
    
    UILabel *firstLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16.0) alignment:NSTextAlignmentCenter];
    [firstLabel setFrame:CGRectMake(0.0, lineLabel.bottom+AdaptedWidth(15.0), _alertView.width, AdaptedWidth(26.0))];
    [_alertView addSubview:firstLabel];
    NSString *firstLabelStr = @"将身份证的边框与提示框对齐";
    NSMutableAttributedString *firstAttStr = [[NSMutableAttributedString alloc]initWithString:firstLabelStr];
    [firstAttStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_RED_STR]} range:[firstLabelStr rangeOfString:@"对齐"]];
    firstLabel.attributedText = firstAttStr;
    
    UILabel *secondLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16.0) alignment:NSTextAlignmentCenter];
    [secondLabel setFrame:CGRectMake(0.0, firstLabel.bottom, _alertView.width, AdaptedWidth(26.0))];
    [_alertView addSubview:secondLabel];
    NSString *secondLabelStr = @"并保持图像清晰";
    NSMutableAttributedString *secondAttStr = [[NSMutableAttributedString alloc]initWithString:secondLabelStr];
    [secondAttStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_RED_STR]} range:[secondLabelStr rangeOfString:@"图像清晰"]];
    secondLabel.attributedText = secondAttStr;
    
    UIImageView *faceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, secondLabel.bottom+AdaptedWidth(20.0), AdaptedWidth(160), AdaptedWidth(96))];
    faceImgView.centerX = _alertView.width/2.;
    faceImgView.image = [UIImage imageNamed:@"identity_faceIcon"];
    [_alertView addSubview:faceImgView];
    
    UIButton *tryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tryButton setFrame:CGRectMake(0.0, faceImgView.bottom+AdaptedWidth(20.0), AdaptedWidth(260), AdaptedWidth(44.0))];
    tryButton.centerX = _alertView.width/2.;
    [tryButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16.0)]];
    [tryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tryButton setTitle:@"再试试" forState:UIControlStateNormal];
    [tryButton setBackgroundColor:[UIColor colorWithHexString:@"2BADF0"]];
    tryButton.layer.cornerRadius = tryButton.height/2.;
    tryButton.layer.masksToBounds = YES;
    [_alertView addSubview:tryButton];
    [tryButton addTarget:self action:@selector(clicTryButton:) forControlEvents:UIControlEventTouchUpInside];
}

@end
