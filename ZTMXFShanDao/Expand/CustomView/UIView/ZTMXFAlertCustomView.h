//
//  LSAlertCustomView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockBtnClick)(void);
@interface ZTMXFAlertCustomView : UIView
-(instancetype)initWithMessage:(NSAttributedString*)msg btnTitle:(NSString*)title;
@property (nonatomic,copy) BlockBtnClick btnClick;
-(void)showAlertView;
@end
