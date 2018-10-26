//
//  ChoiseBankCardPopupView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/17.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardModel;

@protocol ChoiseBankCardPopupViewDelegate <NSObject>

/** 选中银行卡 */
- (void)choiseBankCardPopupViewSelectBankCard:(BankCardModel *)bankCardModel;
/** 添加银行卡 */
- (void)choiseBankCardPopupViewAddBankCard;

@end


@interface ChoiseBankCardPopupView : UIView

//  弹出选择分期方式view
+ (instancetype)popupView;
//  弹框取消
- (void)dismiss;

/** 选中银行卡id */
@property (nonatomic, strong) BankCardModel *selectedBankCardModel;

@property (nonatomic, weak) id<ChoiseBankCardPopupViewDelegate> delegate;


@end
