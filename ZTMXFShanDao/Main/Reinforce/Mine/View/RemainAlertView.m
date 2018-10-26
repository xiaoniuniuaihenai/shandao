//
//  RemainAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RemainAlertView.h"

@interface RemainAlertView ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UILabel *descriptLabel;

@property (nonatomic, strong) UIButton *knowButton;

@end

@implementation RemainAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.4];
        
        [self addSubview:self.alertView];
        _alertView.center = self.center;
    }
    return self;
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AdaptedWidth(280), 200)];
        _alertView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _alertView.layer.cornerRadius = 4;
        _alertView.layer.masksToBounds = YES;
        
        [_alertView addSubview:self.titleLabel];
        [_alertView addSubview:self.lineLabel];
        [_alertView addSubview:self.descriptLabel];
        [_alertView addSubview:self.knowButton];
        
        _titleLabel.left = 26;
        _lineLabel.top = _titleLabel.bottom + 1;
        _lineLabel.left = _titleLabel.left;
        _descriptLabel.top = _lineLabel.bottom + 10;
        _descriptLabel.left = _lineLabel.left;
        _knowButton.top = _descriptLabel.bottom + 8;
        _knowButton.centerX = _alertView.width/2.0;
    }
    return _alertView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentLeft];
        [_titleLabel setFrame:CGRectMake(0, 14, _alertView.width-52, 28)];
        _titleLabel.text = @"我的余额使用说明：";
    }
    return _titleLabel;
}

-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, AdaptedWidth(227), 1)];
        _lineLabel.backgroundColor = [UIColor colorWithHexString:@"E5E5E5"];
    }
    return _lineLabel;
}

- (UILabel *)descriptLabel{
    if (!_descriptLabel) {
        _descriptLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentLeft];
        [_descriptLabel setFrame:CGRectMake(0, 0, AdaptedWidth(227), 90)];
        _descriptLabel.numberOfLines = 3;
        
        NSString *descriptStr = @"参与活动获得的现金奖励会存至余额。账户余额可直接提现，也可用于还款时抵扣。";
        NSMutableAttributedString * attLast = [[NSMutableAttributedString alloc]initWithString:descriptStr];
        //         设置行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [attLast addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attLast length])];
        _descriptLabel.attributedText = attLast;
    }
    return _descriptLabel;
}

- (UIButton *)knowButton{
    if (!_knowButton) {
        _knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_knowButton setFrame:CGRectMake(0, 0, AdaptedWidth(174), 33)];
        _knowButton.layer.borderWidth = 1;
        _knowButton.layer.borderColor = [UIColor colorWithHexString:@"D9D9D9"].CGColor;
        _knowButton.layer.cornerRadius = _knowButton.height/2.0;
        _knowButton.layer.masksToBounds = YES;
        [_knowButton setTitle:@"我知道了" forState:UIControlStateNormal];
        [_knowButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
        [_knowButton addTarget:self action:@selector(clickKnowBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _knowButton;
}

- (void)clickKnowBtn:(UIButton *)sender{
    
    [self hidden];
}

-(void)show{
    self.alpha = 1;
    self.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.4];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
