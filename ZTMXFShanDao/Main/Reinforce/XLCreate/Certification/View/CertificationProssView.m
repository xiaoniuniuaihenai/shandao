//
//  CertificationProssView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CertificationProssView.h"
#import "ZTMXFFlagView.h"
@interface CertificationProssView ()

@property (nonatomic, strong)ZTMXFFlagView * firstView;

@property (nonatomic, strong)ZTMXFFlagView * secondView;

@property (nonatomic, strong)ZTMXFFlagView * thirdView;

@property (nonatomic, strong)UIButton * leftBtn;

@property (nonatomic, strong)UIButton * rightBtn;


@end



@implementation CertificationProssView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_SRT(@"#F2F2F2");
        self.firstView = [[ZTMXFFlagView alloc] initWithFrame:CGRectMake(0, 0, KW / 3, self.height)];
        _firstView.titleLabel.text = @"实名认证";
        _firstView.numLabel.text = @"1";
        [self addSubview:_firstView];
        
        self.secondView = [[ZTMXFFlagView alloc] initWithFrame:CGRectMake(KW / 3, 0, KW / 3, self.height)];
        _secondView.titleLabel.text = @"绑定银行卡";
        _secondView.numLabel.text = @"2";
        [self addSubview:_secondView];
        
        self.thirdView = [[ZTMXFFlagView alloc] initWithFrame:CGRectMake(KW / 3 * 2, 0, KW / 3, self.height)];
        _thirdView.numLabel.text = @"3";
        [self addSubview:_thirdView];
        if ([LoginManager appReviewState]) {
            _thirdView.titleLabel.text = @"绑卡成功";
        }else{
            _thirdView.titleLabel.text = @"芝麻信用授权";
        }
        
//        XL_RenZheng_3
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(_firstView.right - 20, 0, 40, 24 + 16 * PY * 2);
        [self addSubview:_leftBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(_secondView.right - 20, _rightBtn.top, 40, _leftBtn.height);
        [self addSubview:_rightBtn];
        _rightBtn.userInteractionEnabled = NO;
        _leftBtn.userInteractionEnabled = NO;

        
    }
    return self;
}



- (void)setProssType:(CertificationProssType)prossType
{
    _prossType = prossType;
    switch (prossType) {
        case CertificationProssIdCard:
            _firstView.selected = YES;
            _secondView.selected = NO;
            _thirdView.selected = NO;
            [_leftBtn setImage:[UIImage imageNamed:@"XL_RenZheng_2"] forState:UIControlStateNormal];
            [_rightBtn setImage:[UIImage imageNamed:@"XL_RenZheng_3"] forState:UIControlStateNormal];

            break;
        case CertificationProssBankCard:
            _firstView.selected = YES;
            _secondView.selected = YES;
            _thirdView.selected = NO;
            [_leftBtn setImage:[UIImage imageNamed:@"XL_RenZheng_1"] forState:UIControlStateNormal];
            [_rightBtn setImage:[UIImage imageNamed:@"XL_RenZheng_2"] forState:UIControlStateNormal];
            break;
        case CertificationProssZhiMa:
            _firstView.selected = YES;
            _secondView.selected = YES;
            _thirdView.selected = YES;
            [_leftBtn setImage:[UIImage imageNamed:@"XL_RenZheng_1"] forState:UIControlStateNormal];
            [_rightBtn setImage:[UIImage imageNamed:@"XL_RenZheng_1"] forState:UIControlStateNormal];
            break;
        case CertificationProssOperator:
            _firstView.selected = YES;
            _secondView.selected = YES;
            _thirdView.selected = YES;
            [_leftBtn setImage:[UIImage imageNamed:@"XL_RenZheng_1"] forState:UIControlStateNormal];
            [_rightBtn setImage:[UIImage imageNamed:@"XL_RenZheng_1"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
