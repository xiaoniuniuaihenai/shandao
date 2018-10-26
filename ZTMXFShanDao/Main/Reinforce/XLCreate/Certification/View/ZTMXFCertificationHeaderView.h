//
//  ZTMXFCertificationHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UICountingLabel, LSCreditAuthModel;
@interface ZTMXFCertificationHeaderView : UIImageView

/** 额度页面数据Model */
@property (nonatomic, strong)LSCreditAuthModel *creditAuthModel;

@property (nonatomic, strong) UILabel *headAmountLabel;

@property (nonatomic, strong) UILabel * maxTextLabel;

@end
