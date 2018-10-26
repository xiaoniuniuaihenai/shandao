//
//  LSCreditRowCellView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditRowCellView.h"
#import "UIView+Administer.h"
@interface LSCreditRowCellView()
@property (nonatomic,strong) UIImageView * imgLeftView;
@property (nonatomic,strong) UIImageView * imgRightView;
@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) UILabel * lbValueLb;
@property (nonatomic,strong) UIView * viLineView;
@property (nonatomic,strong) UIButton * btnAction;


@end
@implementation LSCreditRowCellView


-(instancetype)initWithTitle:(NSString *)title value:(NSString *)value target:(NSObject *)obj action:(SEL)action{
    _titleFontSize = 15;
    _valueFontSize = 12;
    _imgLeftSize = 20;
    _titleMarginImgLeft = 10;
    _contentMargin = 12;
    _lineEdgeInsets = UIEdgeInsetsMake(0, _contentMargin, 0, _contentMargin);
    self.titleStr = title;
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];

        [self setupViews];
        [self.btnAction addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setIsHideLine:(BOOL)isHideLine{
    _isHideLine = isHideLine;
    self.viLineView.hidden = _isHideLine;
}
-(void)setIsHideRightImg:(BOOL)isHideRightImg{
    _isHideRightImg = isHideRightImg;
    self.imgRightView.hidden = _isHideRightImg;
}
-(void)setTitleFontSize:(CGFloat)titleFontSize{
    _titleFontSize = titleFontSize;
    self.lbTitleLb.font = [UIFont systemFontOfSize:_titleFontSize];
    [_lbTitleLb sizeToFit];
}
-(void)setValueFontSize:(CGFloat)valueFontSize{
    _valueFontSize = valueFontSize;
    self.lbValueLb.font = [UIFont systemFontOfSize:_valueFontSize];
    [_lbValueLb sizeToFit];
}
-(void)setImgLeftSize:(CGFloat)imgLeftSize{
    _imgLeftSize = imgLeftSize;
    
}
-(void)setLineEdgeInsets:(UIEdgeInsets)lineEdgeInsets{
    _lineEdgeInsets = lineEdgeInsets;
    self.viLineView.width = self.width - _lineEdgeInsets.left-_lineEdgeInsets.right;
    self.viLineView.left = _lineEdgeInsets.left;
}
-(void)setContentMargin:(CGFloat)contentMargin{
    _contentMargin = contentMargin;
}
-(void)setSeparatorStyle:(LSCreditSeparatorStyle)separatorStyle{
    _separatorStyle = separatorStyle;
    if (_separatorStyle == LSCreditSeparatorStyleDotted) {
        [self.viLineView setBackgroundColor:[UIColor clearColor]];
        [self.viLineView drawLineLength:5 lineSpacing:4 lineColor:[UIColor colorWithHexString:COLOR_BORDER_STR] lineDirection:YES];
    }else{
        [self.viLineView setBackgroundColor:[UIColor colorWithHexString:COLOR_BORDER_STR]];
    }
}
-(void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    self.lbValueLb.text = _valueStr;
    [self.lbValueLb sizeToFit];
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.lbTitleLb.text = _titleStr;
    [self.lbTitleLb sizeToFit];
}
-(void)setTitleColor:(NSString *)titleColor{
    _titleColor = titleColor;
    self.lbTitleLb.textColor = [UIColor colorWithHexString:titleColor];
}

-(void)setValueColor:(NSString *)valueColor{
    _valueColor = valueColor;
    self.lbValueLb.textColor = [UIColor colorWithHexString:valueColor];
}

-(void)setTitleImageStr:(NSString *)titleImageStr{
    _titleImageStr = titleImageStr;
    self.imgLeftView.image = [UIImage imageNamed:titleImageStr];
}
-(UIImageView *)imgLeftView{
    if (!_imgLeftView) {
        _imgLeftView  = [[UIImageView alloc]init];
        [_imgLeftView setFrame:CGRectMake(_contentMargin, 0, _imgLeftSize, _imgLeftSize)];
        _imgLeftView.contentMode = UIViewContentModeCenter;
    }
    return _imgLeftView;
}
-(UIImageView *)imgRightView{
    if (!_imgRightView) {
        _imgRightView  = [[UIImageView alloc]init];
        [_imgRightView setFrame:CGRectMake(_contentMargin, 0, 8, 14)];
        [_imgRightView setImage:[UIImage imageNamed:@"XL_common_right_arrow"]];
    }
    return _imgRightView;
}
-(UILabel*)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        _lbTitleLb.left = self.imgLeftView.right+_titleMarginImgLeft;
        [_lbTitleLb setFont:[UIFont systemFontOfSize:_titleFontSize]];
        [_lbTitleLb setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
        _lbTitleLb.textAlignment = NSTextAlignmentLeft;
    }
    return _lbTitleLb;
}

-(UILabel *)lbValueLb{
    if (!_lbValueLb) {
        _lbValueLb = [[UILabel alloc]init];
        [_lbValueLb setFont:[UIFont systemFontOfSize:_valueFontSize]];
        [_lbValueLb setTextColor:[UIColor colorWithHexString:COLOR_GRAY_STR]];
        _lbValueLb.textAlignment = NSTextAlignmentRight;
    }
    return _lbValueLb;
}
-(UIView*)viLineView{
    if (!_viLineView) {
        _viLineView = [[UIView alloc]init];
        [_viLineView setFrame:CGRectMake(_lineEdgeInsets.left, 0, self.width-_lineEdgeInsets.left-_lineEdgeInsets.right, 0.5)];
        _viLineView.bottom = self.height;
        [_viLineView setBackgroundColor:[UIColor colorWithHexString:COLOR_DEEPBORDER_STR]];
    }
    return _viLineView;
}
-(UIButton*)btnAction{
    if (!_btnAction) {
        _btnAction = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAction setFrame:CGRectMake(0, 0, self.width, self.height)];
        UIImage * imgH = [UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        [_btnAction setBackgroundImage:imgH forState:UIControlStateHighlighted];
    }
    return _btnAction;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_imgLeftView setFrame:CGRectMake(_contentMargin, 0.0, _imgLeftSize, _imgLeftSize)];
    _lbTitleLb.left = _imgLeftView.right+_titleMarginImgLeft;
    _imgRightView.right = self.right - _contentMargin;
    _lbValueLb.right = _imgRightView.left - 10.0;
    
    _viLineView.bottom = self.height - 0.5;
    _imgLeftView.centerY = self.height/2.0;
    _lbTitleLb.centerY = self.height/2.0;
    _lbValueLb.centerY = self.height/2.0;
    _imgRightView.centerY = self.height/2.0;
    [_btnAction setFrame:CGRectMake(0.0, 0.0, self.width, self.height)];
}

-(void)setupViews{
    [self addSubview:self.btnAction];
    [self addSubview:self.imgLeftView];
    [self addSubview:self.lbTitleLb];
    [self addSubview:self.imgRightView];
    [self addSubview:self.lbValueLb];
    [self addSubview:self.viLineView];
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
   
    
}

@end
