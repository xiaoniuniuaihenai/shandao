//
//  LSInputRowCellView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTMXFCreditxTextField;

typedef NS_ENUM(NSInteger,InputRowCellStyle) {
    InputRowCellStyleDef = 0, //可编辑
    InputRowCellStyleNoEdit,  //不可编辑
    InputRowCellStyleChoose, // 选择
    InputRowCellStyleCode,   // 验证码
};
@interface LSInputRowCellView : UIView
@property (nonatomic,copy) NSString * valueColor;
@property (nonatomic,copy) NSString * titleColor;
@property (nonatomic,assign) CGFloat titleFontSize;
@property (nonatomic,assign) CGFloat valueFontSize;
@property (nonatomic,assign) CGFloat contentMargin;
@property (nonatomic,assign) CGFloat valueMargin;
@property (nonatomic,assign) UIEdgeInsets lineEdgeInsets;
@property (nonatomic,assign) BOOL isHideLine;
@property (nonatomic,strong) ZTMXFCreditxTextField * textField;
@property (nonatomic,strong) UIButton * btnChoose;
@property (nonatomic,strong) UIButton * btnCodel;
-(instancetype)initWithCellStyle:(InputRowCellStyle)cellStyle title:(NSString*)title value:(NSString*)value placeholder:(NSString*)placeholder;


@end
