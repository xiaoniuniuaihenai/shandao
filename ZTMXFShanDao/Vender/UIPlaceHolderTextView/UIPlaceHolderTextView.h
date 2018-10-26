//
//  UIPlaceHolderTextView.h
//  MobileProject 带有提示输入的TextView


#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView
@property (nonatomic, strong) UILabel *placeHolderLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
