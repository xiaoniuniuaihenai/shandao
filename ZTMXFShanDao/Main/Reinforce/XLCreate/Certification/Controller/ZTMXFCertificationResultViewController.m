//
//  ZTMXFCertificationResultViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationResultViewController.h"
#import "UILabel+Attribute.h"
#import "CYLTabBarController.h"
#import "ZTMXFGetStrongRiskSuccBannerApi.h"
#import "ZTMXFStrongRiskBannerModel.h"
#import "SDCycleScrollView.h"
#import "LoanModel.h"
#import "ZTMXFServerStatisticalHelper.h"

@interface ZTMXFCertificationResultViewController ()

@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, strong)UIImageView * stateView;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UILabel * amountLabel;

@property (nonatomic, strong)UIButton * submitBtn;

@property (nonatomic, strong) SDCycleScrollView *topCycleScrollView;

@property (nonatomic, strong) NSMutableArray *bannerList;
//解决埋点问题
@property (nonatomic, assign) BOOL didPageStatistical;

@end

@implementation ZTMXFCertificationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isSuccessful ? @"审核成功" : @"审核失败";
    self.fd_interactivePopDisabled = YES;
    self.edgesForExtendedLayout = UIAccessibilityTraitNone;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, X(40), KW, 20 * PX)];
    _titleLabel.font = FONT_Regular(14 * PX);
    _titleLabel.textColor = COLOR_SRT(@"#4A4A4A");
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_isSuccessful) {
        [_submitBtn setTitle:@"去借钱" forState:UIControlStateNormal];
//        _imgView.image = [UIImage imageNamed:@"RZ_ChengGongGG"];
        _titleLabel.text = _authDescribe;
        [_submitBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom, KW , 62 * PX)];
        _amountLabel.text = [NSString stringWithFormat:@"%.2f元", [_creditAmount floatValue]];
        _amountLabel.font = FONT_Medium(42 * PX);
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        [UILabel attributeWithLabel:_amountLabel text:_amountLabel.text textFont:42 * PX attributes:@[@"元"] attributeFonts:@[FONT_Regular(14 * PX)]];
        _amountLabel.textColor = K_MainColor;
        [self.view addSubview:_amountLabel];
        
        
        _stateView = [[UIImageView alloc] initWithFrame:CGRectMake(X(100), _amountLabel.bottom, X(177), X(109))];
        _stateView.image = [UIImage imageNamed:@"JZ_RZ_Result_Success"];
        _stateView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_stateView];
        [self requestCycleScrollViewList];

    }else{
        _titleLabel.numberOfLines = 0;
        _titleLabel.frame = CGRectMake(_titleLabel.left, _stateView.top, _titleLabel.width, _stateView.height);
        _titleLabel.text = _authDescribe;
        //134新增埋点友盟已添加
        [ZTMXFUMengHelper mqEvent:k_reject_pave_pv];
        [_submitBtn setTitle:@"点此查看优客专享" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _stateView.image = [UIImage imageNamed:@"JG_ShiBai"];
        _imgView.image = [UIImage imageNamed:@"RZ_ShiBaiGG"];
    }
    
    _submitBtn.frame = CGRectMake(X(20), _stateView.bottom + 42 * PX, KW - X(40), 44 * PX);
    _submitBtn.layer.cornerRadius = _submitBtn.height/2;
    _submitBtn.backgroundColor = K_MainColor;
    [self.view addSubview:_submitBtn];
    
    UIView * grayView = [[UIView alloc] initWithFrame:CGRectMake(0, _submitBtn.bottom + X(41), KW, 8 * PX)];
    grayView.backgroundColor = COLOR_SRT(@"#F2F4F5");
    [self.view addSubview:grayView];
    
    self.topCycleScrollView.frame = CGRectMake(0, grayView.bottom, KW, 120 * PX);
    [self.view addSubview:self.topCycleScrollView];
    // Do any additional setup after loading the view.
}

- (void)requestCycleScrollViewList{
    ZTMXFGetStrongRiskSuccBannerApi *api = [[ZTMXFGetStrongRiskSuccBannerApi alloc]init];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        self.bannerList = [BannerList mj_objectArrayWithKeyValuesArray:responseDict[@"data"][@"bannerList"]];
        self.topCycleScrollView.imageURLStringsGroup = [self.bannerList valueForKeyPath:@"imageUrl"];
        NSLog(@"bannaer 内容: %@",responseDict);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"strong risk bannaer request error: %@",request);
    }];
}


- (void)backAction
{
    [self clickReturnBackEvent];
}

- (void)viewDidDisappear:(BOOL)animated{
    if (!_didPageStatistical) {
        [super viewDidDisappear:animated];
    }
}

-(void)clickReturnBackEvent
{
    if (!_isSuccessful) {
        [ZTMXFUMengHelper mqEvent:k_reject_Return];
    }
    [ZTMXFServerStatisticalHelper loanStatisticalApiWithIoutTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
    _didPageStatistical = YES;
    [self.navigationController popToRootViewControllerAnimated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cyl_tabBarController].selectedIndex = 1;
    });
}
- (void)submitBtnAction
{
    [ZTMXFUMengHelper mqEvent:k_reject_clickDaichao];
    [ZTMXFUMengHelper mqEvent:k_reject_superMarket_pv];
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.isUpRiskWait = YES;
    webVC.webUrlStr = DefineUrlString(strongRiskFail);
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)bannerPushToNextPage:(NSInteger)index
{
    if (index < _bannerList.count) {
        BannerList * bannerModel = _bannerList[index];
        if (!bannerModel.titleName) {
            bannerModel.titleName = @"";
        }
//        [XLUMengHelper mqEvent:k_banner_click parameter:@{@"index":[@(index) stringValue], @"titleName":bannerModel.titleName}];
        if (bannerModel.isNeedLogin == 1 && ![LoginManager loginState]) {
            //        需要登录的未登录 弹出登录
            [LoginManager presentLoginVCWithController:self];
        }else{
            if ([bannerModel.type isEqualToString:@"H5_URL"]) {
                //    进入H5
                LSWebViewController * webVc = [[LSWebViewController alloc]init];
                // 去除字符串左右空格
                bannerModel.content = [bannerModel.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                webVc.webUrlStr = bannerModel.content;
                [self.navigationController pushViewController:webVc animated:YES];
            }
        }
    }
}

/** 轮播网络图片 */
-(SDCycleScrollView *)topCycleScrollView{
    if (!_topCycleScrollView) {
        @WeakObj(self);
        _topCycleScrollView = [[SDCycleScrollView alloc] init];
        [_topCycleScrollView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _topCycleScrollView.autoScrollTimeInterval = 3;
        //设置轮播视图的分页控件的显示
        _topCycleScrollView.placeholderImage = [UIImage imageNamed:@"banner_placeholder_180"];
        _topCycleScrollView.showPageControl = YES;
        _topCycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        //        _topCycleScrollView.pageControlBottomOffset = 25 * PX;
        _topCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //        _topCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _topCycleScrollView.pageControlDotSize = CGSizeMake(8, 3);
        _topCycleScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _topCycleScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
        _topCycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            [selfWeak bannerPushToNextPage:currentIndex];
        };
    }
    return _topCycleScrollView;
}

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
