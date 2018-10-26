//
//  InstallmentCellView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstallmentCellView : UIView

/** title image str */
@property (nonatomic, copy) NSString *titleImageStr;
/** title */
@property (nonatomic, copy) NSString *titleStr;
/** subTitle */
@property (nonatomic, copy) NSString *subTitleStr;
/** value */
@property (nonatomic, strong) NSString *valueStr;

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value target:(NSObject *)obj action:(SEL)action;

@end
