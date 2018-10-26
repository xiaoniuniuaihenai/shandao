//
//  LSCreditBasicsTimerEndView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditBasicsTimerEndView.h"
@interface LSCreditBasicsTimerEndView ()
@property (nonatomic,strong) UIImageView * imgIconView;
@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) UILabel * lbPromptLb;
@property (nonatomic,strong) UIButton * btnSubmitBtn;

@end
@implementation LSCreditBasicsTimerEndView


-(void)btnSubmitBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled = NO;
    if ([_delegate respondsToSelector:@selector(creditBasiceTimerEndSubmitClick)]) {
        [_delegate creditBasiceTimerEndSubmitClick];
    }
    btn.userInteractionEnabled = YES;
}
-(UIImageView*)imgIconView{
    if (!_imgIconView) {
        _imgIconView = [[UIImageView alloc]init];
        [_imgIconView setImage:[UIImage imageNamed:@"XL_payResult_success"]];
        [_imgIconView setFrame:CGRectMake(0, 30, 50, 50)];
    }
    return _imgIconView;
}
-(UILabel*)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        [_lbTitleLb setFont:[UIFont systemFontOfSize:16]];
        [_lbTitleLb setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
        [_lbTitleLb setFrame:CGRectMake(0, 0, 260, 23)];
        _lbTitleLb.textAlignment = NSTextAlignmentCenter;
        _lbTitleLb.text = @"恭喜您，初步审核通过";
    }
    return _lbTitleLb;
}
-(UILabel*)lbPromptLb{
    if (!_lbPromptLb) {
        _lbPromptLb = [[UILabel alloc]init];
        [_lbPromptLb setFont:[UIFont systemFontOfSize:13]];
        [_lbPromptLb setTextColor:[UIColor colorWithHexString:COLOR_GRAY_STR]];
        [_lbPromptLb setFrame:CGRectMake(0, 0, 287, 17)];
        _lbPromptLb.numberOfLines = 0;
        _lbPromptLb.textAlignment = NSTextAlignmentCenter;
        _lbPromptLb.text = [NSString stringWithFormat:@"初步审核已通过，正在等待进一步审核，工作时内审核时间超30分，您将获得10元补偿金。"];
        [_lbPromptLb sizeToFit];
    }
    return _lbPromptLb;
}
-(UIButton*)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setFrame:CGRectMake(0, 0, 280, 44)];
        [_btnSubmitBtn setTitle:@"确定" forState:UIControlStateNormal];
        _btnSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnSubmitBtn setTitleColor:[UIColor colorWithHexString:@"e56647"] forState:UIControlStateNormal];
        UIImage * imgH = [UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        [_btnSubmitBtn setBackgroundImage:imgH forState:UIControlStateHighlighted];
        [_btnSubmitBtn.layer setCornerRadius:22];
        [_btnSubmitBtn.layer setBorderWidth:1.];
        [_btnSubmitBtn.layer setBorderColor:[UIColor colorWithHexString:@"e84639"].CGColor];
        _btnSubmitBtn.clipsToBounds = YES;
        [_btnSubmitBtn addTarget:self action:@selector(btnSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmitBtn;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    _imgIconView.top = 30;
    _imgIconView.centerX = self.width/2.;
    _lbTitleLb.top = _imgIconView.bottom + 15;
    _lbTitleLb.centerX = self.width/2.;
    _lbPromptLb.top = _lbTitleLb.bottom +12;
    _lbPromptLb.centerX = self.width/2.;
    _btnSubmitBtn.top = 242;
    _btnSubmitBtn.centerX = self.width/2.;
}
-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.imgIconView];
        [self addSubview:self.lbTitleLb];
        [self addSubview:self.lbPromptLb];
        [self addSubview:self.btnSubmitBtn];
    }
    return self;
}

@end
