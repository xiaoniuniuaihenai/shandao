//
//  LSBasicsCertificationView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  基础认证
#import "UIView+Administer.h"
#import "LSBasicsCertificationView.h"
@implementation LSBasicsCertificationView
-(void)awakeFromNib{
    [super awakeFromNib];
    UIImage * imgSelect = [UIImage imageWithColor:K_CCCCCC];
    [_btnSubmitBtn setBackgroundImage:imgSelect forState:UIControlStateSelected];
    _btnSubmitBtn.clipsToBounds = YES;
    
    UIImage * imgH = [UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [_btnCellOne setBackgroundImage:imgH forState:UIControlStateHighlighted];
    [_btnCellContacts setBackgroundImage:imgH forState:UIControlStateHighlighted];
    [_btnCellMobile setBackgroundImage:imgH forState:UIControlStateHighlighted];
    
    [self addSubview:self.viBottomView];
    
}


-(void)basicsViewCertificationEnabled:(BOOL)isEnabled{
    _btnCellOne.userInteractionEnabled = isEnabled;
    _btnCellContacts.userInteractionEnabled = isEnabled;
    _btnCellMobile.userInteractionEnabled = isEnabled;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    _viBottomView.top = _viMainView.bottom+10;
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];

    [_viBottomView setFrame:CGRectMake(0, _viMainView.bottom+10, self.width, 100)];
    [_viBottomView layoutIfNeeded];
    _viBottomView.top = _viMainView.bottom+10;


    [_btnSubmitBtn.layer setBorderWidth:1];
    [_btnSubmitBtn.layer setBorderColor:[UIColor colorWithHexString:@"eaeaea"].CGColor];
    [_btnSubmitBtn.layer setCornerRadius:AdaptedWidth(44)/2.];
    [_viLineOne drawLineLength:5 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"eaeaea"] lineDirection:YES];
    [_viLineTwo drawLineLength:5 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"eaeaea"] lineDirection:YES];

 
}
-(LSBasicsBottomView*)viBottomView{
    if (!_viBottomView) {
        _viBottomView = [[NSBundle mainBundle]loadNibNamed:@"LSBasicsBottomView" owner:nil options:nil].firstObject;
        [_viBottomView setFrame:CGRectMake(0, _viMainView.bottom+AdaptedWidth(10), self.width, 100)];
    }
    return _viBottomView;
}

@end
