//
//  ZTMXFLoanFooter.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanFooter.h"
#import "AlertSheetActionManager.h"
#import "LSWebViewController.h"
#import "LSBorrwingCashInfoModel.h"
#import "UIViewController+Visible.h"
@implementation ZTMXFLoanFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.frame = CGRectMake(0, 0, KW, TabBar_Addition_Height + 98 * PX);
        self.backgroundColor = UIColor.whiteColor;
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(20, 0, 20, 40 * PX);
        [_agreeBtn setImage:[UIImage imageNamed:@"protocolN"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"protocolSelect"] forState:UIControlStateSelected];
        [_agreeBtn addTarget:self action:@selector(agreeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_agreeBtn];
        [_agreeBtn setSelected:YES];
        
        
        UIButton *agreeProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [agreeProtocolBtn setFrame:CGRectMake(_agreeBtn.right + 5, _agreeBtn.top, 260 * PX, _agreeBtn.height)];
        [agreeProtocolBtn addTarget:self action:@selector(clickProtocolBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:agreeProtocolBtn];
        agreeProtocolBtn.titleLabel.font = FONT_Regular(12 * PX);
//        NSString *protocolText = @"我已经阅读并且同意《讯秒借款协议》和《委托融资协议》";
        NSString * protocolText = @"同意《闪到相关协议》并自愿购买商品";
        agreeProtocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      
        NSMutableAttributedString *protocolAttrStr = [[NSMutableAttributedString alloc] initWithString:protocolText];
        [protocolAttrStr addAttribute:NSForegroundColorAttributeName value:K_2B91F0 range:[protocolText rangeOfString:@"《闪到相关协议》"]];
//        [protocolAttrStr addAttribute:NSForegroundColorAttributeName value:K_MainColor range:[protocolText rangeOfString:@"《委托融资协议》"]];
        [agreeProtocolBtn setAttributedTitle:protocolAttrStr forState:UIControlStateNormal];
        [agreeProtocolBtn setTitleColor:COLOR_SRT(@"ABABAB") forState:UIControlStateNormal];
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(X(20), agreeProtocolBtn.bottom , KW - X(40), 44 * PX);
        _submitBtn.backgroundColor = K_MainColor;
        [_submitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = _submitBtn.height/2;
        [_submitBtn setTitle:@"立即提现" forState:UIControlStateNormal];
        [self addSubview:_submitBtn];
    }
    return self;
}

-(void)clickProtocolBtn{
    if (self.clickProtocolButton) {
        self.clickProtocolButton();
    }
}
- (void)agreeBtnAction
{
    _agreeBtn.selected = !_agreeBtn.selected;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
