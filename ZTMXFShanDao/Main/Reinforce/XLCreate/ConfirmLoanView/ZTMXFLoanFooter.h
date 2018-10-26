//
//  ZTMXFLoanFooter.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBorrwingCashInfoModel;

typedef void(^ClickProtocolButtonBlock)(void);

@interface ZTMXFLoanFooter : UIView

@property (nonatomic, strong)UIButton * agreeBtn;

@property (nonatomic, strong)UIButton * submitBtn;

@property (nonatomic, strong) LSBorrwingCashInfoModel * cashInfoModel;

@property (nonatomic, copy) ClickProtocolButtonBlock clickProtocolButton;

@end
