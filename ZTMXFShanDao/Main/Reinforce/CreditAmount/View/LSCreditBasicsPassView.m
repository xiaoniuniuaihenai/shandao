//
//  LSCreditBasicsPassView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditBasicsPassView.h"
#import "LSCreditPassModel.h"
@interface LSCreditBasicsPassView ()
@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) UILabel * lbPromptLb;
@property (nonatomic,strong) UIView * viAmountView;
@property (nonatomic,strong) NSMutableArray * arrLineArr;
@property (nonatomic,strong) UILabel * lbAmountLb;
@property (nonatomic,strong) UIButton * btnSubmitBtn;
/**  1.4版本*/
@property (nonatomic,strong) UILabel * borrowMoneyLabel;
@end
@implementation LSCreditBasicsPassView



- (void)setCreditPassModel:(LSCreditPassModel *)creditPassModel{
    _creditPassModel = creditPassModel;
    
    NSString * moneyStr = [NSString moneyDeleteMoreZeroWithAmountStr:[_creditPassModel.a doubleValue]];
    _lbAmountLb.text = moneyStr;
    CGFloat width = [moneyStr sizeWithFont:_lbAmountLb.font maxW:self.width].width;
    width = width>227?width:227;
    _viAmountView.width = width;
    _viAmountView.centerX = self.width/2.;
    
//    _borrowMoneyLabel.text = [NSString stringWithFormat:@"现在借款即送%@还款券",_creditPassModel.c];
    
    _lbAmountLb.width = _viAmountView.width;
    _lbAmountLb.height = _viAmountView.height;
    _lbAmountLb.left = 0;
    _lbAmountLb.top = 0;
    for (UIView * line in _arrLineArr) {
        line.width = _viAmountView.width;
        line.left = 0;
    }
}

-(void)btnSubmitBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled = NO;
    if ([_delegate respondsToSelector:@selector(creditBasicePassGoBorrowMoney)]) {
        [_delegate creditBasicePassGoBorrowMoney];
    }
    btn.userInteractionEnabled = YES;
}

#pragma mark -- Get Set
-(UILabel*)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        [_lbTitleLb setFont:[UIFont systemFontOfSize:18]];
        [_lbTitleLb setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
        [_lbTitleLb setFrame:CGRectMake(0, 0, 260, 25)];
        _lbTitleLb.textAlignment = NSTextAlignmentCenter;
        _lbTitleLb.text = @"恭喜您，通过认证!";
    }
    return _lbTitleLb;
}
-(UILabel*)lbPromptLb{
    if (!_lbPromptLb) {
        _lbPromptLb = [[UILabel alloc]init];
        [_lbPromptLb setFont:[UIFont systemFontOfSize:12]];
        [_lbPromptLb setTextColor:K_B8B8B8];
        [_lbPromptLb setFrame:CGRectMake(0, 0, 260, 17)];
        _lbPromptLb.textAlignment = NSTextAlignmentCenter;
        _lbPromptLb.text = @"您可享的额度是";
    }
    return _lbPromptLb;
}
-(UIView*)viAmountView{
    if (!_viAmountView) {
        _viAmountView = [[UIView alloc]init];
        [_viAmountView setFrame:CGRectMake(0, 0, 227, 60)];
        [_viAmountView setBackgroundColor:[UIColor clearColor]];
        _arrLineArr = [[NSMutableArray alloc]init];
        for (int i = 0; i <5; i++) {
            UIView * line = [[UIView alloc]init];
            [line setFrame:CGRectMake(0, i*15, _viAmountView.width, 1)];
            [line setBackgroundColor:[UIColor colorWithHexString:@"edeff0"]];
            [_viAmountView addSubview:line];
            [_arrLineArr addObject:line];
        }
        [_viAmountView addSubview:self.lbAmountLb];
    }
    return _viAmountView;

}

-(UILabel*)lbAmountLb{
    if (!_lbAmountLb) {
        _lbAmountLb = [[UILabel alloc]init];
        [_lbAmountLb setFont:[UIFont systemFontOfSize:64]];
        [_lbAmountLb setTextColor:[UIColor colorWithHexString:COLOR_GRAY_STR]];
        _lbAmountLb.textAlignment = NSTextAlignmentCenter;
    }
    return _lbAmountLb;
}
-(UILabel *)borrowMoneyLabel{
    if (!_borrowMoneyLabel) {
        _borrowMoneyLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:15 alignment:NSTextAlignmentCenter];
        [_borrowMoneyLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    return _borrowMoneyLabel;
}
-(UIButton*)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setFrame:CGRectMake(0, 0, 280, 44)];
        [_btnSubmitBtn setTitle:@"去借钱" forState:UIControlStateNormal];
        _btnSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnSubmitBtn.layer setCornerRadius:3.0];
        _btnSubmitBtn.backgroundColor= K_MainColor;
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
    _lbTitleLb.top = 40;
    _lbTitleLb.centerX = self.width/2.;
    _lbPromptLb.top = _lbTitleLb.bottom +16;
    _lbPromptLb.centerX = self.width/2.;
    _viAmountView.top = _lbPromptLb.bottom + 18;
    _viAmountView.centerX = self.width/2.;
//    _borrowMoneyLabel.top = _viAmountView.bottom + 30;
//    _borrowMoneyLabel.centerX = self.width/2.;
    _btnSubmitBtn.top = _viAmountView.bottom + 100;
    _btnSubmitBtn.centerX = self.width/2.;
}
-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.lbTitleLb];
        [self addSubview:self.lbPromptLb];
        [self addSubview:self.viAmountView];
        //        [self addSubview:self.borrowMoneyLabel];
        [self addSubview:self.btnSubmitBtn];
    }
    return self;
}

@end
