//
//  LSIndustryViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@protocol LSChooseIndustryDelegete <NSObject>

@optional
- (void)chooseIndustry:(NSString *)industryTitle;

@end

@interface ZTMXFIndustryViewController : BaseViewController

@property (nonatomic, weak) id <LSChooseIndustryDelegete> delegete;

@end
