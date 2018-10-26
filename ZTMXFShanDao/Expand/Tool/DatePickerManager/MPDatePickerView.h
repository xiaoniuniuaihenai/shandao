//
//  MPDatePickerView.h
//  MobileProject
//  日期选择器


#import <UIKit/UIKit.h>

typedef void(^selectDateBlock)(NSDate *selectDate);

typedef void(^cancelBlock)();

@interface MPDatePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

-(instancetype)initWithTitle:(NSString *)title selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate doneBlock:(selectDateBlock)doneBlock cancelBlock:(cancelBlock)cancelBlock;

@end
