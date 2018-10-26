//
//  LSFaceAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSFaceAlertViewDelegete <NSObject>

@optional
- (void)clickTryButton;

@end

@interface LSFaceAlertView : UIView

@property (nonatomic, weak) id <LSFaceAlertViewDelegete> delegete;

- (instancetype)initWithFaceTimes:(NSString *)faceCount;

-(void)show;

@end
