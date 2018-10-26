//
//  XNPushTipView.h
//  ChatDemo
//
//  Created by NTalker-zhou on 16/12/20.
//  Copyright © 2016年 NTalker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNPushTipModel.h"


#define  pushViewHeight 74.0
#define  pushViewTopBackHeight 36
#define  leftMargin 8
#define  pushViewWidth  ([UIScreen mainScreen].bounds.size.width-2*8)

@interface XNPushTipView : UIView
@property (nonatomic ,strong) XNPushTipModel *model;

+(instancetype)shareInstance;
+ (void)show;
+ (void)hide;

@end
