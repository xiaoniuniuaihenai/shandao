//
//  LSIdCardView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/9.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickHandle)(void);

typedef void(^clickHandleWithIndex)(NSInteger index);

@protocol LSIdCardAlertDelegate <NSObject>

@optional
- (void)clickCancelBtn;
- (void)clickOtherBtn:(UIButton *)sender;

@end

@interface LSIdCardView : UIView

@property (nonatomic, weak) id <LSIdCardAlertDelegate> cardAlertDelegete;

- (instancetype)initWithTitle:(NSString *)title SubTitle:(NSString *)subTitle cancelBtn:(NSString *)cancel otherBtn:(NSString *)otherButton;

- (void)show;


+ (void)showAlertViewWithTitle:(NSString *)title SubTitle:(NSString *)subTitle CancelButton:(NSString *)cancelTitle Click:(clickHandle)clickCancel OtherButton:(NSString *)otherTitle Click:(clickHandleWithIndex)clickOthers;

@end
