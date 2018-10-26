//
//  LSInputRowCellView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSInputRowCellView.h"
#import "ZTMXFCreditxTextField.h"

@interface LSInputRowCellView()
@property (nonatomic,copy) NSString * titleStr;
@property (nonatomic,copy) NSString * valueStr;
@property (nonatomic,copy) NSString * placeholderStr;
@property (nonatomic,assign) InputRowCellStyle cellStyle;
@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) UIImageView * imgRight;
@property (nonatomic,strong) UIView * viLineView;


@end
@implementation LSInputRowCellView
-(instancetype)initWithCellStyle:(InputRowCellStyle)cellStyle title:(NSString*)title value:(NSString*)value placeholder:(NSString*)placeholder{
    _titleFontSize = 14.;
    _valueFontSize = 14.,
    _contentMargin = AdaptedWidth(17);
    _lineEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _valueMargin = AdaptedWidth(118);
    _titleColor = @"4e4e4e";
    _valueColor = @"4e4e4e";
    _titleStr = title;
    _valueStr = value;
    _placeholderStr = placeholder;
    self.cellStyle = cellStyle;
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self steupUI];
    }
    return self;
}
-(void)steupUI{
    [self addSubview:self.lbTitleLb];
    [self addSubview:self.textField];
    [self addSubview:self.viLineView];
    if (_cellStyle == InputRowCellStyleCode) {
        [self addSubview:self.btnCodel];
    }else if (_cellStyle == InputRowCellStyleChoose) {
        _textField.userInteractionEnabled = NO;
        [self addSubview:self.btnChoose];
        [self addSubview:self.imgRight];
        [self sendSubviewToBack:self.btnChoose];
    }else if (_cellStyle == InputRowCellStyleNoEdit) {
        _textField.userInteractionEnabled = NO;
    }else if ([_valueStr length]>0) {
        _textField.text = _valueStr;
    }
    _lbTitleLb.text = _titleStr;
    [_lbTitleLb sizeToFit];
    _textField.placeholder = _placeholderStr;
}


-(void)setContentMargin:(CGFloat)contentMargin{
    if (_contentMargin != contentMargin) {
        _contentMargin = contentMargin;
        [self layoutSubviews];
    }
}
-(void)setLineEdgeInsets:(UIEdgeInsets)lineEdgeInsets{
    _lineEdgeInsets = lineEdgeInsets;
    _viLineView.width = self.width - _lineEdgeInsets.left - _lineEdgeInsets.right;
    if (_lineEdgeInsets.right>_lineEdgeInsets.left) {
        _viLineView.right = _lineEdgeInsets.right;
    }else{
        _viLineView.left = _lineEdgeInsets.left;
    }
}

-(void)setIsHideLine:(BOOL)isHideLine{
    _isHideLine = isHideLine;
    self.viLineView.hidden = _isHideLine;
}

-(void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    self.textField.text = valueStr;
}

-(void)setTitleColor:(NSString *)titleColor{
    _titleColor = titleColor;
    self.lbTitleLb.textColor = [UIColor colorWithHexString:titleColor];
}
-(void)setValueMargin:(CGFloat)valueMargin {
    if (_valueMargin != valueMargin) {
        _valueMargin = valueMargin;
        [self layoutSubviews];
    }
}
-(void)setValueColor:(NSString *)valueColor{
    _valueColor = valueColor;
    self.textField.textColor = [UIColor colorWithHexString:_valueColor];
}

#pragma mark - Action

-(UILabel*)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        _lbTitleLb.textColor = [UIColor colorWithHexString:_titleColor];
        [_lbTitleLb setFont:[UIFont systemFontOfSize:_titleFontSize]];
        _lbTitleLb.left = _contentMargin;
        _lbTitleLb.textAlignment = NSTextAlignmentLeft;
        _lbTitleLb.centerY = self.height/2.;
    }
    return _lbTitleLb;
}
-(ZTMXFCreditxTextField *)textField{
    if (!_textField) {
        _textField = [[ZTMXFCreditxTextField alloc]init];
        [_textField setFont:[UIFont systemFontOfSize:_valueFontSize]];
        _textField.textColor = [UIColor colorWithHexString:_valueColor];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.width = self.width - _textField.left - _contentMargin;
        _textField.centerY = self.height/2.;
    }
    return _textField;
}
-(UIButton *)btnCodel{
    if (!_btnCodel) {
        _btnCodel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCodel setFrame:CGRectMake(0, 0, X(90), X(32))];
        [_btnCodel setTitle:@"获取验证码" forState:0];
        _btnCodel.layer.cornerRadius = 3.f;
        _btnCodel.layer.masksToBounds = YES;
        _btnCodel.layer.borderColor = K_MainColor.CGColor;
        _btnCodel.layer.borderWidth = .5f;
        [_btnCodel setTitleColor:K_MainColor forState:UIControlStateNormal];
        _btnCodel.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    }
    return _btnCodel;
}
-(UIButton *)btnChoose{
    if (!_btnChoose) {
        _btnChoose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnChoose setFrame:CGRectMake(0, 0,self.width,self.height)];
        UIImage * imgH = [UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        [_btnChoose setBackgroundImage:imgH forState:UIControlStateHighlighted];
    }
    return _btnChoose;
}
-(UIImageView*)imgRight{
    if (!_imgRight) {
        _imgRight = [[UIImageView alloc]init];
        [_imgRight setFrame:CGRectMake(0, 0, 8, 14)];
        [_imgRight setImage:[UIImage imageNamed:@"XL_common_right_arrow"]];
    }
    return _imgRight;
}
-(UIView *)viLineView{
    if (!_viLineView) {
        _viLineView = [[UIView alloc]init];
        [_viLineView setFrame:CGRectMake(0, 0, self.width, 1)];
        [_viLineView setBackgroundColor:[UIColor colorWithHexString:@"e6e6e6"]];
        _viLineView.bottom = self.height;
    }
    return _viLineView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lbTitleLb.centerY = self.height/2.;
    _textField.left = _valueMargin;
    _textField.height = self.height;
    _textField.centerY = self.height/2.;

    _imgRight.centerY = self.height/2.;
//    _btnCodel.height = self.height;
    _btnCodel.centerY = self.height/2.;
    _viLineView.bottom = self.height;
    _btnChoose.width = self.width;
    _btnChoose.height = self.height;
    _btnChoose.top = 0;
    _btnChoose.left = 0;
    _textField.width = self.width - _textField.left - _contentMargin;
    if (_cellStyle == InputRowCellStyleChoose) {
        _imgRight.right = self.width - _contentMargin;
        _textField.width = _imgRight.left - _textField.left - 5;
    }else if(_cellStyle == InputRowCellStyleCode){
        _btnCodel.right = self.width - _contentMargin;
        _textField.width = _btnCodel.left - _textField.left-5;
    }
    _viLineView.width = self.width - _lineEdgeInsets.left - _lineEdgeInsets.right;
    if (_lineEdgeInsets.right>_lineEdgeInsets.left) {
        _viLineView.right = _lineEdgeInsets.right;
    }else{
        _viLineView.left = _lineEdgeInsets.left;
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
