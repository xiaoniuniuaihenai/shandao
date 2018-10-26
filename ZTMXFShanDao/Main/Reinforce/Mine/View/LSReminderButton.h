//
//  LSReminderButton.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSReminderButton : UIButton

@property (nonatomic, strong) UILabel *reminderCountLabel;

- (void)showReminderCount:(NSString *)count;

- (void)showRedReminderCount:(NSString *)count;

@end
