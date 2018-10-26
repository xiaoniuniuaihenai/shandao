//
//  ZTMXFMineTableFooterView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ActionBlock)(void);

@interface ZTMXFMineTableFooterView : UIView
@property (nonatomic, copy)   ActionBlock customerServiceButtonClickBlock;
@end
