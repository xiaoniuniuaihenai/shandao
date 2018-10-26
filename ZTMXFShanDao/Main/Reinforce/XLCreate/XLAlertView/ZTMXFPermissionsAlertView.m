//
//  XLPermissionsAlertView.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/4/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPermissionsAlertView.h"
@interface ZTMXFPermissionsAlertView ()

@property (nonatomic, strong)UIButton * whiteView;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UIImageView * imgView;


@property (nonatomic, strong)UILabel * descLabel;

@property (nonatomic, strong)UIButton * setBtn;

@property (nonatomic, copy)void(^clickBtn)(void);

@property (nonatomic, assign)XLPermissionsType permissionsType;

@property (nonatomic, copy) NSString *message;

@end

@implementation ZTMXFPermissionsAlertView

+ (void)showAlert:(XLPermissionsType)permissionsType Click:(clickHandle)click;
{
    ZTMXFPermissionsAlertView * alert = [[ZTMXFPermissionsAlertView alloc] init];
    alert.clickBtn = ^{
        click();
    };
    alert.permissionsType = permissionsType;
    [kKeyWindow addSubview:alert];
    [alert show];
    
}

+ (void)showAlert:(XLPermissionsType)permissionsType ErrorMessage:(NSString *)message Click:(clickHandle)click{
    ZTMXFPermissionsAlertView * alert = [[ZTMXFPermissionsAlertView alloc] init];
    alert.clickBtn = ^{
        click();
    };
    alert.message = message;
    alert.permissionsType = permissionsType;
    [kKeyWindow addSubview:alert];
    [alert show];
}

- (void)setPermissionsType:(XLPermissionsType)permissionsType
{
    _permissionsType = permissionsType;
    switch (permissionsType) {
        case XLPermissionsCamera:
            _titleLabel.text = @"相机权限";
            _descLabel.text = @"您没有为美期开启相机权限";
            _imgView.image = [UIImage imageNamed:@"QX_XiangJi"];
            break;
        case XLPermissionsPhoto:
            _titleLabel.text = @"相册权限";
            _descLabel.text = @"您没有为美期开启相册权限";
            _imgView.image = [UIImage imageNamed:@"QX_XiangCe"];
            break;
        case XLPermissionsGPS:
            _titleLabel.text = @"GPS权限";
            _descLabel.text = @"为让认证、提额、还款业务更顺利\n请授予美期地理位置权限";
            _imgView.image = [UIImage imageNamed:@"QX_GPS"];
            break;
        case XLPermissionsetwork:
            _titleLabel.text = @"";
            _descLabel.text = @"";
            _imgView.image = [UIImage imageNamed:@"QX_WangLuo"];
            break;
        case XLPermissionsLoanFailure:
            _titleLabel.text = self.message?:@"";
            _descLabel.text = @"";
            _titleLabel.numberOfLines = 0;
            _titleLabel.font = FONT_Regular(16 * PX);
            [_setBtn setTitle:@"立即查看" forState:UIControlStateNormal];
            _imgView.frame = CGRectMake((300 * PX - 171 * PX) / 2 , 7 * PX, 171 * PX, 131 * PX);
            _titleLabel.height = 65 * PX;
            _titleLabel.top = _imgView.bottom + 12 * PX;
            _imgView.image = [UIImage imageNamed:@"XL_Loan_Failure"];
            [self addColors];
            break;
            
        default:
            break;
    }
}

- (void)addColors
{
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.cornerRadius = 3;
    gradientLayer.frame = _setBtn.bounds;
    gradientLayer.colors = @[(id)COLOR_SRT(@"#FFB447").CGColor,(id)COLOR_SRT(@"#FF7D22").CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [_setBtn.layer addSublayer:gradientLayer];
}



- (void)show
{
    _whiteView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.9 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        _whiteView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    
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
        _whiteView.frame = CGRectMake(0, 0, 300 * PX, 280 * PX);
        _whiteView.userInteractionEnabled = YES;
        [self addSubview:_whiteView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 4 * PX;
        _whiteView.center = self.center;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(84 * PX , 25 * PX, 132 * PX, 97 * PX)];
        [_whiteView addSubview:_imgView];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _imgView.bottom + 18 * PX, _whiteView.width - 40, 25 * PX)];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = COLOR_SRT(@"#333333");
        _titleLabel.font = FONT_Regular(18 * PX);
        [_whiteView addSubview:_titleLabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _titleLabel.bottom + 1 * PX, _whiteView.width - 40, 40 * PX)];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.textColor = COLOR_SRT(@"#333333");
        _descLabel.numberOfLines = 0;
        _descLabel.font = FONT_Regular(14 * PX);
        [_whiteView addSubview:_descLabel];
        
        _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setBtn.frame = CGRectMake(25, _whiteView.height - 60 * PX, _whiteView.width - 50, 40 * PX );
        [_setBtn setTitle:@"去开启" forState:UIControlStateNormal];
        _setBtn.backgroundColor = K_MainColor;
        [_setBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _setBtn.layer.cornerRadius = 3;
        [_whiteView addSubview:_setBtn];
        _whiteView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
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


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
