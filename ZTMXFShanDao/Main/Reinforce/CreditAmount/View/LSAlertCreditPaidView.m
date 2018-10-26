//
//  LSAlertCreditPaidView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAlertCreditPaidView.h"

@implementation LSAlertCreditPaidView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.height = Main_Screen_Height;
    self.width = Main_Screen_Width;
    self.top  = 0;
    self.left = 0;
}

- (IBAction)btnHideBtnClick:(UIButton *)sender {
    [self hidden];
}


-(void)hidden{
    [UIView animateWithDuration:.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
-(void)show{
    self.alpha = 1;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    _btnHideBtn.userInteractionEnabled = YES;
    //
    //    [UIView animateWithDuration:.2 animations:^{
    //        _viMainView.alpha =1;
    //        _btnHideBtn.userInteractionEnabled = YES;
    //    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
