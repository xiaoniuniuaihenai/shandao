//
//  ZTMXFMineTableHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(void);
typedef void(^CallBackBlock)(NSString *title);

@interface ZTMXFMineTableHeaderView : UIView
@property (nonatomic, copy)   ActionBlock loginButtonClickBlock;
@property (nonatomic, copy) CallBackBlock itemSeletedBlock;
@property (nonatomic, assign) BOOL loginButtonHidden;

@property (nonatomic, strong) NSArray *dataAry;

@end
