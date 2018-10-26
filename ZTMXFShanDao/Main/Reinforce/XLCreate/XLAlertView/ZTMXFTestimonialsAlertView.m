//
//  ZTMXFTestimonialsAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFTestimonialsAlertView.h"

@interface ZTMXFTestimonialsAlertView ()
@property (nonatomic, strong)UILabel * descLabel;

@property (nonatomic, strong)UIButton * mainView;

@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, strong)UILabel * fyLabel;

@property (nonatomic, strong)UIButton * confirmBtn;

@property (nonatomic, copy)void (^confirmBlock)();

@property (nonatomic, strong)UILabel * bottomLabel;

@property (nonatomic, copy)NSString * descStr;


@end


@implementation ZTMXFTestimonialsAlertView


+ (void)showWithMessage:(NSString *)message
{
    ZTMXFTestimonialsAlertView * alertView = [[ZTMXFTestimonialsAlertView alloc] init];
    alertView.descStr = message;
    [kKeyWindow addSubview:alertView];
    [alertView show];
    
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KW, KH);
        self.backgroundColor = RGB_COLOR(0, 0, 0, 0.5);
        _mainView = [UIButton buttonWithType:UIButtonTypeCustom];
        _mainView.frame = CGRectMake(0, 0, 300 * PX, 315 * PX);
        _mainView.backgroundColor = [UIColor clearColor];
//        _mainView.layer.cornerRadius = 5;
//        _mainView.clipsToBounds = YES;
        _mainView.center = self.center;
        [self addSubview:_mainView];
        
        
        _imgView = [[UIImageView alloc] initWithFrame:_mainView.bounds];
        _imgView.image = [UIImage imageNamed:@"XL_FeiYong"];
        [_mainView addSubview:_imgView];
        
        _fyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 * PX, _mainView.width, 25 * PX)];
        _fyLabel.textColor = COLOR_SRT(@"#444444");
        _fyLabel.textAlignment = NSTextAlignmentCenter;
        _fyLabel.font = FONT_Regular(18 * PX);
        _fyLabel.text = @"费用说明";
        [_mainView addSubview:_fyLabel];
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = COLOR_SRT(@"#444444");
        _descLabel.font = FONT_Regular(13 * PX);
        _descLabel.numberOfLines = 0;
        [_mainView addSubview:_descLabel];
        
        _descLabel.sd_layout
        .leftSpaceToView(_mainView, 35 * PX)
        .rightSpaceToView(_mainView, 35 * PX)
        .topSpaceToView(_fyLabel, 15)
        .autoHeightRatio(0);
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(20, _mainView.height - 60 * PX, _mainView.width - 40, 40 * PX);
        [_confirmBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:K_MainColor forState:UIControlStateNormal];
        [_mainView addSubview:_confirmBtn];
        [_confirmBtn addTarget:self action:@selector(btnACtion) forControlEvents:UIControlEventTouchUpInside];
        
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _confirmBtn.bottom - 8 , 80, 1)];
        _bottomLabel.centerX = _confirmBtn.centerX;
        _bottomLabel.backgroundColor = K_MainColor;
        [_mainView addSubview:_bottomLabel];
        
    }
    return self;
}
- (void)setDescStr:(NSString *)descStr
{
    _descStr = descStr;
    _descLabel.text = descStr;
}
- (void)show
{
    _mainView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        _mainView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)btnACtion
{
    if (_confirmBlock) {
        _confirmBlock();
    }
    [self removeFromSuperview];
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
