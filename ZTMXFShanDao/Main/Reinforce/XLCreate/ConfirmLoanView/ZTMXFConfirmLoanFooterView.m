//
//  ZTMXFConfirmLoanFooterView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFConfirmLoanFooterView.h"
#import "AlertSheetActionManager.h"
#import "UIViewController+Visible.h"
#import "LSBorrwingCashInfoModel.h"

@implementation ZTMXFConfirmLoanFooterView

- (void)agreeButtonClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
}

- (void)clickProtocolBtn{
    NSArray * arrActionTitle = @[@"《闪到借款协议》",@"《委托融资协议》"];
    //    MJWeakSelf
    [AlertSheetActionManager sheetActionTitle:@"协议" message:nil arrTitleAction:arrActionTitle superVc:[UIViewController currentViewController] blockClick:^(NSInteger index) {
        NSString * userName = [LoginManager userPhone];
        NSString *purposeStr = @"";
        if (_cashInfoModel.borrowApplications.count >0) {
            purposeStr = _cashInfoModel.borrowApplications[0];
        }
        NSString * webUrl = @"";
        if (index==0) {
            webUrl = DefineUrlString(personalCashProtocol(userName,@"",_cashInfoModel.amount,@"",@"1001"));
        }else{
            webUrl = DefineUrlString(entrustBorrowCashProtocol(@"",_cashInfoModel.amount,@"2"));
        }
        
        LSWebViewController *borrowNumVC = [[LSWebViewController alloc] init];
        borrowNumVC.webUrlStr = webUrl;
        [[UIViewController currentViewController].navigationController pushViewController:borrowNumVC animated:YES];
    }];
}




- (void)configUI{
    self.backgroundColor = K_BackgroundColor;
    self.agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.agreeButton setImage:[UIImage imageNamed:@"XL_Confirm_Loan_UnAgree"] forState:UIControlStateNormal];
    [self.agreeButton setImage:[UIImage imageNamed:@"XL_Confirm_Loan_Seleted"] forState:UIControlStateSelected];
    [self.agreeButton addTarget:self action:@selector(agreeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _agreeButton.frame = CGRectMake(0, 0, X(40), X(40));
    [self addSubview:_agreeButton];
    
    
    UIButton *agreeProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeProtocolBtn setFrame:CGRectMake(_agreeButton.right,0, 260 * PX, X(40))];
    [agreeProtocolBtn addTarget:self action:@selector(clickProtocolBtn) forControlEvents:UIControlEventTouchUpInside];
    agreeProtocolBtn.titleLabel.font = FONT_Regular(12 * PX);
    //        NSString *protocolText = @"我已经阅读并且同意《讯秒借款协议》和《委托融资协议》";
    NSString * protocolText = @"同意《闪到相关协议》并自愿购买商品";
    agreeProtocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    NSMutableAttributedString *protocolAttrStr = [[NSMutableAttributedString alloc] initWithString:protocolText];
    [protocolAttrStr addAttribute:NSForegroundColorAttributeName value:COLOR_SRT(@"4285E9") range:[protocolText rangeOfString:@"《闪到相关协议》"]];
    [agreeProtocolBtn setAttributedTitle:protocolAttrStr forState:UIControlStateNormal];
    [agreeProtocolBtn setTitleColor:COLOR_SRT(@"000000") forState:UIControlStateNormal];
    [self addSubview:agreeProtocolBtn];

}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
@end
