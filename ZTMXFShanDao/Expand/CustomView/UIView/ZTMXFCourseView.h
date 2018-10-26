//
//  CourseView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  教程view

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LSAlipayType) {
    LSAlipayOrderType,
    LSAlipayProofType
};

@interface ZTMXFCourseView : UIView

/** scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;

//  弹出教程view
+ (instancetype)popupCourseViewType:(LSAlipayType)alipayType;

@end
