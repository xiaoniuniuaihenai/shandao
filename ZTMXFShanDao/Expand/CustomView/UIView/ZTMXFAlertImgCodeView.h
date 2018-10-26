//
//  LSAlertImgCodeView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  图片验证
typedef void(^BlockBtnClick)(NSString * codeStr);
//typedef void(^BlockRefreshCodeClick)(UIButton* btnCodeBtn);

#import <UIKit/UIKit.h>

@interface ZTMXFAlertImgCodeView : UIView
-(instancetype)initWithMobile:(NSString *)mobile type:(NSString *)type;
@property (nonatomic,copy) NSString * imgDataStr;
@property (nonatomic,copy) BlockBtnClick blockBtnClick;
//@property (nonatomic,copy) BlockRefreshCodeClick blockRefreshCodeClick;
-(void)showAlertView;

@end
