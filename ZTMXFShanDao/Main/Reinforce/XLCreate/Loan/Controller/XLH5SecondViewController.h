//
//  XLH5SecondViewController.h
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/7/26.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@interface XLH5SecondViewController : BaseViewController

/** 加载URL字符串 */
@property (nonatomic, copy) NSString *webUrlStr;
/* 是否从强风控 等待进入 */
@property (nonatomic,assign) BOOL isUpRiskWait;

@property (nonatomic, strong) WKWebView *webView;
/* 是否是第一个页面 */
@property (nonatomic,assign) BOOL isHomePage;
//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;
/** 是否需要刷新 */
@property (nonatomic, assign)BOOL isRef;
/**首页 URL*/
@property (nonatomic, copy)NSString * recordUrl;

- (void)addAppInfo;
@end
