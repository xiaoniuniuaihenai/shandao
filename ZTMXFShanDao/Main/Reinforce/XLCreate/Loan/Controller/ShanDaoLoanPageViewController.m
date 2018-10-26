//
//  ShanDaoLoanPageViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSBrwHomeInfoApi.h"
#import "ZTMXFAdvertisingApi.h"
#import "GetUserInfoApi.h"

#import "LoanModel.h"
#import "LSBorrowMoneyViewModel.h"
#import "LSLoanSupermarketModel.h"
#import "LSLoanSupermarketLabelModel.h"
#import "ZTMXFLoanMartAdModel.h"

#import "ZTMXFLoanHeaderView.h"
#import "ZTMXFLoanFirstCell.h"
#import "ZTMXFLoanSecondCell.h"
#import "ZTMXFThirdCell.h"
#import "ZTMXFLoanSupermarketCell.h"
#import "LSMarketGoodsCell.h"
#import "ZTMXFLoanHeaderSectionView.h"
#import "ZTMXFRateAlertView.h"
#import "LSFaceTimesLimitAlertView.h"
#import "LSBrwMoneyGoodsHeadView.h"
#import "ZTMXFClassificationView.h"
#import "ZTMXFSetPasswordAlertView.h"
#import "ZTMXFLoanSortingView.h"
#import "ZTMXFUpgradeAlertView.h"
#import "ZTMXFLoanAdCell.h"
#import "ZTMXFFaceFailureAlertView.h"
#import "LSReminderButton.h"
#import "UITabBar+badge.h"

#import "ShanDaoLoanPageViewController.h"
#import "LSWebViewController.h"
#import "ZTMXFCertificationCenterViewController.h"
#import "LSSubmitAuthViewController.h"
#import "JBScanIdentityCardViewController.h"
#import "LSCreditCheckViewController.h"
#import "LSMyMessageListViewController.h"

#import "ZTMXFServerStatisticalHelper.h"
#import "ZTMXFGoodsCategoryApi.h"
#import "CategoryListApi.h"
#import "ZTMXFClassification.h"
#import "ZTMXFCategoryListViewModel.h"
#import "CategoryListModel.h"
static int shut = 1;

@interface ShanDaoLoanPageViewController ()<LSBorrowMoneyViewModelDelegate, CategoryListViewModelDelegate>{
    NSDictionary       *_latitudeAndLongitude;
};

@property (nonatomic, strong) LoanModel * loanModel;

@property (nonatomic, strong) ZTMXFLoanHeaderView * loanHeaderView;

@property (nonatomic, strong)LSBorrowMoneyViewModel * borrowMoneyViewModel;

@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, copy)NSArray * headerArray;

/** 借贷超市header */
@property (nonatomic, strong) LSBrwMoneyGoodsHeadView *loanRecommendView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) ZTMXFClassificationView * classificationView;

@property (nonatomic, strong) ZTMXFLoanMartAdModel * loanMartAdModel;

@property (nonatomic, strong) LSReminderButton  *notificationCenterButton;

@property (nonatomic, strong)ZTMXFCategoryListViewModel *  categoryListViewModel;

@end

@implementation ShanDaoLoanPageViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    //  退出登陆
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadLoanInfoData) name:kLogoutSuccess object:nil];
    //  借钱数据状态变更 刷新页面数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadLoanInfoData) name:kNotRefreshBorrowMoneyPage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refloadLoanPage) name:kAppReviewState object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refloadLoanPage) name:NotNewNotificationMsg object:nil];
    [self httpGoodsCategory];
    // Do any additional setup after loading the view.
    
    
}



/** 获取商品分区数据成功 */
- (void)requestGoodsCategoryListSuccess:(CategoryListModel *)categoryListModel pageNumber:(NSInteger)pageNumber
{
    [_classificationView.collectionView.mj_header endRefreshing];
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (int i = 0; i < categoryListModel.categoryList.count; i ++) {
        CategoryGoodsModel *categoryGoodsModel = categoryListModel.categoryList[i];
        for (CategoryGoodsInfoModel *categoryGoodsInfoModel in categoryGoodsModel.goodsList) {
            if (categoryGoodsInfoModel) {
                [goodsArray addObject:categoryGoodsInfoModel];
            }
        }
    }
    _classificationView.classification.list = [goodsArray copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_classificationView.collectionView reloadData];
    });
}
- (ZTMXFCategoryListViewModel *)categoryListViewModel{
    if (_categoryListViewModel == nil) {
        _categoryListViewModel = [[ZTMXFCategoryListViewModel alloc] init];
        _categoryListViewModel.delegate = self;
    }
    return _categoryListViewModel;
}
/** 获取商品分区数据失败 */
- (void)requestGoodsCategoryListFailure
{
    [_classificationView.collectionView.mj_header endRefreshing];
    
}



- (void)httpGoodsListWith:(ZTMXFClassification *)classification
{
    if (classification.list.count ==0) {
        [self.categoryListViewModel requestGoodsCategoryListWithCategoryId:classification.rid pageNumber:1 showLoad:YES];
    }else{
        [_classificationView.collectionView reloadData];
    }
}

- (void)httpGoodsCategory
{
    @WeakObj(self);
    ZTMXFGoodsCategoryApi * goodsCategoryApi = [[ZTMXFGoodsCategoryApi alloc] initWithRank:1];
    [goodsCategoryApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * code = [responseDict[@"code"] description];
        if ([code isEqualToString:@"1000"]) {
            [selfWeak.classificationView.dataArray removeAllObjects];
            NSArray *  mainCategoryList = responseDict[@"data"][@"mainCategoryList"];
            for (int i = 0; i <  mainCategoryList.count; i++) {
                NSDictionary * dic = mainCategoryList[i];
                ZTMXFClassification * classification = [ZTMXFClassification mj_objectWithKeyValues:dic];
                if (i == 0) {
                    selfWeak.classificationView.classification = classification;
                    classification.isSelect = YES;
                    [selfWeak httpGoodsListWith:classification];
                }
                if (![classification.name isEqualToString:@"智能通讯"]) {
                    [selfWeak.classificationView.dataArray addObject:classification];
                }
            }
            [selfWeak.classificationView.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}





- (BOOL)hideNavigationBottomLine{
    return ![LoginManager appReviewState];
}
- (void)configUI{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.tableView.frame = CGRectMake(0, 0, KW, KH - k_Navigation_Bar_Height - TabBar_Height);
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.loanHeaderView;
    [self certificationPage];
    self.view.backgroundColor = K_BackgroundColor;
    self.tableView.backgroundColor =K_BackgroundColor;
}



- (void)httpLoanMartAd
{
    @WeakObj(self);
    ZTMXFAdvertisingApi * advertisingApi = [[ZTMXFAdvertisingApi alloc] initWithAdsenseType:@"BORROW_SHOP_ADSENSE"];
    [advertisingApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSInteger code =  [responseDict[@"code"] integerValue];
        if (code == 1000) {
            selfWeak.loanMartAdModel = [ZTMXFLoanMartAdModel mj_objectWithKeyValues:responseDict[@"data"]];
            [selfWeak.tableView reloadData];
            
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}

- (void)refloadLoanPage
{
    
    if ([LoginManager appReviewState]) {
        
        if (_classificationView) {
            _classificationView.hidden = NO;
        }
        self.navigationItem.title = @"推荐";
        if (!_classificationView.dataArray.count) {
            [self httpGoodsCategory];
        }
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.notificationCenterButton];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"JZ_Loan_Navi_COntentView"]];
        imageView.bounds = CGRectMake(0, 0, X(85), X(20));
        self.navigationItem.titleView = imageView;
        [self showMeaageCount];
        [self loadLoanInfoData];
        if (_classificationView) {
            _classificationView.hidden = YES;
        }
    }
}



- (void)certificationPage
{
    @WeakObj(self);
    _classificationView = [[ZTMXFClassificationView alloc] initWithFrame:CGRectMake(0, 0, KW, KH - TabBar_Height + 2 - k_Navigation_Bar_Height)];
    _classificationView.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [selfWeak httpGoodsCategory];
        
    }];
    [self.view addSubview:_classificationView];
    _classificationView.clickTableViewCell = ^(ZTMXFClassification *classification) {
        [selfWeak httpGoodsListWith:classification];
    };
    if (@available(iOS 11.0, *)) {
        _classificationView.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)showMeaageCount{
    NSInteger unreadMessageCount = [LSNotificationModel notifi_updateAllNumNotificationInfoNotRead];
    if (unreadMessageCount > 0) {
        [self.notificationCenterButton showRedReminderCount:[NSString stringWithFormat:@"%ld", unreadMessageCount]];
    } else {
        [self.notificationCenterButton showRedReminderCount:@"0"];
    }
    NSInteger count = [LSNotificationModel notifi_updateAllNumNotificationInfoNotRead];
    if (count) {
        [self.tabBarController.tabBar showBadgeOnItemIndex:2];
    }else{
        [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    }
}
- (void)pushBtnAction
{
    //  判断有没有登录
    if (![LoginManager loginState]) {
        [LoginManager presentLoginVCWithController:self];
        return;
    }
    LSSubmitAuthViewController *sumitAuthVC = [[LSSubmitAuthViewController alloc] init];
    sumitAuthVC.authType = MallLoanType;
    [self.navigationController pushViewController:sumitAuthVC animated:YES];
}

#pragma mark - 控制器生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //  设置状态栏颜色
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    //  加载页面数据
    [self refloadLoanPage];
    [XLServerBuriedPointHelper longitudeAndLatitude:^(NSDictionary *latitudeAndLongitude) {
        _latitudeAndLongitude = latitudeAndLongitude;
    }];
    //氪信浏览统计
    [CreditXAgent onEnteringPage:CXPageNameLoanIndex];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //氪信浏览统计
    [CreditXAgent onLeavingPage:CXPageNameLoanIndex];
}

#pragma mark  加载首页数据
- (void)loadLoanInfoData
{
    LSBrwHomeInfoApi * brwHomeInfoApi = [[LSBrwHomeInfoApi alloc]init];
    @WeakObj(self);
    [brwHomeInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            selfWeak.loanModel = [LoanModel mj_objectWithKeyValues:responseDict[@"data"]];
            selfWeak.pageName = [selfWeak.loanModel.canBorrow isEqualToString:@"T"] ? @"bs_ym_hqzy" : [selfWeak.loanModel.canBorrow isEqualToString:@"C"] ? @"bs_ym_jqzy" : @"";
            [selfWeak.loanModel updateData];
            if ([selfWeak.loanModel.canBorrow isEqualToString:@"N"]) {
                // 消费贷不可借钱显示借贷超市
                [self.borrowMoneyViewModel requestBorrowMoneyRecommendAliasList];
            }
            [selfWeak updateUI];
        }
        [selfWeak endRef];
    } failure:^(__kindof YTKBaseRequest *request) {
        [selfWeak endRef];
    }];
}

- (void)endRef
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}

// 借贷超市滚动栏目
- (LSBrwMoneyGoodsHeadView *)loanRecommendView
{
    if (!_loanRecommendView) {
        _loanRecommendView = [[LSBrwMoneyGoodsHeadView alloc] initWithFrame:CGRectMake(0.0, 0, Main_Screen_Width, 60)];
        [_loanRecommendView setBackgroundColor:[UIColor whiteColor]];
        _loanRecommendView.currentMenuIndex = 0;
        _loanRecommendView.delegate = self;
        [_loanRecommendView.sortingBtn addTarget:self action:@selector(sortingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loanRecommendView;
}

- (void)sortingBtnAction
{
    @WeakObj(self);
    [ZTMXFLoanSortingView loanSortingViewWith:@[] index:_borrowMoneyViewModel.sortingType completeHandle:^(NSInteger selectIndex) {
        selfWeak.borrowMoneyViewModel.sortingType = selectIndex;
        [self.borrowMoneyViewModel requestBorrowMoneyRecommendAliasList];
        
        //        NSLog(@"selectIndex == %ld", selectIndex);
    }];
    
}



-(void)brwMoneyGoodsHeadView:(LSBrwMoneyGoodsHeadView *)brwMoneyGoodsHeadView  currentMenuIndex:(NSInteger)currentMenuIndex
{
    _index = currentMenuIndex;
    [self.tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_loanModel) {
        if ([self.loanModel.canBorrow isEqualToString:@"N"] && self.dataArray.count) {
            return 60;
        }
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    headerView.clipsToBounds = YES;
    [headerView addSubview:self.loanRecommendView];
    self.loanRecommendView.backgroundColor = [UIColor whiteColor];
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_loanModel) {
        if ([self.loanModel.canBorrow isEqualToString:@"N"]) {
            if (_loanMartAdModel) {
                if (shut == 1) {
                    if (indexPath.row  == 0 ) {
                        return 90 * PX;
                    }
                }else{
                    if (indexPath.row  == 0 ) {
                        return 0.01 * PX;
                    }
                }
            }
            return 135 * PX;
        }else{
            return  360 * PX;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.loanModel.canBorrow isEqualToString:@"N"]) {
        //  进入借贷超市H5
        if (indexPath.row == 0) {
            [ZTMXFUMengHelper mqEvent:k_Adv_click_app_daichao];
            if(_loanMartAdModel.imageH5Url.length > 7){
                LSWebViewController * webVc = [[LSWebViewController alloc]init];
                webVc.webUrlStr = _loanMartAdModel.imageH5Url;
                [self.navigationController pushViewController:webVc animated:YES];
            }
            
        }else{
            
            LSWebViewController * webVc = [[LSWebViewController alloc]init];
            LSLoanSupermarketModel * loanSupermarketModel = self.dataArray[_index][indexPath.row - 1];
            webVc.webUrlStr = loanSupermarketModel.linkUrl;
            if (!loanSupermarketModel.lsmName) {
                loanSupermarketModel.lsmName = @"";
            }
            [ZTMXFUMengHelper mqEvent:k_appDaichao_list_click parameter:@{@"lsmName":loanSupermarketModel.lsmName,@"index":@(indexPath.row - 1)}];
            // 借贷超市进入，不添加appInfo参数
            // webVc.appInfoIgnore = YES;
            [self.navigationController pushViewController:webVc animated:YES];
            
        }
        //  进入的借款超市埋点
    }
}

#pragma mark - LSBorrowMoneyViewModelDelegate
///** 请求借钱首页数据成功 */
//- (void)requestBorrowMoneyViewSuccess:(LSBorrowHomeInfoModel *)homeInfoModel{
//    [self endRef];
//    [self dealWithBorrowMoneyRequestData:homeInfoModel];
//}

/** 请求借钱首页数据失败 */
- (void)requestBorrowMoneyViewFailure{
    [self endRef];
}

/** 请求借贷超市类型列表成功回调 */
- (void)requestBorrowMoneyRecommendAliasSuccess:(NSArray *)aliasArray findUrl:(NSString *)findUrl{
    //  显示借贷超市
    _headerArray = aliasArray;
    [self.loanRecommendView updateBrwMoneyGoodsHeadViewWith:self.headerArray];
    [self httpLoanMartAd];
    
}



/** 请求返回所有的借贷超市数据 */
- (void)requestBorrowMoneyMarketListsSuccess:(NSDictionary *)marketListDict{
    
    [self.dataArray removeAllObjects];
    //    // 数组重新排序
    for (int i = 0 ; i < [marketListDict allKeys].count; i++) {
        if (_headerArray.count > i) {
            LSLoanSupermarketLabelModel *labelModel = self.headerArray[i];
            NSArray *arrData = [marketListDict objectForKey:labelModel.alias];
            [self.dataArray addObject:arrData];
        }
    }
    //界面刷新
    [self.tableView reloadData];
}



- (void)refData
{
    [self loadLoanInfoData];
}

- (ZTMXFLoanHeaderView *)loanHeaderView
{
    if (!_loanHeaderView) {
        self.loanHeaderView = [[ZTMXFLoanHeaderView alloc] initWithFrame:CGRectMake(0, 0, KW, 168 * PX)];
    }
    return _loanHeaderView;
}
- (void)updateUI
{
    _index = 0;
    self.loanHeaderView.loanModel = _loanModel;
    if (_loanModel.titles.count == 0) {
        self.loanHeaderView.frame = CGRectMake(0, 0, KW, 123 *PX);
    }else{
        self.loanHeaderView.frame = CGRectMake(0, 0, KW, 168 *PX);
    }
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_loanModel) {
        if ([_loanModel.canBorrow isEqualToString:@"N"]) {
            if (self.dataArray.count > _index && self.dataArray.count) {
                NSArray * arr = self.dataArray[_index];
                NSInteger count = arr.count;
                return count + 1;
            }
            return 0;
        }
        return 1;
    }else{
        return 0;
    }
}


- (void)submitBtnAction
{
    //氪信点击事件
    [CreditXAgent onClick:CXClickLoanIndexLoanClicked];
    if ([LoginManager loginState]) {
        [self.borrowMoneyViewModel requestConfirmBorrowMoneyInfoWithBorrowDays:self.loanModel.timeParameter amount:self.loanModel.amountParameter borrowType:kConsumeLoanType currentController:self];
    } else {
        NSMutableDictionary *pointInfo = [[NSMutableDictionary alloc]init];
        [pointInfo setObject:[XLServerBuriedPointHelper wifiMac]?:@"" forKey:@"wifiMac"];
        [pointInfo setObject:[XLServerBuriedPointHelper wifiName]?:@"" forKey:@"wifiName"];
        [_latitudeAndLongitude enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [pointInfo setObject:obj forKey:key];
        }];
        [pointInfo setObject:@(NO) forKey:@"isLogin"];
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"submit.jq_qjq" OtherDict:pointInfo];
        [LoginManager presentLoginVCWithController:self];
        [ZTMXFUMengHelper mqEvent:k_do_loan parameter:@{@"isLogin":@"NO"}];
    }
    
}

// 绑定的ViewModel
- (LSBorrowMoneyViewModel *)borrowMoneyViewModel{
    if (_borrowMoneyViewModel == nil) {
        _borrowMoneyViewModel = [[LSBorrowMoneyViewModel alloc] init];
        _borrowMoneyViewModel.delegate = self;
        _borrowMoneyViewModel.sortingType = 0;
    }
    return _borrowMoneyViewModel;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_loanModel) {
        if ([_loanModel.canBorrow isEqualToString:@"T"]) {//待还款
            if (_loanModel.statusInfo.renewalStatus == 2 || _loanModel.statusInfo.existRepayingMoney) {
                static NSString * cellstr = @"ThirdCell";
                ZTMXFThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
                if (!cell) {
                    cell = [[ZTMXFThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (_loanModel) {
                    cell.loanModel = _loanModel;
                }
                return cell;
            }
            static NSString * cellstr = @"ZTMXFLoanSecondCell";
            ZTMXFLoanSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
            if (!cell) {
                cell = [[ZTMXFLoanSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (_loanModel) {
                cell.statusInfo = _loanModel.statusInfo;
            }
            return cell;
        }else if ([_loanModel.canBorrow isEqualToString:@"I"]) {//打款中
            static NSString * cellstr = @"ZTMXFThirdCell";
            ZTMXFThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
            if (!cell) {
                cell = [[ZTMXFThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.loanModel = _loanModel;
            return cell;
        }else if ([_loanModel.canBorrow isEqualToString:@"N"]) {
            if (indexPath.row == 0) {
                ZTMXFLoanAdCell * loanAdCell = [ZTMXFLoanAdCell LoanAdCellWithTableView:tableView];
                [loanAdCell.shutBtn addTarget:self action:@selector(loanAdCellShutBtnAction) forControlEvents:UIControlEventTouchUpInside];
                loanAdCell.imageUrl = _loanMartAdModel.imageUrl;
                return loanAdCell;
            }
            //  借贷超市
            ZTMXFLoanSupermarketCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IdfGoodsCell"];
            if (cell == nil) {
                cell = [[ZTMXFLoanSupermarketCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"IdfGoodsCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (self.dataArray.count > _index && self.dataArray.count) {
                NSArray * arr = self.dataArray[_index];
                cell.loanSupermarketModel = arr[indexPath.row - 1];
            }
            return cell;
        }
    }
    static NSString * cellstr = @"ZTMXFLoanFirstCell";
    ZTMXFLoanFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (!cell) {
        cell = [[ZTMXFLoanFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (_loanModel) {
        cell.loanModel = _loanModel;
    }
    return cell;
}

- (void)loanAdCellShutBtnAction
{
    shut = 0;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LSReminderButton *)notificationCenterButton{
    if (!_notificationCenterButton) {
        _notificationCenterButton = [LSReminderButton buttonWithType:UIButtonTypeCustom];
        _notificationCenterButton.frame = CGRectMake(KW - X(60), k_Navigation_Bar_Height - X(44), X(44), X(44));
        [_notificationCenterButton setImage:[UIImage imageNamed:@"JZ_User_Center_Message"] forState:UIControlStateNormal];
        [_notificationCenterButton setImage:[UIImage imageNamed:@"JZ_User_Center_Message"] forState:UIControlStateHighlighted];
        [_notificationCenterButton addTarget:self action:@selector(notificationCenterButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_notificationCenterButton setTitleColor:COLOR_SRT(@"7D7D7D") forState:UIControlStateNormal];
        [_notificationCenterButton setTitleColor:COLOR_SRT(@"7D7D7D") forState:UIControlStateHighlighted];
        _notificationCenterButton.titleLabel.font = FONT_Regular(X(12));
    }
    return _notificationCenterButton;
}

- (void)notificationCenterButtonClick{
    if ([self loginState]) {
        LSMyMessageListViewController *messageListVC = [[LSMyMessageListViewController alloc] init];
        [self.navigationController pushViewController:messageListVC animated:YES];
    }
}

- (BOOL)loginState{
    if (![LoginManager loginState]) {
        [LoginManager presentLoginVCWithController:self];
        return NO;
    } else {
        return YES;
    }
}

@end

