//
//  LSAssistiveTouchView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  悬浮框

#import <UIKit/UIKit.h>

@interface LSAssistiveTouchView : UIView
-(instancetype)initWithAssistiveTouchWithDelegate:(id)delegate andBgColor:(NSString*)hexStr andTitle:(NSString*)title;
@property (nonatomic,assign) CGFloat maxY;
@property (nonatomic,assign) CGFloat minY;

@end
@protocol LSAssistiveTouchViewDelegate <NSObject>

@optional
-(void)assistiveTouchViewAction;
@end
