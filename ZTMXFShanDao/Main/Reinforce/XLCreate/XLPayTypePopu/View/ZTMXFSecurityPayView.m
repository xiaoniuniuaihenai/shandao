//
//  ZTMXFSecurityPayView.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/7.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFSecurityPayView.h"
#import "TTTAttributedLabel.h"
#import <UIButton+WebCache.h>
#import "JKCountDownButton.h"
@interface ZTMXFSecurityPayView ()<TTTAttributedLabelDelegate>

@end


@implementation ZTMXFSecurityPayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = K_BackgroundColor;
        
        UIView * topWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KW, 44 * PX)];
        topWhiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topWhiteView];

        UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(11, 13 * PX, 4 * PX, 18 * PX)];
        rightView.backgroundColor = K_MainColor;
        rightView.layer.cornerRadius = rightView.width / 2;
        [topWhiteView addSubview:rightView];
        
        
        UILabel * topLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightView.right + 5, 0, KW, 44 * PX)];
        topLabel.text = @"为了您的账户安全，银行需要校验您的手机验证码";
        topLabel.font = FONT_Regular(14 * PX);
        topLabel.textColor = K_MainColor;
        [topWhiteView addSubview:topLabel];
        
        UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, topWhiteView.bottom + 1, KW, 158 * PX)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        

        NSArray * titleArr = @[@"您选择的银行",@"预留手机号码",@"短信验证"];
        for (int i = 0; i < titleArr.count; i++) {
            UILabel * textL = [[UILabel alloc] initWithFrame:CGRectMake(11, i * 53 * PX, 100 * PX, 52 * PX)];
            textL.text = titleArr[i];
            textL.textColor = K_333333;
            textL.font = FONT_Regular(14 * PX);
            [whiteView addSubview:textL];
            
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(textL.left, textL.bottom, KW, 1)];
            lineView.backgroundColor = K_BackgroundColor;
            [whiteView addSubview:lineView];
            if (i == 0) {
                
                _bankCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(KW - 82 * PX, 16 * PX, 72 * PX, 20 * PX)];
                _bankCardLabel.font = FONT_Regular(14 * PX);
                _bankCardLabel.textColor = K_333333;
                _bankCardLabel.textAlignment = NSTextAlignmentRight;
                [whiteView addSubview:_bankCardLabel];
                
                _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_bankCardLabel.left - 20 * PX, _bankCardLabel.top, 20 * PX, _bankCardLabel.height)];
                [whiteView addSubview:_imgView];
                
                
            }else if (i == 1){
                _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KW - 122 * PX, textL.top, 110 * PX, textL.height)];
                _phoneLabel.textAlignment = NSTextAlignmentRight;
                _phoneLabel.textColor = K_333333;
                _phoneLabel.font = FONT_Regular(14 * PX);
                [whiteView addSubview:_phoneLabel];
                
            }else if (i == 2){
                _codeTF = [[UITextField alloc] initWithFrame:CGRectMake(113 * PX, textL.top, 140 * PX, textL.height)];
                _codeTF.placeholder = @"请输入验证码";
                _codeTF.font = FONT_Regular(14 * PX);
                _codeTF.borderStyle = UITextBorderStyleNone;
                _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
                _codeTF.keyboardType = UIKeyboardTypeNumberPad;
                [whiteView addSubview:_codeTF];
                
                _getCodeButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
                _getCodeButton.frame = CGRectMake(KW - 102 * PX, textL.top + 11 * PX, 90 * PX, 32 * PX);
                _getCodeButton.layer.borderColor = K_MainColor.CGColor;
                _getCodeButton.layer.borderWidth = 1;
                [_getCodeButton setTitleColor:K_MainColor forState:UIControlStateNormal];
                [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                _getCodeButton.titleLabel.font = FONT_Regular(14 * PX);
                _getCodeButton.layer.cornerRadius = 3;

                [whiteView addSubview:_getCodeButton];
                
                [self.getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                    NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                    return title;
                }];
                [self.getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                    countDownButton.enabled = YES;
                    countDownButton.layer.borderColor = K_MainColor.CGColor;
                    [countDownButton setTitleColor:K_MainColor forState:UIControlStateNormal];

                    return @"重新获取";
                }];
                
             
            }
        }
        
        
        
        UILabel * bottomLabel = [[UILabel alloc] init];
        bottomLabel.text = @"如您银行卡信息已变更，请换卡操作，或 ";
        bottomLabel.font = FONT_Regular(14 * PX);
        bottomLabel.textColor = K_888888;
        bottomLabel.frame = CGRectMake(topLabel.left, whiteView.bottom + 20, KW, 20 * PX);
        [self addSubview:bottomLabel];
        [bottomLabel sizeToFit];
        
        _addBankCard = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBankCard.frame =CGRectMake(bottomLabel.right + 3, bottomLabel.top, 56 * PX, bottomLabel.height);
        [_addBankCard setTitleColor:K_2B91F0 forState:UIControlStateNormal];
        [_addBankCard setTitle:@"添加新卡" forState:UIControlStateNormal];
        [self addSubview:_addBankCard];
        _addBankCard.titleLabel.font = FONT_Regular(14 * PX);
        
    }
    return self;
}

- (void)setBankInfoDic:(NSDictionary *)bankInfoDic
{
    _bankInfoDic = bankInfoDic;
    NSString * imgUrl = bankInfoDic[@"bankIcon"]?:@"";
    NSString* bankNum = bankInfoDic[@"cardNumber"]?:@"";
    if (bankNum.length > 4) {
        bankNum = [NSString stringWithFormat:@"尾号%@", [bankNum substringFromIndex:bankNum.length - 4]];
    }
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    _bankCardLabel.text = bankNum;
    NSString* phone = bankInfoDic[@"mobile"]?:@"";

    if (phone.length>7) {
        self.phoneLabel.text = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@" **** "];
    }else{
        self.phoneLabel.text = phone;
    }

    
}



//- (void)attributedLabel:(TTTAttributedLabel *)label
//didSelectLinkWithAddress:(NSDictionary *)addressComponents
//{
//    NSLog(@"---------");
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
