//
//  ZTMXFSecurityPayViewController.h
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  安全验证

#import "ZTMXFTableViewController.h"
@protocol ZTMXFSecurityPayViewControllerDelegate <NSObject>

@optional

- (void)signCompleteBankCardId:(NSString *)bankCardId;


@end

@interface ZTMXFSecurityPayViewController : ZTMXFTableViewController

@property (nonatomic, copy)NSDictionary * bankInfoDic;

@property (nonatomic, copy)NSString * bankCardId;

@property (nonatomic, strong)NSMutableDictionary * paramDict;


@property (nonatomic, weak) id<ZTMXFSecurityPayViewControllerDelegate> delegate;


@end



