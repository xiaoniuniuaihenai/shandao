//
//  LSPhoneOperationAuthViewController.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/15.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "LSPhoneOperationAuthViewController.h"
#import "LSWebProgressLayer.h"
#import "NSString+Additions.h"
#import "NSDictionary+JSONString.h"
#import "LSAuthMobileApi.h"
#import "NSDictionary+JSONString.h"
#import "BaseRequestSerivce.h"
#import "AddressBookManager.h"
#import "RealNameManager.h"
#import "AuthenProgressView.h"
#import "CertificationProssView.h"
#import <IQKeyboardManager.h>
@interface LSPhoneOperationAuthViewController ()<UIWebViewDelegate>
/** webView */
@property (nonatomic, strong) UIWebView  *webView;
/** 进度条 */
@property (nonatomic, strong) LSWebProgressLayer *progressLayer;
/** webUrl */
@property (nonatomic, copy) NSString *webUrl;
/** 是否允许访问通讯录 */
@property (nonatomic, assign) BOOL accessAddressBook;

@property (nonatomic, strong) AuthenProgressView    *progressView;

@end

@implementation LSPhoneOperationAuthViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //氪信浏览统计
    [CreditXAgent onEnteringPage:CXPageNameOperator];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //氪信浏览统计
    [CreditXAgent onLeavingPage:CXPageNameOperator];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc] initWithString:@"运营商认证"];
    [self set_Title:titleStr];
//    self.title = @"运营商认证";
    // 1.创建一个webView
    [self setupSubUI];

    [self getPhoneOperationUrl];
    [self addressBookManagerAllowAccess:YES];
    //  通讯录认证
        //  手机运营商认证入口
//    [self phoneOperationAuthPageStatistics];
    //  设置不让侧滑
    self.fd_interactivePopDisabled = YES;
}

#pragma mark-  按钮方法
-(void)clickReturnBackEvent
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"\n\n运营商认证没有完成，出现什么问题了吗？我们非常愿意提供帮助\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"没有问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"需要帮助" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = DefineUrlString(serviceCenter_que_first);
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    [alert addAction:action1];
    [action1 setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
    
    [alert addAction:action2];
    [action2 setValue:K_MainColor forKey:@"titleTextColor"];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 获取运营商url
- (void)getPhoneOperationUrl{
    [SVProgressHUD showLoading];
    LSAuthMobileApi * mobileApi = [[LSAuthMobileApi alloc]init];
    [mobileApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            self.webUrl = responseDict[@"data"][@"url"];
            if (self.accessAddressBook) {
                [self loadWebUrl:self.webUrl];
            }
        }
        [SVProgressHUD dismiss];

    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark 加载url
- (void)loadWebUrl:(NSString *)webUrl{
    if (webUrl) {
        NSURL *url = [NSURL URLWithString:self.webUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}
#pragma mark - AddressBookManagerDelegate
- (void)addressBookManagerAllowAccess:(BOOL)access{
    self.accessAddressBook = access;
    if (self.accessAddressBook) {
        //  允许访问通讯录
        [self loadWebUrl:self.webUrl];
    }
}

#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressLayer finishedLoad];
//    NSString * str =  [webView stringByEvaluatingJavaScriptFromString:self.webUrl];
//    NSLog(@"finishedLoad   %@", str);
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _progressLayer = [LSWebProgressLayer layerWithFrame:CGRectMake(0, k_Navigation_Bar_Height - 0.5, Main_Screen_Width, 2)];
    [self.view.layer addSublayer:_progressLayer];
    [_progressLayer startLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_progressLayer finishedLoad];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.URL.absoluteString);
    if ([request.URL.absoluteString rangeOfString:@"app/authBack"].location !=NSNotFound) {
        // 点击完成认证按钮
        NSString *config = [NSString string];
        NSString *queryStr = [request.URL.query stringByRemovingPercentEncoding];
        NSRange configRange = [queryStr rangeOfString:@"lsdapiNeedRefreshCurrData="];
        NSString *configStr = [NSString string];
        if (queryStr.length >= (configRange.location + configRange.length)) {
            configStr = [queryStr substringFromIndex:(configRange.location + configRange.length)];
        }
        NSArray *rangesArray = [NSString getRangeStrFrom:configStr findText:@"}"];
        if (rangesArray.count > 0) {
            NSNumber* firstNmumber = rangesArray[0];
            NSInteger firstIndex = [firstNmumber integerValue];
            if (configStr.length >= firstIndex) {
                config = [configStr substringToIndex:(firstIndex + 1)];
            } else {
                config = @"";
            }
        } else {
            config = @"";
        }
        NSDictionary *configDict = [NSDictionary initWithJsonString:config];
        if ([configDict[@"refreshStatus"] isEqualToString:@"1"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(phoneOperationAuthViewSuccessAuth)]) {
                //    友盟统计  运营商认证完成
                [self phoneOperationAuthSuccessStatistics];
                [self.delegate phoneOperationAuthViewSuccessAuth];
            }
        }

        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    return YES;
}

#pragma mark - 添加子视图
-(void)setupSubUI
{
    [self.view addSubview:self.webView];
}

#pragma mark - setter getter
- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

- (AuthenProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[AuthenProgressView alloc] init];
        _progressView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 45.0);
    }
    return _progressView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 运营商认证入口
- (void)phoneOperationAuthPageStatistics{
    // 运营商认证
}

#pragma mark - 运营商认证成功
- (void)phoneOperationAuthSuccessStatistics{
    [ZTMXFUMengHelper mqEvent:k_operator_succ_xf];
}


/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
