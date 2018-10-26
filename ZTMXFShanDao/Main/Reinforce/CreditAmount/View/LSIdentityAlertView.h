//
//  LSIdentityAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSIdentityAlertViewDelegete <NSObject>

@optional
- (void)clickTryButton;

@end

@interface LSIdentityAlertView : UIView

@property (nonatomic, weak) id <LSIdentityAlertViewDelegete> delegete;

-(void)show;

@end
