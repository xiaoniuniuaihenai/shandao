//
//  XLCreditxTextField.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/7/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCreditxTextField.h"
#import <CXBehaviorSDK/CXInputContentEncoder.h>

@implementation ZTMXFCreditxTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        [self add];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self add];
    }
    return self;
}

- (void)add{
    [self addTarget:self
             action:@selector(loginUserIDTextFieldDidChange:)
   forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self
             action:@selector(loginUserIDTextFieldDidBegin:)
   forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self
             action:@selector(loginUserIDTextFieldDidEnd:)
   forControlEvents:UIControlEventEditingDidEnd];
}

- (void)loginUserIDTextFieldDidChange:(UITextField *)sender {
    NSString *encodedText = [CXInputContentEncoder encode:sender.text];
    [CreditXAgent onInput:self.inputActionName contentChanged:encodedText];    
}
- (void)loginUserIDTextFieldDidBegin:(UITextField *)sender {
    [CreditXAgent onInput:self.inputActionName focusChanged:YES];
    if (self.inputActionName == CXInputBindDebitCardNumber) {//绑卡页面卡号
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"input.xfd_yhkrz_kh" OtherDict:nil];
    }else if(self.inputActionName == CXInputBindDebitCardContactPhone){//银行预留手机号
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"input.xfd_yhkrz_sjh" OtherDict:nil];
    }
}
- (void)loginUserIDTextFieldDidEnd:(UITextField *)sender {
    [CreditXAgent onInput:self.inputActionName focusChanged:NO];
}

@end
