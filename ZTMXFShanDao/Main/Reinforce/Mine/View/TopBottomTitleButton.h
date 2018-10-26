//
//  TopBottomTitleButton.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBottomTitleButton : UIView
/** clear Button */
@property (nonatomic, strong) UIButton *clearButton;

/** top title */
@property (nonatomic, copy) NSString *topTitle;
/** bottom title*/
@property (nonatomic, copy) NSString *bottomTtile;

/** top imageStr */
@property (nonatomic, copy) NSString *topImageStr;

/** top title color */
@property (nonatomic, strong) UIColor *topTitleColor;
/** bottom title color */
@property (nonatomic, strong) UIColor *bottomTitleColor;

/** top title font */
@property (nonatomic, strong) UIFont *topTitleFont;
/** bottom title font */
@property (nonatomic, strong) UIFont *bottomTitleFont;

@property (nonatomic, copy) NSString *reminderCount;

- (instancetype)initWithTopTitle:(NSString *)topTitle bottomTitle:(NSString *)bottomTitle;

@end
