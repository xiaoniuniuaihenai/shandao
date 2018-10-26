//
//  AlertSheetActionManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  sheet 弹窗
typedef void(^BlockActionClick)(NSInteger index);

#import <Foundation/Foundation.h>

@interface AlertSheetActionManager : NSObject
+(void)sheetActionTitle:(NSString*)title message:(NSString *)msg arrTitleAction:(NSArray*)arrTitle superVc:(UIViewController*)superVc blockClick:(BlockActionClick)blockClick;
@end
