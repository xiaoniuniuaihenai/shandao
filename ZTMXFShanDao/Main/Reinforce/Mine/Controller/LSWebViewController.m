//
//  LSWebViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSWebViewController.h"
#import <WebKit/WebKit.h>
#import "BaseRequestSerivce.h"
#import "NSDictionary+JSONString.h"
#import "WebViewManager.h"
#import "LSMyCouponListViewController.h"
#import "XLUmengShareHelper.h"
#import "NSString+Additions.h"
#import "NSString+Base64.h"
#import "NTalkerChatViewController.h"
#import "NTalker.h"
#import "RealNameManager.h"
#import "CYLTabBarController.h"
#import "LSGoodsDetailViewController.h"
#import "ZTMXFGoodsCategoryListViewController.h"
#import "ZTMXFAuthenticationViewModel.h"
#import "LSPromoteCreditInfoModel.h"
#import "LSAuthSupplyCertifyModel.h"
#import "ZTMXFUserInfoViewModel.h"
#import "ZTMXFRateAlertView.h"
#import "NSString+DictionaryValue.h"
#import "XXYActionSheetView.h"
#import "XLCertificationHelper.h"
#import "XLAppH5ExchangeApi.h"
#import "XLH5UserInfo.h"

//#import <TKActionSheetController.h>
static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface LSWebViewController ()<WKNavigationDelegate,WKUIDelegate,UserInfoViewModelDelegate, WKScriptMessageHandler>
@property (nonatomic,strong) UIBarButtonItem* backItem;
@property (nonatomic,strong) UIBarButtonItem* closeItem;

@property (nonatomic,assign) BOOL loginInRefresh;     // 登陆需要刷新标记
//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;
/** 添加右侧UI的类型 */
@property (nonatomic, assign) CYwebAddAppUINameType addUINameType;
/** 是否返回刷新 */
@property (nonatomic, assign) UIWebViewRefreshType refreshType;

/** 认证viewModel */
@property (nonatomic, strong) ZTMXFAuthenticationViewModel *authViewModel;
/** 消费贷model */
@property (nonatomic, strong) LSPromoteCreditInfoModel *consumeLoanInfoModel;
/** 白领贷Model */
@property (nonatomic, strong) LSAuthSupplyCertifyModel *whiteLoanInfoModel;
/** 认证viewModel */
@property (nonatomic, strong) ZTMXFUserInfoViewModel *userInfoViewModel;


@end

@implementation LSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XLServerBuriedPointHelper saveUserInfo];
    
    [self.view addSubview:self.webView];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (self.webUrlStr.length > 0) {
        [self addAppInfo];
    }
    //  添加导航栏左侧按钮
    [self addLeftButton];
    //添加进度条
    [self.view addSubview:self.progressView];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([LoginManager loginState] && self.loginInRefresh) {
        self.loginInRefresh = NO;
        [self addAppInfo];
    }
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, k_Navigation_Bar_Height, self.view.bounds.size.width, 2);
        // 设置进度条的色彩
        [_progressView setTrackTintColor:K_BackgroundColor];
        _progressView.progressTintColor = K_MainColor;
    }
    return _progressView;
}


- (void)setWebUrlStr:(NSString *)webUrlStr{
    _webUrlStr = webUrlStr;
    // 去除字符串左右空格
    _webUrlStr = [_webUrlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - 右侧导航栏按钮点击事件
- (void)right_button_event:(UIButton *)sender{
    if (self.addUINameType == CYwebAddAppUINameTypeMyCoupon) {
        //  我的优惠券
        if (![LoginManager loginState]) {
            [LoginManager presentLoginVCWithController:self];
        } else {
            // 我的优惠券列表
            LSMyCouponListViewController *couponVC = [[LSMyCouponListViewController alloc] init];
            [self.navigationController pushViewController:couponVC animated:YES];
        }
    } else if (self.addUINameType == CYwebAddAppUINameTypeLastWinRank) {
        //  邀请有礼排行榜
        if (![LoginManager loginState]) {
            [LoginManager presentLoginVCWithController:self];
        } else {
            LSWebViewController *webVC = [[LSWebViewController alloc] init];
            webVC.webUrlStr = DefineUrlString(inviteRankList);
            [self.navigationController pushViewController:webVC animated:YES];
        }
    } else if (self.addUINameType == CYwebAddAppUINameTypeCustomerServices) {
        //  客服
        if (![LoginManager loginState]) {
            [LoginManager presentLoginVCWithController:self];
        } else {
            NTalkerChatViewController *chat = [[NTalker standardIntegration] startChatWithSettingId:kXNSettingId];
            chat.isHaveVoice = NO;
            chat.pushOrPresent = YES;
            [self.navigationController pushViewController:chat animated:YES];
        }
    } else if (self.addUINameType == CYwebAddAppUINameTypeShare) {
        //  分享
        if (![LoginManager loginState]) {
            [LoginManager presentLoginVCWithController:self];
        } else {
            [self.webView evaluateJavaScript:@"lsdShareData()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"%@  %@", response, error.userInfo);
                NSDictionary * resultDict = [NSDictionary initWithJsonString:response];
                [XLUmengShareHelper startShareWithDic:resultDict];
            }];
        }
    }
}

- (void)dealloc
{
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self forKeyPath:@"title" context:NULL];
}

#pragma mark - 注册监听title和进度条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView) {
            self.navigationItem.title = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        // Once complete, fade out UIProgressView
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 添加关闭按钮
- (void)addLeftButton
{
    self.navigationItem.leftBarButtonItem = self.backItem;
}
#pragma mark - 返回按钮
- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"nav_back"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn. frame=CGRectMake(15, 0, 44, 44);
        _backItem.customView = btn;
    }
    return _backItem;
}
#pragma mark - 点击返回的方法
- (void)backNative
{
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        int  y = (int)_webView.backForwardList.backList.count;
        WKBackForwardListItem * item = _webView.backForwardList.backItem;
        if ([item.initialURL.absoluteString rangeOfString:@"lsd-web/thirdPartyLink"].location != NSNotFound) {
            for (int i = y; i > 0; i--) {
                WKBackForwardListItem * item1 = _webView.backForwardList.backList[i - 1];
                if ([item1.initialURL.absoluteString rangeOfString:@"lsd-web/thirdPartyLink"].location == NSNotFound) {
                    [_webView goToBackForwardListItem:item1];
                    return;
                }
            }
            [self closeNative];
        }else{
            [self.webView goBack];
        }
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    } else if(_isUpRiskWait){
        //     NSArray * arrVc =  self.navigationController.viewControllers;
        //
        //        if (arrVc.count >= 3) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self cyl_tabBarController].selectedIndex = 1;
        });
        //        }else{
        //            [self closeNative];
        //        }
    }else{
        [self closeNative];
    }
}

- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
        [_closeItem setTintColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
    }
    return _closeItem;
}

- (void)closeNative
{
    if(_isUpRiskWait){
        [self.navigationController popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self cyl_tabBarController].selectedIndex = 1;
        });
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 页面加载过程
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = NO;
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"LSWebView did Finish URL: %@", webView.URL);
    NSString *promptCode = [NSString stringWithFormat:@"getConfigFromApp(\'%@\')",[[XLH5UserInfo sharedXLH5UserInfo].pointInfo_H5 mj_JSONString]];
    NSLog(@"%s页面获取定位信息:%@",__func__,[XLH5UserInfo sharedXLH5UserInfo].pointInfo_H5);
    [self.webView evaluateJavaScript:promptCode completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 数据加载发生错误时调用

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    //        NSLog(@"----数据加载发生错误时调用");
    //    [self.view makeCenterToast:@"数据加载失败"];
}


#pragma mark - 页面跳转的代理方法
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *requestUrl = navigationAction.request.URL;
    NSString *requestString = requestUrl.absoluteString;
    //  URL拦截
    if ([requestString hasPrefix:@"itms-services://"]) {
        //下载第三方APP
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestString]];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if ([requestString hasPrefix:@"creditx:"]) {
        //氪信H5埋点
        [CreditXAgent handleUrl:navigationAction.request.URL.absoluteString];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else  if ([self tellPhoneInterupt:requestString]) {
        //  电话拦截
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([self openNativeUrl:requestUrl]){
        //  拦截原生操作
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([self jumpAlipayInterupt:requestString]){
        //  拦截原生操作
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([requestString rangeOfString:@"about:blank"].location != NSNotFound){
        //  空页面 不跳转
        NSLog(@"空页面========");
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([requestString rangeOfString:@"itunes.apple.com"].location != NSNotFound) {
        //  跳转到app
        NSString * appUrlStr = [requestString encodingStringUsingURLEscape];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrlStr]];
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else if ([requestString rangeOfString:@"_appInfo="].location == NSNotFound){
        if ([self isEqualUrlStr:requestString]){
            NSArray * urls = [requestString componentsSeparatedByString:@"_appInfo"];
            if (urls.count == 2) {
                decisionHandler(WKNavigationActionPolicyAllow);
            }else{
                NSURL * reqURL = [NSURL URLWithString:[urls firstObject]];
                NSString *newRequestUrlStr = [self H5RequestUrlParamas:reqURL];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:newRequestUrlStr]];
                [self.webView loadRequest:request];
                NSLog(@"2 LSWebView Url: %@", newRequestUrlStr);
                decisionHandler(WKNavigationActionPolicyCancel);
            }
            
        }else{
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (BOOL)isEqualUrlStr:(NSString *)urlStr
{
    NSArray * urls = [urlStr componentsSeparatedByString:@"?"];
    if ([[urls firstObject] rangeOfString:k_letto8_Domain].location != NSNotFound) {
        return YES;
    }
    return NO;
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSURL *requestUrl = navigationResponse.response.URL;
    //    NSString *requestString = requestUrl.absoluteString;
    //  拦截导航栏添加UI控件
    [self addNavigationBarUIWithQuery:requestUrl.query];
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

//  截取打电话
- (BOOL)tellPhoneInterupt:(NSString *)urlStr{
    if ([urlStr hasPrefix:@"sms:"] || [urlStr hasPrefix:@"tel:"]) {
        NSArray * tel = [urlStr componentsSeparatedByString:@":"];
        NSString * telStr = kCustomerServicePhone;
        if (tel.count == 2) {
            telStr = [tel lastObject];
        }
        NSString * message = @"拨打客服电话";
        if ([telStr isEqualToString:kCustomerServicePhone]) {
            message = @"拨打客服电话\n工作时间9:00-23:00";
        }
        NSArray * arr = @[telStr, @"取消"];
        XXYActionSheetView *alertSheetView = [[XXYActionSheetView alloc] initWithTitle:message cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:arr actionSheetBlock:^(NSInteger index) {
            if (0 == index) {
                dispatch_after(0.3, dispatch_get_main_queue(), ^{
                    UIApplication * app = [UIApplication sharedApplication];
                    if ([app canOpenURL:[NSURL URLWithString:urlStr]]) {
                        [app openURL:[NSURL URLWithString:urlStr]];
                    }
                });
            }
        }];
        [alertSheetView xxy_show];
        return YES;
    }
    return NO;
}

//  跳转支付宝
- (BOOL)jumpAlipayInterupt:(NSString *)urlStr
{
    if ([urlStr rangeOfString:@"lsd-web/opennative"].location != NSNotFound) {
        
        NSArray *array = [urlStr componentsSeparatedByString:@"&"];
        NSString * zfType = @"";
        if (array.count > 1) {
            NSString * firstStr = [[array[1] componentsSeparatedByString:@"="] lastObject];
            NSString *str2 = @"";
            if (isIOS9) {
                str2 = [firstStr stringByRemovingPercentEncoding];
            }else{
                str2 = [firstStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            NSDictionary * dic = [str2 dictionaryValue];
            zfType =  [[array[0] componentsSeparatedByString:@"="] lastObject];;
            UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = dic[@"account"];
        }
        
        //  跳转到支付宝
        if ([zfType isEqualToString:@"ALI_PAY"]) {
            NSURL *appUrl = [NSURL URLWithString:@"alipay://"];
            BOOL openAlipay = [[UIApplication sharedApplication] openURL:appUrl];
            if (!openAlipay) {
                [self.view makeCenterToast:@"请先安装支付宝APP"];
            }
        }
        return YES;
    }
    return NO;
}

//  处理原生操作
-(BOOL)openNativeUrl:(NSURL*)url{
    BOOL openNative = NO;
    if ([url.path rangeOfString:@"opennative"].location !=NSNotFound) {
        NSString * queryStr = url.query;
        queryStr = queryStr.stringByRemovingPercentEncoding;
        NSArray *paramsArray = [queryStr componentsSeparatedByString:@"&"];
        NSString *name=@"";
        NSString *paramstring=@"";
        for (NSString *params in paramsArray) {
            if([params hasPrefix:@"name="])
            {
                name = [params substringFromIndex:5];
            } else if([params hasPrefix:@"params="]){
                paramstring = [params substringFromIndex:7];
            }
        }
        CYWebOpennativeNameType nativeNameType = [WebViewManager opennativeNameTypeWithName:name];
        switch (nativeNameType) {
            case APP_LOGIN:
            {
                //  登陆
                self.loginInRefresh = YES;
                [LoginManager presentLoginVCWithController:self];
                openNative = YES;
            }
                break;
            case APP_SHARE:
            {
                //  打开分享
                [self openNativeShareWithParams:paramstring];
                openNative = YES;
            }
                break;
            case MALL_HOME:
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self cyl_tabBarController].selectedIndex = 0;
                });
                openNative = YES;
            }
                break;
                
            case BORROW_MONEY:
            {
                //  去借贷超市
                [self.navigationController popToRootViewControllerAnimated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self cyl_tabBarController].selectedIndex = 1;
                });
                openNative = YES;
            }
                break;
            case APP_CONTACT_CUSTOMER:
            {
                
                if (![LoginManager loginState]) {
                    [LoginManager presentLoginVCWithController:self];
                } else {
                    //  客服
                    NTalkerChatViewController *chat = [[NTalker standardIntegration] startChatWithSettingId:kXNSettingId];
                    chat.pushOrPresent = YES;
                    chat.isHaveVoice = NO;
                    [self.navigationController pushViewController:chat animated:YES];
                }
                
                openNative = YES;
            }
                break;
            case LOAN_AUTH_LIST:
            {
                [XLCertificationHelper certificationPageJumpWithVC:self periodAuthType:ConsumeLoanType];
                openNative = YES;
                
            }
                break;
            case MALL_AUTH_LIST:
            {
                [XLCertificationHelper certificationPageJumpWithVC:self periodAuthType:MallLoanType];
                openNative = YES;
                
            }
                break;
            case RETURN_BACK:
            {
                //  返回到上一个页面
                [self.navigationController popViewControllerAnimated:YES];
                openNative = YES;
            }
                break;
            case GOODS_DETAIL_INFO:
            {
                //  跳转到商品详情
                NSDictionary* resultDict = [paramstring mj_JSONObject];
                NSString *goodsId = [resultDict[@"goodsId"] description];
                if (!kStringIsEmpty(goodsId)) {
                    LSGoodsDetailViewController *goodsDetailVC = [[LSGoodsDetailViewController alloc] init];
                    goodsDetailVC.goodsId = goodsId;
                    [self.navigationController pushViewController:goodsDetailVC animated:YES];
                }
                openNative = YES;
            }
                break;
            case CATEGORY:
            {
                //  跳转到商品详情
                NSDictionary* resultDict = [paramstring mj_JSONObject];
                NSString *categoryId = [resultDict[@"categoryId"] description];
                if (!kStringIsEmpty(categoryId)) {
                    ZTMXFGoodsCategoryListViewController *categoryVC = [[ZTMXFGoodsCategoryListViewController alloc] init];
                    categoryVC.categoryId = categoryId;
                    [self.navigationController pushViewController:categoryVC animated:YES];
                }
                openNative = YES;
            }
                break;
            default:
            {
            }
                break;
        }
    }
    return openNative;
}

//  打开原生分享页面
- (void)openNativeShareWithParams:(NSString *)paramsString{
    NSData *resultDecodeData = [NSString safeUrlBase64Decode:paramsString];
    NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:resultDecodeData options:0 error:nil];
    //  是否需要登录
    NSString * appLogin = [resultDict[@"appLogin"]description];
    if ([appLogin integerValue]==1&&![LoginManager loginState]) {
        //   当前未登录 。并且分享需要登录
        [LoginManager presentLoginVCWithController:self];
    }else{
        [XLUmengShareHelper startShareWithDic:resultDict];
        
    }
}

#pragma mark - 分享成功传给后台记录的回调
- (void)shareSuccess
{
    // 重新载入h5页面
    [self addAppInfo];
}

- (void)addAppInfo
{
    NSLog(@"1 LSWebView Url: %@", self.webUrlStr);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrlStr]]];
}

// 添加参数拼接新的加载url
- (NSString *)H5RequestUrlParamas:(NSURL *)requestUrl{
    NSDictionary *headerDict = [XLAppH5ExchangeApi baseDictionary] ;
    NSString *urlString =[[NSString stringWithFormat:@"%@%@_appInfo=%@",requestUrl.absoluteString,([requestUrl.absoluteString rangeOfString:@"?"].location ==NSNotFound)?@"?":@"&",[headerDict JSONString]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *filterStrUrl = [urlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString * newUrlStr = [filterStrUrl encodingStringUsingURLEscape];
    return newUrlStr;
}

//配合 h5添加视图
- (BOOL)addNavigationBarUIWithQuery:(NSString *)query{
    BOOL addUINameResult = NO;
    NSArray *paramsArray = [query.stringByRemovingPercentEncoding componentsSeparatedByString:@"&"];
    NSString *addUiName = @"";
    for (NSString *params in paramsArray) {
        if([params hasPrefix:@"addUiName="])
        {
            addUiName = [params substringFromIndex:10];
        }
    }
    
    CYwebAddAppUINameType uiType = [WebViewManager addAppUINameTypeWithName:addUiName];
    switch (uiType) {
        case CYwebAddAppUINameTypeShare:
        {
            self.addUINameType = CYwebAddAppUINameTypeShare;
            [self setNavgationBarRightImageStr:@"share_nav"];
            addUINameResult = YES;
        }
            break;
        case CYwebAddAppUINameTypeMyCoupon:
        {
            self.addUINameType = CYwebAddAppUINameTypeMyCoupon;
            [self setNavgationBarRightTitle:@"我的优惠券"];
            addUINameResult = YES;
        }
            break;
        case CYwebAddAppUINameTypeLastWinRank:
        {
            self.addUINameType = CYwebAddAppUINameTypeLastWinRank;
            [self setNavgationBarRightTitle:@"排行榜"];
            addUINameResult = YES;
        }
            break;
        case CYwebAddAppUINameTypeCustomerServices:
        {
            self.addUINameType = CYwebAddAppUINameTypeCustomerServices;
            [self setNavgationBarRightImageStr:@"XL_customer_services"];
            addUINameResult = YES;
        }
            break;
        default:
        {
        }
            break;
    }
    return addUINameResult;
}


#pragma mark - WKUIDelegate 处理web界面的三种提示框(警告框、确认框、输入框)
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler{
    
}

#pragma setter/getter
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *confi = [[WKWebViewConfiguration alloc]init];
        WKUserContentController * userContent = [WKUserContentController new];
        [userContent addScriptMessageHandler:self name:@"getConfigFromApp()"];
        confi.userContentController = userContent;
        //氪信H5埋点
        [confi.userContentController addUserScript:[CreditXAgent createUserScript]];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height- k_Navigation_Bar_Height) configuration:confi];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
    }
    return _webView;
}


- (ZTMXFUserInfoViewModel *)userInfoViewModel{
    if (_userInfoViewModel == nil) {
        _userInfoViewModel = [[ZTMXFUserInfoViewModel alloc] init];
        _userInfoViewModel.delegate = self;
    }
    return _userInfoViewModel;
}

#pragma mark - 是否从借贷超市进入
-(void)setIsBrwMarketIn:(BOOL)isBrwMarketIn{
    _isBrwMarketIn = isBrwMarketIn;
    
}

#pragma mark - 白领贷宣传页面点击按钮
- (void)clickGoAuthStatistics{
    NSString *userPhone =[[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNumber];
    //  人脸识别页面uv
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userPhone forKey:@"userName"];
}

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

// js 信息的交流
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
