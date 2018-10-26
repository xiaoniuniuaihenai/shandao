//
//  LSFaceTimesLimitAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSFaceLimitAlertViewDelegete <NSObject>

@optional
- (void)clickKnowButton;

@end

@interface LSFaceTimesLimitAlertView : UIView

@property (nonatomic, weak) id <LSFaceLimitAlertViewDelegete> delegete;

- (instancetype)initWithFaceDate:(NSString *)faceDate;

-(void)show;

@end
