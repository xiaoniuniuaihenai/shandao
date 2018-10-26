//
//  LSSupplementCertificationView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSupplementCertificationView.h"
#import "UIView+Administer.h"

@implementation LSSupplementCertificationView





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [_viMainView.layer  setShadowColor:[UIColor blackColor].CGColor];
    [_viMainView.layer setShadowOffset:CGSizeMake(0,0)];
    _viMainView.layer.shadowRadius = 8;
    [_viMainView.layer setShadowOpacity:.1];
    _viMainView.layer.cornerRadius = 5.0;
    _viMainView.clipsToBounds = YES;
    
    [_viLineOne drawLineLength:5 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"eaeaea"] lineDirection:YES];
    [_viLineTwo drawLineLength:5 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"eaeaea"] lineDirection:YES];
    [_viLineThree drawLineLength:5 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"eaeaea"] lineDirection:YES];

}
-(void)awakeFromNib{
    [super awakeFromNib];
    UIImage * imgH = [UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [_btnCellOne setBackgroundImage:imgH forState:UIControlStateHighlighted];
    [_btnCellTwo setBackgroundImage:imgH forState:UIControlStateHighlighted];
    [_btnCellThree setBackgroundImage:imgH forState:UIControlStateHighlighted];
    
}

@end
