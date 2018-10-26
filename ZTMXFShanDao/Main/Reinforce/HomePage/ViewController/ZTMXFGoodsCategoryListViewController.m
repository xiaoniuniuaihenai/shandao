//
//  LSGoodsCategoryListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFGoodsCategoryListViewController.h"
#import "GoodsCategoryCollectionViewCell.h"
#import "LSGoodsDetailViewController.h"
#import "SDCycleScrollView.h"
#import "CategoryHeaderCollectionReusableView.h"

#import "CategoryListModel.h"
#import "ZTMXFCategoryListViewModel.h"
#import "ZTMXFMobileRechargeController.h"

#define kGoodsCategoryListHeaderReuseIdentifier  @"kGoodsCategoryListHeaderReuseIdentifier"


@interface ZTMXFGoodsCategoryListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, CategoryListViewModelDelegate, SDCycleScrollViewDelegate, UICollectionViewDelegateFlowLayout>

/** 轮播图 */
@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView;
@property (nonatomic, strong) UICollectionView   *goodsCollectionView;
@property (nonatomic, strong) NSMutableArray     *goodsCategoryArray;
@property (nonatomic, strong) NSMutableArray     *goodsBannerArray;
@property (nonatomic, strong) ZTMXFCategoryListViewModel *categoryListViewModel;
/** 当前请求页码 */
@property (nonatomic, assign) NSInteger currentPageNumber;

@end

@implementation ZTMXFGoodsCategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.goodsCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self configSubViews];
    self.currentPageNumber = 1;
    [self loadCategoryListData];
}

#pragma mark - UICollectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsCategoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCategoryCollectionViewCell" forIndexPath:indexPath];
    CategoryGoodsInfoModel *categoryGoodsInfoModel = self.goodsCategoryArray[indexPath.row];
    cell.categoryGoodsInfoModel = categoryGoodsInfoModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSGoodsDetailViewController *goodsDetailVC = [[LSGoodsDetailViewController alloc] init];
    CategoryGoodsInfoModel *categoryGoodsInfoModel = self.goodsCategoryArray[indexPath.row];
    goodsDetailVC.goodsId = [NSString stringWithFormat:@"%ld",categoryGoodsInfoModel.goodsId];
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}

////  创建 分区头尾视图调用
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    //(如果满足不了需要那么就定制)
//    CategoryHeaderCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGoodsCategoryListHeaderReuseIdentifier forIndexPath:indexPath];
//    return reusableView;
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CGFloat cellTopPadding = AdaptedHeight(30.0);
    CGFloat cellBottomPadding = AdaptedHeight(0.0);
    CGFloat cellLeftPadding = AdaptedWidth(9.0);
    CGFloat cellRightMarging = AdaptedWidth(9.0);
    if (self.goodsBannerArray.count > 0) {
        CGFloat bannerHeight = 0;
        return UIEdgeInsetsMake(cellTopPadding + bannerHeight, cellLeftPadding, cellBottomPadding, cellRightMarging);
    } else {
        return UIEdgeInsetsMake(cellTopPadding, cellLeftPadding, cellBottomPadding, cellRightMarging);
    }
}

#pragma mark - 获取商品分区数据成功
/** 获取商品分区数据成功 */
- (void)requestGoodsCategoryListSuccess:(CategoryListModel *)categoryListModel pageNumber:(NSInteger)pageNumber{
    if (categoryListModel) {
        if (pageNumber == 1) {
            if (!kStringIsEmpty(categoryListModel.title)) {
                self.navigationItem.title = categoryListModel.title;
            }
            //  设置banner数据
            [self.goodsBannerArray removeAllObjects];
            NSMutableArray *bannerUrlArray = [NSMutableArray array];
            for (CategoryBannerModel *bannerModel in categoryListModel.bannerList) {
                [self.goodsBannerArray addObject:bannerModel];
                if (bannerModel.image) {
                    [bannerUrlArray addObject:bannerModel.image];
                }
            }
            if (self.goodsBannerArray.count > 0) {
                self.cycleScrollView.hidden = NO;
                self.cycleScrollView.imageURLStringsGroup = bannerUrlArray;
//                [self.goodsCollectionView reloadData];

            } else {
                self.cycleScrollView.hidden = YES;
            }
        }
        
        //  商品列表
        if (pageNumber == 1) {
            [self.goodsCategoryArray removeAllObjects];
        }
        self.currentPageNumber ++;

        NSMutableArray *goodsArray = [NSMutableArray array];
        for (int i = 0; i < categoryListModel.categoryList.count; i ++) {
            CategoryGoodsModel *categoryGoodsModel = categoryListModel.categoryList[i];
            for (CategoryGoodsInfoModel *categoryGoodsInfoModel in categoryGoodsModel.goodsList) {
                if (categoryGoodsInfoModel) {
                    [goodsArray addObject:categoryGoodsInfoModel];
                }
            }
        }
        if(goodsArray.count < 10){
            self.goodsCollectionView.mj_footer.state = MJRefreshStateNoMoreData;
        } else {
            self.goodsCollectionView.mj_footer.state = MJRefreshStateIdle;
        }
        [self.goodsCategoryArray addObjectsFromArray:goodsArray];

        [self.goodsCollectionView reloadData];
    }
    
    [self endupRefresh];
}



/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    CategoryBannerModel *bannerModel = self.goodsBannerArray[index];
    /** 跳转类型：为1时：h5跳转链接；为2:类目id；为3是：商品id；为4是：app内页 */
    NSInteger bannerType = [bannerModel.type integerValue];
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
/** 获取商品分区数据失败 */
- (void)requestGoodsCategoryListFailure{
    [self endupRefresh];
}


#pragma mark - 私有方法
//  下拉刷新数据
- (void)refreshCategoryData{
    self.currentPageNumber = 1;
    [self loadCategoryListData];
}
//  上拉加载数据
- (void)loadMoreCategoryData{
    [self loadCategoryListData];
}
//  结束刷新
- (void)endupRefresh{
    if (self.goodsCollectionView.mj_header.isRefreshing) {
        [self.goodsCollectionView.mj_header endRefreshing];
    }
    if (self.goodsCollectionView.mj_footer.isRefreshing) {
        [self.goodsCollectionView.mj_footer endRefreshing];
    }
}
//  下拉刷新
- (void)loadCategoryListData{
    BOOL showLoad = YES;
    if (self.goodsCategoryArray.count > 0) {
        showLoad = NO;
    }
    [self.categoryListViewModel requestGoodsCategoryListWithCategoryId:self.categoryId pageNumber:self.currentPageNumber showLoad:showLoad];
}

#pragma mark - 添加子控件
- (void)configSubViews{
    [self.view addSubview:self.goodsCollectionView];
    [self.goodsCollectionView addSubview:self.cycleScrollView];
}

#pragma mark - setter/getter
- (UICollectionView *)goodsCollectionView{
    if (_goodsCollectionView == nil) {
        CGFloat cellLeftPadding = AdaptedWidth(9.0);
        CGFloat cellRightMarging = AdaptedWidth(9.0);
        CGFloat cellLinePadding = AdaptedHeight(1.0);
        CGFloat cellItemPadding = AdaptedHeight(9.0);
        CGFloat cellWidth  = (Main_Screen_Width - cellLeftPadding - cellRightMarging - cellItemPadding) / 2.0;
        CGFloat cellHeight = cellWidth + 75.0;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = cellLinePadding;
        layout.minimumInteritemSpacing = cellItemPadding;
        [layout setItemSize:CGSizeMake(cellWidth, cellHeight)];//设置cell的尺寸
        //  设置header Size
//        layout.headerReferenceSize = CGSizeMake(Main_Screen_Width, AdaptedHeight(60.0));
//        layout.footerReferenceSize = CGSizeMake(Main_Screen_Width, 10.0);
        _goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height) collectionViewLayout:layout];
        _goodsCollectionView.backgroundColor = [UIColor whiteColor];
        _goodsCollectionView.showsVerticalScrollIndicator = NO;
        _goodsCollectionView.dataSource = self;
        _goodsCollectionView.delegate   = self;
        _goodsCollectionView.clipsToBounds = YES;
        [_goodsCollectionView registerClass:[GoodsCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCategoryCollectionViewCell"];
//        [_goodsCollectionView registerClass:[CategoryHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGoodsCategoryListHeaderReuseIdentifier];
        // 设置下拉刷新
        
       MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshCategoryData)];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        _goodsCollectionView.mj_header = header;
        
        MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCategoryData)];
        [footer setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = FONT_Regular(14);
        _goodsCollectionView.mj_footer = footer;
    }
    return _goodsCollectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.goodsBannerArray.count > 0) {
        return CGSizeMake(KW, 135 * PX);
    }
    return CGSizeMake(KW, 0.01);
}

/** 轮播网络图片 */
-(SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 135 * PX) delegate:self placeholderImage:[UIImage imageNamed:@"banner_placeholder_180"]];
        [_cycleScrollView setBackgroundColor:[UIColor whiteColor]];
        _cycleScrollView.autoScrollTimeInterval = 5;
        //设置轮播视图的分页控件的显示

        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //其他分页控件小圆标图片
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlDotSize = CGSizeMake(8, 3);
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
    }
    return _cycleScrollView;
}

- (NSMutableArray *)goodsCategoryArray{
    if (_goodsCategoryArray == nil) {
        _goodsCategoryArray = [NSMutableArray array];
    }
    return _goodsCategoryArray;
}

- (NSMutableArray *)goodsBannerArray{
    if (_goodsBannerArray == nil) {
        _goodsBannerArray = [NSMutableArray array];
    }
    return _goodsBannerArray;
}

- (ZTMXFCategoryListViewModel *)categoryListViewModel{
    if (_categoryListViewModel == nil) {
        _categoryListViewModel = [[ZTMXFCategoryListViewModel alloc] init];
        _categoryListViewModel.delegate = self;
    }
    return _categoryListViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
