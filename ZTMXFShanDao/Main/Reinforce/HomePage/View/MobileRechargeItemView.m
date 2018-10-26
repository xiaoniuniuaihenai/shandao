//
//  MobileRechargeItemView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MobileRechargeItemView.h"

@interface MobileRechargeItemView ()
@property (nonatomic,strong) UIButton * btnItemBtn;
@property (nonatomic,strong) UILabel * lbOneLb;
@property (nonatomic,strong) UILabel * lbTwoLb;
@property (nonatomic,weak)   id delegate;
@end
@implementation MobileRechargeItemView
-(instancetype)initWithDelegate:(id)delegate{
    if (self = [super init]) {
        _delegate = delegate;
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.btnItemBtn];
        [self addSubview:self.lbOneLb];
        [self addSubview:self.lbTwoLb];
    }
    return self;
}


//恢复状态
-(void)restoreBtnState:(RechargeItemState)itemState{
    if (_selectColor) {
        UIImage * imgSelect = [UIImage imageWithColor:_selectBgColor];
        [_btnItemBtn setBackgroundImage:imgSelect forState:UIControlStateSelected];
    }
    if (_defBgColor) {
        UIImage * imgSelect = [UIImage imageWithColor:_selectBgColor];
        [_btnItemBtn setBackgroundImage:imgSelect forState:UIControlStateSelected];
    }
    
    if (_borderColor) {
        [_btnItemBtn.layer setBorderColor:_borderColor.CGColor];
    }
    if (_defColor) {
        _lbOneLb.textColor = _defColor;
    }
    if (_defTwoColor) {
        _lbTwoLb.textColor = _defTwoColor;

    }
    [_btnItemBtn.layer setCornerRadius:AdaptedWidth(6)];
    [_btnItemBtn.layer setBorderWidth:1];
    _btnItemBtn.hidden = NO;
    _btnItemBtn.selected = NO;
    _btnItemBtn.userInteractionEnabled = YES;
   
    switch (itemState) {
        case RechargeItemStateSelect:{
            if (_borderSelectColor) {
                [_btnItemBtn.layer setBorderColor:_borderSelectColor.CGColor];
            }
            if (_selectColor) {
                _lbOneLb.textColor = _selectColor;
            }
            if (_selectTwoColor) {
                _lbTwoLb.textColor = _selectTwoColor;

            }
            _btnItemBtn.selected = YES;

        }break;
        case RechargeItemStateNotEditor:{
            if (_notBgColor) {
                UIImage * imgSelect = [UIImage imageWithColor:_notBgColor];
                [_btnItemBtn setBackgroundImage:imgSelect forState:UIControlStateSelected];
            }
            if (_borderNotColor) {
                [_btnItemBtn.layer setBorderColor:_borderNotColor.CGColor];
            }
            if (_notColor) {
                _lbOneLb.textColor = _notColor;
            }
            if (_notTwoColor) {
                _lbTwoLb.textColor = _notTwoColor;

            }
            _btnItemBtn.selected = YES;
            _btnItemBtn.userInteractionEnabled = NO;

        }break;
        case RechargeItemStateNotEditorSelect:{
            if (_notSelectBgColor) {
                UIImage * imgSelect = [UIImage imageWithColor:_notSelectBgColor];
                [_btnItemBtn setBackgroundImage:imgSelect forState:UIControlStateSelected];
            }
            if (_notSelectColor) {
                _lbOneLb.textColor = _notSelectColor;
            }
            if (_notSelectTwoColor) {
                _lbTwoLb.textColor = _notSelectTwoColor;

            }
            if (_notSelectBorderColor) {
                [_btnItemBtn.layer setBorderColor:_notSelectBorderColor.CGColor];
            }
            _btnItemBtn.selected = YES;
            _btnItemBtn.userInteractionEnabled = NO;
        }break;
        default:
            break;
    }
}
-(void)btnPayMoneyBtnClick{
    if (!_btnItemBtn.selected)
    {
        _btnItemBtn.selected = YES;
        [self restoreBtnState:RechargeItemStateSelect];
        if ([_delegate respondsToSelector:@selector(mobileRechargeItemViewSelectItem:)]) {
            [_delegate mobileRechargeItemViewSelectItem:self];
        }
    }
    
    
}


#pragma mark ----- Get
-(void)setOneValue:(NSString *)oneValue{
    _oneValue = oneValue;
    _lbOneLb.text = _oneValue;
}
-(void)setTwoValue:(NSString *)twoValue{
    _twoValue = twoValue;
    _lbTwoLb.text = _twoValue;
}
-(UIButton *)btnItemBtn{
    if (!_btnItemBtn) {
        _btnItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnItemBtn setFrame:CGRectMake(0, 0, AdaptedWidth(110), AdaptedWidth(50))];
        _btnItemBtn.clipsToBounds = YES;
        [self restoreBtnState:RechargeItemStateNormal];
        [_btnItemBtn addTarget:self action:@selector(btnPayMoneyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnItemBtn;
}
-(UILabel *)lbOneLb{
    if (!_lbOneLb) {
        _lbOneLb = [[UILabel alloc]init];
        [_lbOneLb setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
        _lbOneLb.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _lbOneLb.textAlignment = NSTextAlignmentCenter;
    }
    return _lbOneLb;
}
-(UILabel *)lbTwoLb{
    if (!_lbTwoLb) {
        _lbTwoLb = [[UILabel alloc]init];
        [_lbTwoLb setFont:[UIFont systemFontOfSize:AdaptedWidth(12)]];
        _lbTwoLb.textAlignment = NSTextAlignmentCenter;
        _lbTwoLb.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];

    }
    return _lbTwoLb;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_btnItemBtn setFrame:CGRectMake(0, 0, self.width, self.height)];
    [_lbOneLb setFrame:CGRectMake(0, AdaptedWidth(6), self.width, AdaptedWidth(22))];
    [_lbTwoLb setFrame:CGRectMake(0, AdaptedWidth(6), self.width, AdaptedWidth(17))];
    _lbTwoLb.bottom = self.height-AdaptedWidth(6);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
