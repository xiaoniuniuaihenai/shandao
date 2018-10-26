//
//  ZTMXFSetPasswordAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFSetPasswordAlertView.h"

@interface ZTMXFSetPasswordAlertView ()

@property (nonatomic, strong)UIButton * whiteView;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UIButton * setBtn;

@property (nonatomic, copy)void(^clickBtn)(void);


@end


@implementation ZTMXFSetPasswordAlertView


+ (void)showMessage:(NSString *)message ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click
{
    ZTMXFSetPasswordAlertView * alert = [[ZTMXFSetPasswordAlertView alloc] init];
    alert.clickBtn = ^{
        click();
    };
    [kKeyWindow addSubview:alert];
    [alert show];

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:.3 animations:^{
        _whiteView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KW, KH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        _whiteView = [UIButton buttonWithType:UIButtonTypeCustom];
        _whiteView.frame = CGRectMake(0, 0, 300 * PX, 200 * PX);
        [self addSubview:_whiteView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 4 * PX;
        _whiteView.center = self.center;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, _whiteView.width - 40, _whiteView.height - 80 * PX)];
        _titleLabel.text = @"您还没有设置过支付密码，为了您的账户安全，请先设置支付密码";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = COLOR_SRT(@"#333333");
        _titleLabel.font = FONT_Regular(16 * PX);
        [_whiteView addSubview:_titleLabel];
        
        _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setBtn.frame = CGRectMake(35, _titleLabel.bottom + 5, _whiteView.width - 70, 40 * PX );
        [_setBtn setTitle:@"去设置支付密码" forState:UIControlStateNormal];
        _setBtn.backgroundColor = K_MainColor;
        [_setBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _setBtn.layer.cornerRadius = 3;
        [_whiteView addSubview:_setBtn];
        
//        _whiteView.transform = CGAffineTransformMakeScale(0.01, 0.01);

    }
    return self;
}

- (void)setBtnAction
{
    [UIView animateWithDuration:.3 animations:^{
        _whiteView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        if (self.clickBtn) {
            _clickBtn();
        }
        [self removeFromSuperview];
    }];
}

- (void)show
{
    _whiteView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        _whiteView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
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
