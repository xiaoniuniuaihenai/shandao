//
//  LSIdCardTypeListViewController.h
//  ALAFanBei
//
//  Created by Try on 2017/3/1.
//  Copyright © 2017年 讯秒. All rights reserved.
//  银行卡类型列表

#import "BaseViewController.h"
@class LSBankCardTypeModel;

@interface LSIdCardTypeListViewController : BaseViewController
//选中过得
@property (weak,nonatomic) LSBankCardTypeModel * oldBankTypeModel;
@property (nonatomic,weak) id delegate;
@end

@protocol LSIdCardTypeListDelegate
@optional
-(void)didSelecteBankCardTypeWith:(LSBankCardTypeModel*)bankCardTypeModel;
@end
