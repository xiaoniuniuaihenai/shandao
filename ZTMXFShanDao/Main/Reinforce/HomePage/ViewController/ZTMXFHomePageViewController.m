//
//  LSHomePageViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/6.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFHomePageViewController.h"
#import "ZTMXFGoodsCategoryListViewController.h"
#import "LSGoodsDetailViewController.h"

#import "UIView+Administer.h"
#import "NTalker.h"
#import "NSString+Additions.h"
#import "NSString+version.h"
#import "LSBorrowBannerModel.h"
#import "HomePageMallModel.h"
#import "ZTMXFBannerGoodsFrame.h"
#import "LSLocationManager.h"

#import "ZTMXFHomePagePopViewManager.h"
#import "ZTMXFHomePageViewModel.h"
#import "HomePageHeaderView.h"
#import "HomePageFooterView.h"
#import "MallGoodsStyleOneCell.h"

#import "LSOrderListViewController.h"
#import "ZTMXFMobileRechargeController.h"
#import "LSBorrowMoneyViewModel.h"
@interface ZTMXFHomePageViewController ()<UITableViewDelegate,UITableViewDataSource, HomePageFooterViewDelegate, HomePageHeaderViewDelegate, HomePageViewModelDelegate, MallGoodsStyleOneCellDelegate>

@property (nonatomic, strong) UITableView        *tableView;
/** 首页tableHeaderView */
@property (nonatomic, strong) HomePageHeaderView *homePageHeaderView;
/** 首页tableFooterView */
@property (nonatomic, strong) HomePageFooterView *homePageFooterView;

/** 借钱首页viewModel */
@property (nonatomic, strong) ZTMXFHomePageViewModel  *homePageViewModel;
/** 首页弹窗处理Manager */
@property (nonatomic, strong) ZTMXFHomePagePopViewManager *popViewManager;

/** 首页model数据 */
@property (nonatomic, strong) HomePageMallModel *homePageMallModel;
/** banner+Goods 模块数组 */
@property (nonatomic, strong) NSMutableArray *bannerGoodsFrames;

@end

@implementation ZTMXFHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LSBorrowMoneyViewModel changeTabBarTextAndImage];
    });
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationItem.title = @"闪到";
//    self.fd_prefersNavigationBarHidden = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //  添加首页弹窗处理
    self.popViewManager = [[ZTMXFHomePagePopViewManager alloc] init];
    //  添加子视图
    [self configSubviews];
    //  上传版本号
    [LoginManager updateVersion];
    //  版本
    [self.homePageViewModel requestUpdateVersionApi];
    //  登陆小能客服
    if ([LoginManager loginState]) {
        [[NTalker standardIntegration] loginWithUserid:[LoginManager userPhone] andUsername:[LoginManager userPhone] andUserLevel:0];
    }
    //  加载页面数据
    [self loadHomePageData];
}

- (BOOL)hideNavigationBottomLine{
    return YES;
}

#pragma mark - 控制器生命周期


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //  设置状态栏颜色
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    //   首页弹窗使用
    [self.popViewManager handleNotInHomePagePopupView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}



#pragma mark - UITableViewData
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bannerGoodsFrames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTMXFBannerGoodsFrame *bannerGoodsFrame = self.bannerGoodsFrames[indexPath.row];
    return bannerGoodsFrame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    return headerView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MallGoodsStyleOneCell *styleOneCell = [MallGoodsStyleOneCell cellWithTableView:tableView];
    ZTMXFBannerGoodsFrame *bannerGoodsFrame = self.bannerGoodsFrames[indexPath.row];
    styleOneCell.bannerGoodsFrame = bannerGoodsFrame;
    styleOneCell.delegate = self;
    return styleOneCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //  状态颜色
//    CGFloat contentOffsetY = scrollView.contentOffset.y;
//    if (contentOffsetY < AdaptedHeight(180.0)) {
//        if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent) {
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        }
//    } else {
//        if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        }
//    }
}

#pragma mark - HomePageHeaderViewDelegate 轮播图点击事件


/** 点击分类 */
- (void)homePageHeaderViewClickCategory:(MallCategoryModel *)categoryModel{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:categoryModel.name forKey:@"category"];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"sc" PointSubCode:@"click.sc_list" OtherDict:dict];
    [self homepageClickCategory:categoryModel];
}
/** 点击轮播图 */
- (void)homePageHeaderViewClickBannerImage:(MallBannerModel *)bannerModel{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSUInteger i = [self.homePageMallModel.bannerList indexOfObject:bannerModel];
    [dict setObject:@(i) forKey:@"icon"];
    [dict setObject:bannerModel.desc forKey:@"content"];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"sc" PointSubCode:@"click.sc_ymdb" OtherDict:dict];
    [self homePageClickBanner:bannerModel];
}


#pragma mark MallGoodsStyleOneCellDelegate(cell 代理方法)
/** 点击banner跳转 */
- (void)mallGoodsStyleOneCellClickBanner:(MallBannerModel *)bannerModel cell:(id)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSString *name = [self.homePageMallModel.bannerGoodsList[indexPath.row] name];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:name forKey:@"subordinateNode"];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"sc" PointSubCode:@"click.sc_ymzb" OtherDict:dict];
    [self homePageClickBanner:bannerModel];
}
/** 点击商品 */
- (void)mallGoodsStyleOneCellClickGoods:(MallGoodsModel *)goodsModel{
    [self homePageClickGoods:goodsModel];
}

#pragma mark HomePageViewModelDelegate
/** 请求首页接口数据成功 */
- (void)requestHomePageSuccess:(HomePageMallModel *)homePageMallModel{
    if (homePageMallModel) {
        self.homePageMallModel = homePageMallModel;
        //  设置banner数据
        self.homePageHeaderView.bannerImageArray = self.homePageMallModel.bannerList;
        //  设置分类数据
        self.homePageHeaderView.categoryBgColor = self.homePageMallModel.categoryBgColor;
        self.homePageHeaderView.categoryFontColor = self.homePageMallModel.categoryFontColor;
        self.homePageHeaderView.categoryArray = self.homePageMallModel.categoryList;
        //  设置活动推广banner数据
        self.homePageHeaderView.promotionImageArray = self.homePageMallModel.bannerListTwo;
        if (self.bannerGoodsFrames.count > 0) {
            [self.bannerGoodsFrames removeAllObjects];
        }
        //  添加banner+goods 数据
        [self.bannerGoodsFrames addObjectsFromArray:[self bannerGoodsFramesWithModelArray:self.homePageMallModel.bannerGoodsList]];
        //  刷新页面
        [self.tableView reloadData];
    }
    [self endupRefresh];
}

- (NSArray *)bannerGoodsFramesWithModelArray:(NSArray *)bannerGoodsArray
{
    NSMutableArray *bannerGoodsFrames = [NSMutableArray array];
    for (MallBannerGoodsModel *bannerGoodsModel in bannerGoodsArray) {
        ZTMXFBannerGoodsFrame *bannerGoodsFrame = [[ZTMXFBannerGoodsFrame alloc] init];
        bannerGoodsFrame.bannerGoodsModel = bannerGoodsModel;
        [bannerGoodsFrames addObject:bannerGoodsFrame];
        
    }
    return bannerGoodsFrames;;
}


/** 请求首页接口失败 */
- (void)requestHomePageFailure{
    [self endupRefresh];
}

#pragma mark - 私有方法
/** 点击banner跳转 */
- (void)homePageClickBanner:(MallBannerModel *)bannerModel{
    /** 跳转类型：为1时：h5跳转链接；为2:类目id；为3是：商品id；为4是：app内页 */
    NSInteger bannerType = bannerModel.type;
    if (bannerType == 1) {
        //  跳转到H5
        LSWebViewController * webVc = [[LSWebViewController alloc] init];
        webVc.webUrlStr = bannerModel.desc;
        [self.navigationController pushViewController:webVc animated:YES];
    } else if (bannerType == 2) {
        //  跳转到分区
        ZTMXFGoodsCategoryListViewController *goodsCategoryVC = [[ZTMXFGoodsCategoryListViewController alloc] init];
        goodsCategoryVC.categoryId = bannerModel.desc;
        [self.navigationController pushViewController:goodsCategoryVC animated:YES];
    } else if (bannerType == 3) {
        //  跳转到商品详情
        LSGoodsDetailViewController *goodsDetailVC = [[LSGoodsDetailViewController alloc] init];
        goodsDetailVC.goodsId = bannerModel.desc;
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    } else if (bannerType == 4) {
        //  跳转到原生
        if ([bannerModel.desc isEqualToString:@"MOBILE"]) {
            //  跳转到手机充值
            ZTMXFMobileRechargeController *mobileVC = [[ZTMXFMobileRechargeController alloc] init];
            [self.navigationController pushViewController:mobileVC animated:YES];
        }
    }
}


/** 点击分类跳转 */
- (void)homepageClickCategory:(MallCategoryModel *)categoryModel{
    //  跳转到分区
    ZTMXFGoodsCategoryListViewController *goodsCategoryVC = [[ZTMXFGoodsCategoryListViewController alloc] init];
    goodsCategoryVC.categoryId = categoryModel.categoryId;
    [self.navigationController pushViewController:goodsCategoryVC animated:YES];
}

/** 点击商品跳转 */
- (void)homePageClickGoods:(MallGoodsModel *)goodsModel{
    LSGoodsDetailViewController *goodsDetailVC = [[LSGoodsDetailViewController alloc] init];
    goodsDetailVC.goodsId = [NSString stringWithFormat:@"%ld",goodsModel.goodsId];
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}

#pragma mark  加载首页数据
- (void)loadHomePageData{
    [self.homePageViewModel requestHomePageData];
}

#pragma mark  结束刷新
- (void)endupRefresh{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
#pragma mark - 添加子视图
- (void)configSubviews{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.homePageHeaderView;
}

#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0.0, 0, KW, KH - TabBar_Height - k_Navigation_Bar_Height);
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        MJRefreshNormalHeader* headerRefresh = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomePageData)];
        headerRefresh.lastUpdatedTimeLabel.hidden = YES;
        headerRefresh.stateLabel.hidden = YES;
        _tableView.mj_header = headerRefresh;
    }
    return _tableView;
}

- (HomePageHeaderView *)homePageHeaderView{
    if (_homePageHeaderView == nil) {
        _homePageHeaderView = [[HomePageHeaderView alloc] init];
//        _homePageHeaderView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(268.0));
        _homePageHeaderView.backgroundColor = [UIColor whiteColor];
        _homePageHeaderView.delegate = self;
    }
    return _homePageHeaderView;
}

- (HomePageFooterView *)homePageFooterView{
    if (_homePageFooterView == nil) {
        _homePageFooterView = [[HomePageFooterView alloc] init];
        _homePageFooterView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _homePageFooterView.delegate = self;
    }
    return _homePageFooterView;
}

- (ZTMXFHomePageViewModel *)homePageViewModel{
    if (_homePageViewModel == nil) {
        _homePageViewModel = [[ZTMXFHomePageViewModel alloc] init];
        _homePageViewModel.delegate = self;
    }
    return _homePageViewModel;
}

- (NSMutableArray *)bannerGoodsFrames{
    if (_bannerGoodsFrames == nil) {
        _bannerGoodsFrames = [NSMutableArray array];
    }
    return _bannerGoodsFrames;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
