//
//  JBBorrowRateAlertView.m
//  tryTest
//
//  Created by 朱吉达 on 2017/12/1.
//  Copyright © 2017年 try. All rights reserved.
//
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width
#import "JBBorrowRateAlertView.h"
@interface JBBorrowRateAlertView()
@property (nonatomic,strong) UIView * viBg;
@property (nonatomic,strong) UIView * viMain;
@property (nonatomic,strong) UILabel * lbTitle;
@property (nonatomic,strong) UIView * viLine;
@property (nonatomic,strong) UILabel * lbOneTitle;
@property (nonatomic,strong) UILabel * lbTwoTitle;

@property (nonatomic,strong) UILabel * lbOne;
@property (nonatomic,strong) UILabel * lbTwo;
@property (nonatomic,strong) UIButton * btnGoBtn;
@end
@implementation JBBorrowRateAlertView

-(instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height)];
        [self addSubview:self.viBg];
        [self addSubview:self.viMain];
        
    }
    return self;
}
-(void)updateWithProcedureRates:(NSString* )pRates dayRate:(NSString *)dayRate loanAlertType:(LoanAlertViewType)alertViewType{
    if (alertViewType == ConsumeLoanAlertViewType) {
        //  消费贷提示
        _lbOneTitle.text = [NSString stringWithFormat:@"服务费 = 借款本金*服务费率*借款天数"];
        _lbOne.text = [NSString stringWithFormat:@"服务费率: %@%%",pRates];
        _lbTwoTitle.text = [NSString stringWithFormat:@"借款日利率: %@%%",dayRate];
        _lbTwo.hidden = YES;
    } else {
        //  白领贷提示
        _lbOne.text = [NSString stringWithFormat:@"服务费 = 借款本金*服务费率*借款天数"];
        _lbTwo.text = [NSString stringWithFormat:@"借款日利率: %@%%     服务费率: %@%%",dayRate, pRates];
    }
    [_lbOneTitle sizeToFit];
    [_lbTwoTitle sizeToFit];
    [_lbOne sizeToFit];
    [_lbTwo sizeToFit];
    _lbOne.top = _lbOneTitle.bottom+5;
    _lbTwoTitle.top = _lbOne.bottom+5;
    _lbTwo.top = _lbTwoTitle.bottom+5;
}


-(void)show{
    self.alpha = 1;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:.2 animations:^{
        _viMain.alpha =1;
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)btnGoBtnClick{
    [self dismiss];
}





-(UIView * )viBg{
    if (!_viBg) {
        _viBg = [[UIView alloc]init];
        [_viBg setFrame:CGRectMake(0, 0,App_Frame_Width, App_Frame_Height)];
        UIColor *bgColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [_viBg setBackgroundColor:bgColor];
    }
    return _viBg;
}
-(UIView * )viMain{
    if (!_viMain) {
        _viMain = [[UIView alloc]init];
        [_viMain setFrame:CGRectMake(0, 0,AdaptedWidth(300), AdaptedWidth(320))];
        [_viMain setBackgroundColor:[UIColor whiteColor]];
        [_viMain.layer setCornerRadius:8];
        [_viMain.layer setShadowColor:[UIColor blackColor].CGColor];
        [_viMain.layer setShadowOffset:CGSizeMake(0, 1)];
        _viMain.clipsToBounds = YES;
        UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"XL_FeiYong"]];
        imgView.frame = CGRectMake(0, 0, _viMain.width, 115 * PY);
        [_viMain addSubview:imgView];
        
        [_viMain addSubview:self.lbTitle];
        [_viMain addSubview:self.viLine];
        
        [_viMain addSubview:self.lbOneTitle];
        [_viMain addSubview:self.lbOne];
        [_viMain addSubview:self.lbTwoTitle];
        [_viMain addSubview:self.lbTwo];
        [_viMain addSubview:self.btnGoBtn];
        
        
//        UIView * line = [[UIView alloc]init];
//        [line setFrame:CGRectMake(0, CGRectGetMinY(_btnGoBtn.frame), CGRectGetWidth(_viMain.frame), 1)];
//        [line setBackgroundColor:[UIColor colorWithHexString:COLOR_DEEPBORDER_STR]];
//        [_viMain addSubview:line];
    }
    return _viMain;
}
-(UIView *)viLine{
    if (!_viLine) {
        _viLine = [[UIView alloc]init];
        [_viLine setFrame:CGRectMake(AdaptedWidth(5), _lbTitle.bottom, _viMain.width-AdaptedWidth(10), 1)];
        [_viLine setBackgroundColor:[UIColor colorWithHexString:@"F2F4F5"]];
    }
    return _viLine;
}
-(UILabel *)lbTitle{
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc]init];
        [_lbTitle setFrame:CGRectMake(0, 0, CGRectGetWidth(_viMain.frame), AdaptedWidth(50))];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = [UIFont systemFontOfSize:AdaptedWidth(18)];
        _lbTitle.text = @"费用说明";
    }
    return _lbTitle;
}

-(UILabel *)lbOneTitle{
    if (!_lbOneTitle) {
        _lbOneTitle = [[UILabel alloc]init];
        [_lbOneTitle setFrame:CGRectMake(25,AdaptedWidth(90), CGRectGetWidth(_viMain.frame)-50, 21)];
        _lbOneTitle.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _lbOneTitle.textAlignment = NSTextAlignmentLeft;
        _lbOneTitle.text = @"到账金额 = 借款本金 - 服务费";
        _lbOneTitle.numberOfLines = 0;
    }
    return _lbOneTitle;
}
-(UILabel *)lbOne{
    if (!_lbOne) {
        _lbOne = [[UILabel alloc]init];
        [_lbOne setFrame:CGRectMake(25,CGRectGetMaxY(_lbOneTitle.frame)+5, CGRectGetWidth(_viMain.frame)-30, 21)];
        _lbOne.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _lbOne.textAlignment = NSTextAlignmentLeft;
        _lbOne.numberOfLines = 0;
//        [_lbOne sizeToFit];
    }
    return _lbOne;
}

-(UILabel *)lbTwoTitle{
    if (!_lbTwoTitle) {
        _lbTwoTitle = [[UILabel alloc]init];
        [_lbTwoTitle setFrame:CGRectMake(25,125 * PY, CGRectGetWidth(_viMain.frame)-50, 21)];
        _lbTwoTitle.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _lbTwoTitle.textAlignment = NSTextAlignmentLeft;
        _lbTwoTitle.text = @"利息 = 借款本金*日利率*借款天数";
        _lbTwoTitle.numberOfLines = 0;
        [_lbTwoTitle sizeToFit];
    }
    return _lbTwoTitle;
}

-(UILabel *)lbTwo{
    if (!_lbTwo) {
        _lbTwo = [[UILabel alloc]init];
        [_lbTwo setFrame:CGRectMake(25,CGRectGetMaxY(_lbTwoTitle.frame)+5, CGRectGetWidth(_viMain.frame)-50, 21)];
        _lbTwo.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _lbTwo.textAlignment = NSTextAlignmentLeft;
        _lbTwo.numberOfLines = 0;
//        [_lbTwo sizeToFit];
    }
    return _lbTwo;
}
-(UIButton *)btnGoBtn{
    if(!_btnGoBtn){
        _btnGoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoBtn setFrame:CGRectMake(0, CGRectGetHeight(_viMain.frame)-48, AdaptedWidth(260),AdaptedWidth(44))];
        [_btnGoBtn setBackgroundColor:[UIColor colorWithHexString:@"2BADF0"]];
        [_btnGoBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_btnGoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnGoBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        [_btnGoBtn addTarget:self action:@selector(btnGoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_btnGoBtn.layer setCornerRadius:3];
        _btnGoBtn.clipsToBounds = YES;
        _btnGoBtn.centerX = _viMain.width/2.;
        _btnGoBtn.bottom = _viMain.height - AdaptedWidth(20);
    }
    return _btnGoBtn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [_viBg setFrame:CGRectMake(0, 0,Main_Screen_Width, Main_Screen_Height)];
    _viMain.center = CGPointMake(App_Frame_Width/2., App_Frame_Height/2.);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
