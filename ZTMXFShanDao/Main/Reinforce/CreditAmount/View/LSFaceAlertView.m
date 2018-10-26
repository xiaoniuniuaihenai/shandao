//
//  LSFaceAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSFaceAlertView.h"

@interface LSFaceAlertView ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, copy) NSString *faceCount;

@end

@implementation LSFaceAlertView

- (instancetype)initWithFaceTimes:(NSString *)faceCount{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        self.faceCount = faceCount;
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
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, AdaptedWidth(300), AdaptedWidth(320))];
    [self.alertView setBackgroundColor:[UIColor whiteColor]];
    self.alertView.center = self.center;
    self.alertView.layer.cornerRadius = 8.0;
    self.alertView.layer.masksToBounds = YES;
    
    [self addSubview:_alertView];
    
    UILabel *titltleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(18.0) alignment:NSTextAlignmentCenter];
    [titltleLabel setFrame:CGRectMake(0.0, AdaptedWidth(11.0), _alertView.width, AdaptedWidth(31.0))];
    titltleLabel.text = @"人脸识别失败";
    [_alertView addSubview:titltleLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, titltleLabel.bottom+AdaptedWidth(7.0), _alertView.width, 1.0)];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"F2F4F5"];
    [_alertView addSubview:lineLabel];
    
    UILabel *subTitltleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14.0) alignment:NSTextAlignmentCenter];
    [subTitltleLabel setFrame:CGRectMake(0.0, lineLabel.bottom+AdaptedWidth(18.0), _alertView.width, AdaptedWidth(20.0))];
    subTitltleLabel.text = @"请按照提示操作";
    [_alertView addSubview:subTitltleLabel];
    
    CGFloat width = _alertView.width/3.0;
    CGFloat left = AdaptedWidth(15.0);
    NSArray *imageArray = @[@"face_light",@"face_cap",@"face_ picture"];
    NSArray *titleArray = @[@"光线充足",@"不带帽子眼镜",@"图象清晰"];
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(left+AdaptedWidth(80))+left, subTitltleLabel.bottom+AdaptedWidth(14.0), AdaptedWidth(80.0), AdaptedWidth(68.0))];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [_alertView addSubview:imageView];
           
        UILabel *imageLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(15.0) alignment:NSTextAlignmentCenter];
        [imageLabel setFrame:CGRectMake(i*width, imageView.bottom+AdaptedWidth(8.0), width, AdaptedWidth(21.0))];
        imageLabel.text = titleArray[i];
        [_alertView addSubview:imageLabel];
        imageLabel.centerX = imageView.centerX;
    }
    
    UILabel *timeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14.0) alignment:NSTextAlignmentCenter];
    [timeLabel setFrame:CGRectMake(0.0, AdaptedWidth(223.0), _alertView.width, AdaptedWidth(20.0))];
    timeLabel.text = @"请按照提示操作";
    [_alertView addSubview:timeLabel];
    NSString *time = [NSString stringWithFormat:@"%@次",self.faceCount];
    NSString *timeStr = [NSString stringWithFormat:@"还剩%@机会，且扫且珍惜",time];
    NSMutableAttributedString *timeAttStr = [[NSMutableAttributedString alloc]initWithString:timeStr];
    [timeAttStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_RED_STR]} range:[timeStr rangeOfString:time]];
    timeLabel.attributedText = timeAttStr;
    
    UIButton *tryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tryButton setFrame:CGRectMake(0.0, timeLabel.bottom+AdaptedWidth(12), AdaptedWidth(260), AdaptedWidth(44.0))];
    tryButton.centerX = _alertView.width/2.;
    tryButton.bottom = _alertView.height-AdaptedWidth(20);
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
