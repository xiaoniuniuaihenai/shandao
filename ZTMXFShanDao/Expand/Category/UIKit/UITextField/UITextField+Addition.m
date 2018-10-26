//
//  UITextField+Addition.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UITextField+Addition.h"

@implementation UITextField (Addition)

+ (instancetype)textfieldWidthPlaceHolder:(NSString *)placeHolder placeHolderColorStr:(NSString *)placeHolderColorStr textColor:(NSString *)textColor textSize:(CGFloat)textSize leftMargin:(CGFloat)left{
    
    UITextField *textfiled = [[UITextField alloc] init];
    if (textSize < 0) {
        textSize = 14.0;
    }
    textfiled.font = [UIFont systemFontOfSize:textSize];
    if (placeHolder) {
        textfiled.placeholder = placeHolder;
    }
    if (textColor) {
        textfiled.textColor = [UIColor colorWithHexString:textColor];
    } else {
        textfiled.textColor = [UIColor colorWithHexString:@"111111"];
    }
    if (placeHolderColorStr) {
        if (textfiled.placeholder) {
            textfiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textfiled.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:placeHolderColorStr]}];
        }
    }
    textfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (left > 0) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, left, 10.0)];
        leftView.backgroundColor = [UIColor clearColor];
        textfiled.leftView = leftView;
        textfiled.leftViewMode = UITextFieldViewModeAlways;
    }
    return textfiled;
}


@end
