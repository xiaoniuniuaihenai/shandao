//
//  LSWebViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
@class ALAWebProgressLayer;

@interface LSWebViewController : BaseViewController
/** 加载URL字符串 */
@property (nonatomic, copy) NSString *webUrlStr;

/** 是否添加appInfo参数()  YES (不添加)  NO(添加)  无效参数  */
@property (nonatomic, assign) BOOL appInfoIgnore;
/* 是否从强风控 等待进入 */
@property (nonatomic,assign) BOOL isUpRiskWait;
/* 是否从借贷超市进入 */
@property (nonatomic,assign) BOOL isBrwMarketIn;

@property (nonatomic, strong) WKWebView *webView;

@end
