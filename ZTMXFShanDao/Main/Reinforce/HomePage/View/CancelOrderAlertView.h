//
//  CancelOrderAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderGoodsInfoModel;

typedef void(^clickHandle)(void);

@interface CancelOrderAlertView : UIView

+ (void)showAlertViewWithTitle:(NSString *)title GoodsInfo:(OrderGoodsInfoModel *)goodsInfo Cancel:(NSString *)cancelButton Click:(clickHandle)cancelClick  OtherButton:(NSString *)buttonTitle Click:(clickHandle)sureClick;

@end
