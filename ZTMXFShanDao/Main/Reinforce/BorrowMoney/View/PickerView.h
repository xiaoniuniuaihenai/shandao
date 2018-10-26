//
//  PickerView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegete <NSObject>

@optional
- (void)choosePurposeWithTitle:(NSString *)title;

@end

@interface PickerView : UIView

@property (nonatomic, weak) id <PickerViewDelegete> delegete;

-(instancetype)initWithTitleArray:(NSArray *)titleArray;

- (void)show;

@end
