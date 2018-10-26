//
//  LSPositionViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@protocol LSChoosePositionDelegete <NSObject>

@optional
- (void)choosePosition:(NSString *)positionTitle;

@end

@interface ZTMXFPositionViewController : BaseViewController

@property (nonatomic, weak) id <LSChoosePositionDelegete> delegete;

@property (nonatomic, copy) NSString *industryName;

@end
