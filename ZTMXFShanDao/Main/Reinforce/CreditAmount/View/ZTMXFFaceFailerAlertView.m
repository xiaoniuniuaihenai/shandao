//
//  ZTMXFFaceFailureAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFFaceFailerAlertView.h"
#import "UILabel+Attribute.h"
@interface ZTMXFFaceFailerAlertView ()

@property (nonatomic, strong)UIButton * whiteView;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UILabel * descLabel;

@property (nonatomic, copy)NSString * countStr;


@property (nonatomic, copy)void(^clickBtn)(void);

@end




@implementation ZTMXFFaceFailerAlertView


+ (void)showWithCountStr:(NSString *)countStr click:(ClickHandle)click;
{
    ZTMXFFaceFailerAlertView * alert = [[ZTMXFFaceFailerAlertView alloc] init];
    alert.clickBtn = ^{
        click();
    };
    alert.countStr = countStr;
    [kKeyWindow addSubview:alert];
    [alert show];
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KW, KH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        _whiteView = [UIButton buttonWithType:UIButtonTypeCustom];
        _whiteView.frame = CGRectMake(X(75/2), KH, X(300), X(220));
        _whiteView.userInteractionEnabled = YES;
        _whiteView.layer.cornerRadius = X(10);
        [self addSubview:_whiteView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, X(30), X(300), 40 * PX)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = K_333333;
        _titleLabel.font = FONT_Regular(20 * PX);
        
        _titleLabel.text = @"人脸识别失败!";
        [_whiteView addSubview:_titleLabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom + X(20), _whiteView.width, X(30))];
        _descLabel.text = @"仅剩3次机会，超限将7天后再试";
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.textColor = K_666666;
        _descLabel.numberOfLines = 0;
        _descLabel.font = FONT_Regular(X(16));
        [_whiteView addSubview:_descLabel];
        
        UIButton * _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setBtn.frame = CGRectMake(X(35), _whiteView.height - X(78), _whiteView.width - X(70), X(44));
        [_setBtn setTitle:@"再试试" forState:UIControlStateNormal];
        _setBtn.backgroundColor = K_MainColor;
        [_setBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _setBtn.layer.cornerRadius = _setBtn.height/2;
        [_whiteView addSubview:_setBtn];
        
    }
    return self;
}

- (void)setBtnAction
{
    if (_clickBtn) {
        _clickBtn();
    }
    [self removeFromSuperview];
}

- (void)show
{
    [UIView animateWithDuration:.3f animations:^{
        _whiteView.frame = CGRectMake((KW - X(300))/2, (KH - X(220))/2,X(300), X(220));
    }];
}
- (void)setCountStr:(NSString *)countStr
{
    _countStr = countStr;
    _descLabel.text = [NSString stringWithFormat:@"仅剩%@次机会，超限将7天后再试", countStr];
    NSString * str = [NSString stringWithFormat:@"%@次机会", countStr];
    [UILabel attributeWithLabel:_descLabel text:_descLabel.text textColor:@"666666" attributes:@[str] attributeColors:@[K_MainColor]];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
