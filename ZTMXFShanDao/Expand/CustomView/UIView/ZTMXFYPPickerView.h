//
//  YPPickerView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPPickerViewDelegate <NSObject>

/** 选中当前value */
- (void)pickerViewSelectValue:(NSString *)currentValue;

@end

@interface ZTMXFYPPickerView : UIView
/** 数组 */
@property (nonatomic, strong) NSArray *pickerDataArray;

/** 显示数组 */
+ (void)showPickerViewWithData:(NSArray *)dataArray pickerDelegate:(id)delegate;

//  取消pickerView
- (void)hiddenPickerViewWithAnimation:(BOOL)animation;

@property (nonatomic, weak) id<YPPickerViewDelegate> delegate;

@end
