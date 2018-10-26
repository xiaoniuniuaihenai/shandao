//
//  LSProgressView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/31.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSProgressView : UIView
@property(nonatomic) float progress;
@property(nonatomic, strong, nullable) UIColor* progressTintColor;
@property(nonatomic, strong, nullable) UIColor* trackTintColor;

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
