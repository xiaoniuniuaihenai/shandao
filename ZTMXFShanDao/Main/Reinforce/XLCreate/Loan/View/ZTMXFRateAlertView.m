//
//  ZTMXFRateAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFRateAlertView.h"
#import "UILabel+Attribute.h"

@interface ZTMXFRateAlertView ()

@property (nonatomic, strong)UILabel * descLabel;

@property (nonatomic, strong)UIButton * mainView;

@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, strong)UILabel * fyLabel;

@property (nonatomic, strong)UIButton * confirmBtn;

@property (nonatomic, assign)ZTMXFRateAlertViewStyle rateAlertViewStyle;

@property (nonatomic, copy)void (^confirmBlock)();

@property (nonatomic, strong)UILabel * messageLabel;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * message;

@property (nonatomic, strong)UILabel * bottomLabel;





@end

@implementation ZTMXFRateAlertView

+ (void)showWithTitle:(NSString *)title message:(NSString *)message style:(ZTMXFRateAlertViewStyle)style clickBlock:(void (^)())clickBlock
{
    ZTMXFRateAlertView * alertView = [[ZTMXFRateAlertView alloc] init];
    alertView.rateAlertViewStyle = style;
    alertView.descStr = message;
    alertView.title = title;
    alertView.confirmBlock = ^{
        clickBlock();
    };
    [kKeyWindow addSubview:alertView];
    [alertView show];

}



+ (void)showWithTitle:(NSString *)title message:(NSString *)message style:(ZTMXFRateAlertViewStyle)style
{
    ZTMXFRateAlertView * alertView = [[ZTMXFRateAlertView alloc] init];
    alertView.rateAlertViewStyle = style;
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
        _mainView.frame = CGRectMake(0, 0, 300 * PX, 280 * PX);
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.cornerRadius = 5;
        _mainView.clipsToBounds = YES;
        _mainView.center = self.center;
        [self addSubview:_mainView];
        
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _mainView.width, 115 * PX)];
        _imgView.image = [UIImage imageNamed:@"XL_FeiYong"];
        [_mainView addSubview:_imgView];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imgView.bottom + 13, _mainView.width, 20 * PX)];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = FONT_Regular(16 * PX);
        [_mainView addSubview:_messageLabel];
        
        _fyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _mainView.width, 20 * PX)];
        _fyLabel.textColor = [UIColor whiteColor];
        _fyLabel.textAlignment = NSTextAlignmentCenter;
        _fyLabel.font = FONT_Regular(16 * PX);
        [_mainView addSubview:_fyLabel];       
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = COLOR_SRT(@"#666666");
        _descLabel.font = FONT_Regular(14 * PX);
        _descLabel.numberOfLines = 0;
        [_mainView addSubview:_descLabel];
        
        _descLabel.sd_layout
        .leftSpaceToView(_mainView, 20)
        .rightSpaceToView(_mainView, 20)
        .topSpaceToView(_imgView, 20)
        .autoHeightRatio(0);
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(20, _mainView.height - 60 * PX, _mainView.width - 40, 40 * PX);
        [_confirmBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = K_MainColor;
        _confirmBtn.layer.cornerRadius = 3;
        [_mainView addSubview:_confirmBtn];
        [_confirmBtn addTarget:self action:@selector(btnACtion) forControlEvents:UIControlEventTouchUpInside];
        
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _confirmBtn.bottom + 15 , _mainView.width, 20 * PX)];
        _bottomLabel.textColor = [UIColor blackColor];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = FONT_Regular(13 * PX);
        [_mainView addSubview:_bottomLabel];
        
    }
    return self;
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
+ (void)showWithStr:(NSString *)str;
{
    ZTMXFRateAlertView * alertView = [[ZTMXFRateAlertView alloc] init];
    alertView.descStr = str;
    [kKeyWindow addSubview:alertView];
    [alertView show];

}

- (void)setRateAlertViewStyle:(ZTMXFRateAlertViewStyle)rateAlertViewStyle
{
    _rateAlertViewStyle = rateAlertViewStyle;
}

- (void)btnACtion
{
    if (_confirmBlock) {
        _confirmBlock();
    }
    [self removeFromSuperview];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _messageLabel.text = title;

}

- (void)setMessage:(NSString *)message
{
    _message = message;
    _fyLabel.text = message;

}

- (void)setDescStr:(NSString *)descStr
{
    _descStr = descStr;
    _descLabel.text = descStr;
    switch (_rateAlertViewStyle) {
        case ZTMXFRateAlertViewDefault:
            _fyLabel.text = @"费用说明";
            _descLabel.text = descStr;
            break;
        case ZTMXFRateAlertViewNoNumber:
            [self ZTMXFRateAlertViewNoNumberUI];
            break;
        case ZTMXFRateAlertViewFailure:
            [self ZTMXFRateAlertViewFailureUI];

            break;
        case ZTMXFRateAlertViewFailureH5:
            [self ZTMXFRateAlertViewFailureH5UI];
            
            break;
            
            
            
        default:
            break;
    }
}

- (void)ZTMXFRateAlertViewFailureH5UI
{
    _imgView.image = [UIImage imageNamed:@"RZ_ShiBai_H5"];
    NSString * str = @"因各个平台风控审核越发严格\n请尽量多申请以提高审核通过率";
    [UILabel attributeWithLabel:_descLabel text:str textColor:COLOR_GRAY_STR attributes:@[@"请尽量多申请以",@"提高审核通过率"] attributeColors:@[COLOR_SRT(@"#151515"),K_GoldenColor]];
//    _descLabel.backgroundColor = DEBUG_COLOR;
    _descLabel.frame = CGRectMake(35 * PX, _imgView.bottom, _mainView.width - 70 * PX, _mainView.height - _confirmBtn.top - _imgView.bottom);
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.font = FONT_Regular(16 * PX);
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.cornerRadius = 3;
    gradientLayer.frame = _confirmBtn.bounds;
    gradientLayer.colors = @[(id)COLOR_SRT(@"#FFB447").CGColor,(id)COLOR_SRT(@"#FF7D22").CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [_confirmBtn.layer addSublayer:gradientLayer];
   

    
    
}

- (void)ZTMXFRateAlertViewNoNumberUI
{
    _imgView.image = [UIImage imageNamed:@"ZL_RZ_ShiBie"];
    NSString * str = [NSString stringWithFormat:@"人脸识别次数超限\n请于%@再来", _descStr];
    [UILabel attributeWithLabel:_descLabel text:str textColor:COLOR_BLACK_STR attributes:@[_descStr] attributeColors:@[K_GoldenColor]];
    _descLabel.sd_layout
    .leftSpaceToView(_mainView, 20)
    .rightSpaceToView(_mainView, 20)
    .topSpaceToView(_messageLabel, 20)
    .autoHeightRatio(0);
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.font = FONT_Regular(16 * PX);
}

- (void)ZTMXFRateAlertViewFailureUI
{
    _mainView.frame = CGRectMake(0, 0, 300 * PX, 310 * PX);
    _mainView.center = self.center;
    _imgView.image = [UIImage imageNamed:@"ZL_RZ_ShiBie"];
    _descLabel.sd_layout
    .leftSpaceToView(_mainView, 20)
    .rightSpaceToView(_mainView, 20)
    .topSpaceToView(_messageLabel, 20)
    .autoHeightRatio(0);
    _mainView.height += 10;
    _confirmBtn.bottom = _mainView.height - 50 * PX;
    _bottomLabel.top = _confirmBtn.bottom + 10;
    _descLabel.textAlignment = NSTextAlignmentCenter;
    NSString * str = [NSString stringWithFormat:@"请保持光线充足\n不带眼镜和帽子,图像清晰"];
    [UILabel attributeWithLabel:_descLabel text:str textColor:COLOR_BLACK_STR attributes:@[@"光线充足",@"眼镜和帽子"] attributeColors:@[K_GoldenColor, K_GoldenColor]];
    [_confirmBtn setTitle:@"再试试" forState:UIControlStateNormal];
    _descLabel.font = FONT_Regular(16 * PX);
    NSString * string = [NSString stringWithFormat:@"仅剩%@次机会,超限将7天后再试", _descStr];
    _bottomLabel.text = string;
    [UILabel attributeWithLabel:_bottomLabel text:string textColor:COLOR_BLACK_STR attributes:@[_descStr] attributeColors:@[K_GoldenColor]];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
//    if (_rateAlertViewStyle == ZTMXFRateAlertViewFailure || _rateAlertViewStyle== ZTMXFRateAlertViewNoNumber) {
//        [self removeFromSuperview];
//    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
