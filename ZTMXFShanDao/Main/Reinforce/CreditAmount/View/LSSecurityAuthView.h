//
//  LSSecurityAuthView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSSecurityAuthViewDelegete <NSObject>

@optional
- (void)clickSecurityAuthBtn:(NSInteger)tag;

- (void)clickServiceButtonAction;

@end

@interface LSSecurityAuthView : UIView

@property (nonatomic, weak) id<LSSecurityAuthViewDelegete>delegete;

@property (nonatomic, assign) LoanType loanType;

@end
