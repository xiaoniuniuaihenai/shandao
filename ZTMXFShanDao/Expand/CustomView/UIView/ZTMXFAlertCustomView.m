//
//  LSAlertCustomView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFAlertCustomView.h"
#import "WJYAlertView.h"
@interface ZTMXFAlertCustomView ()
@property (nonatomic,strong) UILabel * lbMessageLb;
@property (nonatomic,strong) UIButton * btnBottomBtn;
@property (nonatomic,strong) __block WJYAlertView * alertView;
@end
@implementation ZTMXFAlertCustomView
-(void)showAlertView{
    _alertView = [[WJYAlertView alloc]initWithCustomView:self dismissWhenTouchedBackground:NO];
    [_alertView show];
    
}
-(instancetype)initWithMessage:(NSAttributedString*)msg btnTitle:(NSString*)title{
    if (self = [super init]) {
        self.clipsToBounds = YES;
        [self.layer setCornerRadius:8.];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:self.lbMessageLb];
        [self addSubview:self.btnBottomBtn];
        
        _lbMessageLb.attributedText = msg;
        [_btnBottomBtn setTitle:title forState:UIControlStateNormal];

        CGFloat height = [NSString heightForString:msg.string andFont:[UIFont systemFontOfSize:AdaptedWidth(16)] andWidth:AdaptedWidth(224)];
       CGFloat mianH = height+AdaptedWidth(108)>=AdaptedWidth(180)?height+AdaptedWidth(108):AdaptedWidth(180);
        [self setFrame:CGRectMake(0, 0, AdaptedWidth(280), mianH)];
        
        [_lbMessageLb setFrame:CGRectMake(0,AdaptedWidth(42), AdaptedWidth(224), height)];
        _lbMessageLb.centerX = self.width/2.;
        [_btnBottomBtn setFrame:CGRectMake(0, 0, AdaptedWidth(140), AdaptedWidth(36))];
        [_btnBottomBtn.layer setCornerRadius:_btnBottomBtn.height/2.];
        _btnBottomBtn.centerX = self.width/2.;
        _btnBottomBtn.bottom = self.height-AdaptedWidth(20);
        
    }
    return self;
}


#pragma mark --- Action
-(void)btnBottomBtnClick{
    MJWeakSelf
    [_alertView dismissWithCompletion:^{
        weakSelf.btnClick();
    }];
}
#pragma mark -- set/get

-(UILabel *)lbMessageLb{
    if (!_lbMessageLb) {
        _lbMessageLb = [[UILabel alloc]init];
        _lbMessageLb.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _lbMessageLb.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _lbMessageLb.textAlignment = NSTextAlignmentCenter;
        _lbMessageLb.numberOfLines = 0;
    }
    return _lbMessageLb;
}
-(UIButton *)btnBottomBtn{
    if (!_btnBottomBtn) {
        _btnBottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnBottomBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        _btnBottomBtn.clipsToBounds = YES;
        [_btnBottomBtn setBackgroundColor:K_MainColor];
        _btnBottomBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [_btnBottomBtn addTarget:self action:@selector(btnBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBottomBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
