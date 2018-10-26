//
//  ZTMXFSecurityPayView.h
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/7.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKCountDownButton;
@interface ZTMXFSecurityPayView : UIView

@property (nonatomic, strong)UITextField * codeTF;

@property (nonatomic, strong)UILabel * bankCardLabel;

@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, strong)UILabel * phoneLabel;

@property (nonatomic, strong)UIButton * addBankCard;

@property (nonatomic, copy)NSDictionary * bankInfoDic;


/** 获取验证码按钮 */
@property (nonatomic, strong) JKCountDownButton *getCodeButton;



@end
