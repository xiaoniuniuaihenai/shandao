//
//  LSCreditPassAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditPassAlertView.h"

@interface LSCreditPassAlertView ()


@property (weak, nonatomic) IBOutlet UIButton *readButton;

@end

@implementation LSCreditPassAlertView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.height = Main_Screen_Height;
    self.width = Main_Screen_Width;
    self.top  = 0;
    self.left = 0;
}

#pragma mark - 点击已阅按钮
- (IBAction)clickReadBtn:(UIButton *)sender {
    
    [self hidden];
}



-(void)show{
    self.alpha = 1;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    _readButton.userInteractionEnabled = YES;
    //
    //    [UIView animateWithDuration:.2 animations:^{
    //        _viMainView.alpha =1;
    //        _btnHideBtn.userInteractionEnabled = YES;
    //    }];
}
-(void)hidden{
    [UIView animateWithDuration:.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
- (void)setAwardMoney:(NSString *)awardMoney{
    _awardMoney = awardMoney;
    
    NSString *moneyStr = [NSString stringWithFormat:@"￥%@",_awardMoney];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:moneyStr];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:[moneyStr rangeOfString:@"￥"]];
    _amountLabel.attributedText = attStr;
}

@end
