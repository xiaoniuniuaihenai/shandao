//
//  LSCreditAuthWebViewController.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/23.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "LSCreditAuthWebViewController.h"
#import "ZhiMaCreditModel.h"
#import "LSWebProgressLayer.h"
#import "LSAuthZhimaApi.h"
#import "RealNameManager.h"
#import "ZTMXFUserInfoViewModel.h"
#import "AuthenProgressView.h"
#import "CertificationProssView.h"
#import "ZTMXFuthZmStatusApi.h"
@interface LSCreditAuthWebViewController ()<UIWebViewDelegate, UserInfoViewModelDelegate>

@property (nonatomic, strong) UIWebView *webView;
/** 进度条 */
@property (nonatomic, strong) LSWebProgressLayer *progressLayer;

@property (nonatomic, strong) ZTMXFUserInfoViewModel *userInfoViewModel;

@property (nonatomic, copy)NSString * matchStr;
@property (nonatomic, assign)BOOL  matchType;


@end

@implementation LSCreditAuthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"芝麻信用授权"];
    [self set_Title:titleStr];

    
    // 1.创建一个webView
    [self setupSubUI];
    
    if (_isJumpFromAuthVC) {
        // 获取芝麻信用url
        [self.userInfoViewModel requestZhiMaAuthUrl];
    }else{
        if (self.webUrl) {
            NSURL *url = [NSURL URLWithString:self.webUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_webView loadRequest:request];
        }
    }
}


/** 返回最开始的页面 */
- (void)clickReturnBackEvent
{
    [RealNameManager realNameBackSuperVc:self];
}

#pragma mark - UserInfoViewModelDelegate
- (void)requestZhiMaUrlSuccess:(NSDictionary *)zhiMaUrlDic{
    self.webUrl = [zhiMaUrlDic[@"authUrl"] description];
    self.matchStr = [zhiMaUrlDic[@"matchStr"] description];
   // 1：包含，0：非包含
    self.matchType = [zhiMaUrlDic[@"matchType"] boolValue];

    if (self.webUrl) {
        NSURL *url = [NSURL URLWithString:self.webUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressLayer finishedLoad];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_progressLayer finishedLoad];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    _progressLayer = [LSWebProgressLayer layerWithFrame:CGRectMake(0, k_Navigation_Bar_Height - 0.5, Main_Screen_Width, 2)];
    [self.view.layer addSublayer:_progressLayer];
    [_progressLayer startLoad];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    // 2.判断是否为回调地址//
    if (_matchType) {
        if ([url rangeOfString:_matchStr].location !=NSNotFound) {
            [self getZhiMaWithURL:url];
            return NO;
        }
    }else{
        if ([url rangeOfString:_matchStr].location ==NSNotFound) {
            [self getZhiMaWithURL:url];
            return NO;
        }
    }
    return YES;
}

- (void)getZhiMaWithURL:(NSString *)url
{
        ZTMXFuthZmStatusApi * api = [[ZTMXFuthZmStatusApi alloc] initWithZmUrl:url];
        [api requestWithSuccess:^(NSDictionary *responseDict) {
            NSInteger  code = [responseDict[@"code"] integerValue];
            NSString * url = [responseDict[@"data"][@"url"] description];
            if (code == 1000) {

                if (self.zhiMaPopBlock) {
                    self.zhiMaPopBlock();
                }
            }
            if (url && url.length > 0) {
                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url?:@""]]];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
}


//- (NSString *)URLDecodedString:(NSString *)str
//{
//    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//
//    return decodedString;
//}

#pragma mark - 获取芝麻信用分和额度
//- (void)getCreditScoreAndBorrowAmountWithParam:(NSString *)param sign:(NSString *)sign{

//    [SVProgressHUD showLoading];
//    LSAuthZhimaApi * zhimaApi = [[LSAuthZhimaApi alloc]initWithSign:sign andRespBody:param];
//    [zhimaApi requestWithSuccess:^(NSDictionary *responseDict) {
//        [SVProgressHUD dismiss];
//        NSString * codeStr = [responseDict[@"code"]description];
//        if ([codeStr isEqualToString:@"1000"]) {
//            // 1.认证流程进入，直接跳转到运营商认证；2.额度页面进入，返回到额度页面
//            if (self.isJumpFromAuthVC) {
//                [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressOperatorAuth isSaveBackVcName:NO loanType:self.loanType];
//            }else{
//                [self.navigationController popViewControllerAnimated:YES];
//                ZhiMaCreditModel *creditModel = [ZhiMaCreditModel mj_objectWithKeyValues:responseDict[@"data"]];
//                if (self.delegate && [self.delegate respondsToSelector:@selector(creditAuthWebViewCreditScore:)]) {
//                    [self.delegate creditAuthWebViewCreditScore:creditModel];
//                }
//            }
//        }
//    } failure:^(__kindof YTKBaseRequest *request) {
//        [SVProgressHUD dismiss];
//    }];
//}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//}

- (ZTMXFUserInfoViewModel *)userInfoViewModel{
    if (_userInfoViewModel == nil) {
        _userInfoViewModel = [[ZTMXFUserInfoViewModel alloc] init];
        _userInfoViewModel.delegate = self;
    }
    return _userInfoViewModel;
}

#pragma mark - 添加子视图
-(void)setupSubUI{
    
//    CertificationProssView * prossView = [[CertificationProssView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, KW, 80 * PY)];
//    prossView.prossType = CertificationProssZhiMa;
//    [self.view addSubview:prossView];
//    [self.view addSubview:self.progressView];
    [self.view addSubview:self.webView];
//    self.webView.top = prossView.bottom;
}

#pragma mark - setter getter
- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height) ];
        _webView.delegate = self;
    }
    return _webView;
}


//- (AuthenProgressView *)progressView{
//    if (_progressView == nil) {
//        _progressView = [[AuthenProgressView alloc] init];
//        _progressView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 45.0);
//    }
//    return _progressView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
