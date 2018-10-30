//
//  LSGoodsDetailViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSGoodsDetailViewController.h"
#import "LSConfirmOrderViewController.h"

#import "GoodsDetailHeaderScrollView.h"
#import "GoodsChoiseView.h"
#import "GoodsDetailFooterScrollView.h"
#import "GoodsNavBarView.h"
#import "GoodsDetailNavigationView.h"
#import "GoodsDetailBottomView.h"
#import "GoodsDetailTableView.h"
#import "GoodRemarkFrame.h"

#import "GoodsDetailImageTableViewCell.h"
#import "GoodsDetailParamTableViewCell.h"

#import "GoodRemark.h"
#import "GoodsParamsModel.h"
#import "GoodsDetailModel.h"
#import "GoodsSkuPropertyModel.h"

#import "GoodsDetailViewModel.h"

#define kGoodsDetailBottomHeight      49.0
#define kAnimationDuration            0.45
//UITableViewDelegate UITableViewDelegate
@interface LSGoodsDetailViewController ()<GoodsDetailBottomViewDelegate, GoodsChoiseViewDelegate, GoodsDetailHeaderScrollViewDelegate, GoodsDetailViewModelDelegate>

/** 顶部活动描述 */
@property (nonatomic, strong) UILabel *topDescribeLabel;
/** UITableView */
//@property (nonatomic, strong) UITableView   *tableView;
/** headerView */
@property (nonatomic, strong) GoodsDetailHeaderScrollView  *goodsHeaderView;
/** goodsDetail BottomView */
@property (nonatomic, strong) GoodsDetailBottomView  *goodsBottomView;

/** viewModel */
@property (nonatomic, strong) GoodsDetailViewModel *goodsDetailViewModel;

/** 商品图片数组 */
@property (nonatomic, strong) NSMutableArray   *imageModelArray;
/** 商品详情Model */
@property (nonatomic, strong) GoodsDetailModel *goodsDetailModel;
/** 商品规格属性sku */
@property (nonatomic, strong) GoodsSkuPropertyModel *goodsSkuPropertyModel;

/** 选中skuId */
@property (nonatomic, assign) long selectSkuId;
/** 商品数量 */
@property (nonatomic, copy) NSString *goodsCount;
/** 选中商品规格属性名 */
@property (nonatomic, copy) NSString *selectGoodsProperName;
/** 商品规格对应库存 */
@property (nonatomic, assign) NSInteger goodsStock;

/** 是否立即购买 */
@property (nonatomic, assign) BOOL buyNow;

@end

@implementation LSGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //  添加子控件
    self.tableView.mj_header.hidden = YES;
    [self configSubViews];
    //  获取商品详情数据
    [self.goodsDetailViewModel requestGoodsDetailInfoWithGoodsId:self.goodsId];
    [self.goodsDetailViewModel requestGoodsSkuPropertyListWithGoodsId:self.goodsId];
}

- (void)clickReturnBackEvent{
    //  商品详情退出事件
    [self.goodsDetailViewModel goodsDetailAddScanEventWithGoodsId:self.goodsId outType:GoodsDetailReturnBack];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Native Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.imageModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    GoodsDetailImageInfoModel *goodsImageModel = self.imageModelArray[indexPath.row];
    CGFloat cellHeight = 200.0;
    CGFloat imageWidth = goodsImageModel.width;
    CGFloat imageHeight = goodsImageModel.height;
    if (imageWidth > 0.0 && imageHeight > 0.0) {
        cellHeight = imageHeight / imageWidth * SCREEN_WIDTH;
    } else {
        cellHeight = 10.0;
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedHeight(50.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headerButton.backgroundColor = [UIColor whiteColor];
    [headerButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
    headerButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [headerButton setTitle:@"  商品详情" forState:UIControlStateNormal];
    [headerButton setImage:[UIImage imageNamed:@"goods_detail_icon"] forState:UIControlStateNormal];
    
    UIView *lineView = [UIView setupViewWithSuperView:headerButton withBGColor:COLOR_BORDER_STR];
    lineView.frame = CGRectMake(0.0, AdaptedHeight(50.0) - 0.5, Main_Screen_Width, 0.5);
    
    return headerButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailImageTableViewCell *cell = [GoodsDetailImageTableViewCell cellWithTableView:tableView];
    cell.goodsDetailImageInfoModel = self.imageModelArray[indexPath.row];
    cell.goodsDetailImageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}

#pragma mark - 自定义代理
#pragma mark GoodsDetailBottomViewDelegate 底部点击立即购买
- (void)goodsDetailBottomViewClickPurchase{
    if (self.buyNow) {
        //  先登录
        if (![LoginManager loginState]){
            [LoginManager presentLoginVCWithController:self];
            return;
        }
        
        //  判断库存是否充足
        NSInteger purchaseGoodsCount = [self.goodsCount integerValue];
        if (purchaseGoodsCount == 0 || purchaseGoodsCount > self.goodsStock) {
            //  商品数量为0, 或者大于库存 重新选择规格
            [self popupGoodsChoiseView];
            return;
        }
        
        //  商品详情立即购买事件
        [self.goodsDetailViewModel goodsDetailAddScanEventWithGoodsId:self.goodsId outType:GoodsDetailBuyNow];

        LSConfirmOrderViewController *confirmOrderVC = [[LSConfirmOrderViewController alloc] init];
        confirmOrderVC.goodsId = self.goodsId;
        confirmOrderVC.skuId = self.selectSkuId;
        confirmOrderVC.selectGoodsProperty = self.selectGoodsProperName;
        confirmOrderVC.goodsCount = self.goodsCount;
        [self.navigationController pushViewController:confirmOrderVC animated:YES];
    } else {
        [self popupGoodsChoiseView];
    }
}

#pragma mark GoodsDetailHeaderScrollViewDelegate 选择规格
- (void)goodsDetailHeaderScrollViewClickChoiseProperty{
    [self popupGoodsChoiseView];
}

#pragma mark GoodsChoiseViewDelegate 弹框立即购买
- (void)goodsChoiseViewBuyNowWithSku:(GoodsPriceInfoModel *)skuModel goodsCount:(NSString *)goodsCount goodsProperty:(NSString *)goodsProperty{
    
    //  先登录
    if (![LoginManager loginState]){
        [LoginManager presentLoginVCWithController:self];
        return;
    }

    //  设置选中的skuId和商品数量
    self.selectSkuId = skuModel.skuId;
    self.goodsCount = goodsCount;
    self.selectGoodsProperName = goodsProperty;
    [self.goodsHeaderView configGoodsPropertyName:self.selectGoodsProperName];
    self.goodsDetailModel.skuId = self.selectSkuId;
    
    //  月供
    NSInteger goodsNumber = [self.goodsCount integerValue];
    double monthPay = skuModel.monthPay * goodsNumber;
    [self.goodsBottomView configMonthPay:[NSString stringWithFormat:@"%.2f",monthPay]];
    
    //  判断库存是否充足
    NSInteger purchaseGoodsCount = [self.goodsCount integerValue];
    if (purchaseGoodsCount == 0 || purchaseGoodsCount > self.goodsStock) {
        return;
    }
    
    //  商品详情立即购买事件
    [self.goodsDetailViewModel goodsDetailAddScanEventWithGoodsId:self.goodsId outType:GoodsDetailBuyNow];
    
    LSConfirmOrderViewController *confirmOrderVC = [[LSConfirmOrderViewController alloc] init];
    confirmOrderVC.goodsId = self.goodsId;
    confirmOrderVC.skuId = skuModel.skuId;
    confirmOrderVC.selectGoodsProperty = goodsProperty;
    confirmOrderVC.goodsCount = goodsCount;
    [self.navigationController pushViewController:confirmOrderVC animated:YES];
}

/** 选中规格 */
- (void)goodsChoiseViewSelectSkuModel:(GoodsPriceInfoModel *)skuModel goodsCount:(NSString *)goodsCount goodsPropertyName:(NSString *)propertyName{
    //  设置选中的skuId和商品数量
    self.selectSkuId = skuModel.skuId;
    self.goodsCount = goodsCount;
    self.goodsStock = skuModel.stock;
    self.selectGoodsProperName = propertyName;
    [self.goodsHeaderView configGoodsPropertyName:self.selectGoodsProperName];
    self.goodsDetailModel.skuId = self.selectSkuId;
    //  月供
    NSInteger goodsNumber = [self.goodsCount integerValue];
    double monthPay = skuModel.monthPay * goodsNumber;
    [self.goodsBottomView configMonthPay:[NSString stringWithFormat:@"%.2f",monthPay]];
}

/** 取消选中规格 */
- (void)goodsChoiseViewCancelGoodsProperty{
    self.goodsCount = @"1";
    self.selectGoodsProperName = @"";
    [self.goodsHeaderView configGoodsPropertyName:self.selectGoodsProperName];
    [self.goodsBottomView configMonthPay:[NSString stringWithFormat:@"0.00"]];
}

#pragma mark GoodsDetailViewModelDelegate
//  获取商品详情数据
- (void)requestGoodsDetailInfoSuccess:(GoodsDetailModel *)goodsDetailModel{
    if (goodsDetailModel) {
        if (goodsDetailModel.skuId > 0) {
            self.selectSkuId = goodsDetailModel.skuId;
        }
        self.goodsCount = @"1";
        NSString *propertyString = [NSString string];
        for (NSString *property in _goodsDetailModel.propertyValues) {
            if (!kStringIsEmpty(property)) {
                propertyString = [propertyString stringByAppendingString:[NSString stringWithFormat:@" %@",property]];
            }
        }
        self.selectGoodsProperName = propertyString;
        [self.goodsHeaderView configGoodsPropertyName:self.selectGoodsProperName];
        self.goodsStock = goodsDetailModel.stock;
        
        
        self.goodsDetailModel = goodsDetailModel;
        self.goodsHeaderView.goodsDetailModel = goodsDetailModel;
        if (self.imageModelArray.count > 0) {
            [self.imageModelArray removeAllObjects];
        }
        [self.imageModelArray addObjectsFromArray:goodsDetailModel.goodsInfo.detailImages];
        [self.tableView reloadData];
        [self.goodsBottomView configMonthPay:[NSString stringWithFormat:@"%.2f",goodsDetailModel.monthPay]];
        [self addFooter];
        
//        if (goodsDetailModel.activityRemind.length > 0) {
//            self.topDescribeLabel.text = goodsDetailModel.activityRemind;
//
//            [UIView animateWithDuration:1.0 animations:^{
//                self.topDescribeLabel.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 36.0);
//                self.tableView.frame = CGRectMake(0.0, CGRectGetMaxY(self.topDescribeLabel.frame), Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height - kGoodsDetailBottomHeight-36.0);
//            } completion:^(BOOL finished) {
//
//            }];
//
//        } else {
//            self.tableView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height - kGoodsDetailBottomHeight);
//        }
    }
}

- (void)addFooter
{
//    @WeakObj(self);
    self.tableView.backgroundColor = K_LineColor;
    if (!self.tableView.mj_footer) {
        MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//            [selfWeak moreData];
        }];
        footer.frame = CGRectMake(0, 0, KW, 70);
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = FONT_LIGHT(14);
        [footer addSubview:self.imageView];
        self.imageView.frame = CGRectMake(15, 0, KW - 30, footer.height);
        self.tableView.mj_footer = footer;
        self.imageView.hidden = NO;
        [footer endRefreshingWithNoMoreData];
    }
}

/** 获取商品规格属性列表成功 */
- (void)requestGoodsSkuPropertyListSuccess:(GoodsSkuPropertyModel *)goodsSkuPropertyModel{
    if (goodsSkuPropertyModel) {
        self.goodsSkuPropertyModel = goodsSkuPropertyModel;
    }
}

#pragma mark - 私有方法
//  弹出商品规格框
- (void)popupGoodsChoiseView{
    //  如果没有规格属性去重新请求
    if (self.goodsSkuPropertyModel.skuList.count <= 0) {
        [self.goodsDetailViewModel requestGoodsSkuPropertyListWithGoodsId:self.goodsId];
    }
    
    //  弹出规格现则框
    GoodsChoiseView *choiseView = [GoodsChoiseView popGoodsChoiseView];
    choiseView.delegate = self;
    choiseView.goodsPropertyModelArray = self.goodsSkuPropertyModel.propertyList;
    choiseView.goodsPriceModelArray = self.goodsSkuPropertyModel.skuList;
    choiseView.goodsDetailModel = self.goodsDetailModel;
    choiseView.goodsCount = [self.goodsCount integerValue];
    self.buyNow = YES;
    
}


#pragma mark - ConfigSubViews添加子控件
- (void)configSubViews{
    [self.view addSubview:self.topDescribeLabel];// 暂未用到
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.goodsHeaderView;
    [self.view addSubview:self.goodsBottomView];
    
    self.topDescribeLabel.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 36.0);
    self.tableView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height - kGoodsDetailBottomHeight);
}

#pragma mark - getter/setter
//- (UITableView *)tableView{
//    if (!_tableView) {
//        CGRect rect = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height - kGoodsDetailBottomHeight);
//        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
//        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.showsHorizontalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//    }
//    return _tableView;
//}

- (GoodsDetailHeaderScrollView *)goodsHeaderView{
    if (_goodsHeaderView == nil) {
        _goodsHeaderView = [[GoodsDetailHeaderScrollView alloc] init];
        _goodsHeaderView.backgroundColor = [UIColor whiteColor];
        _goodsHeaderView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, AdaptedHeight(600.0));
        _goodsHeaderView.headerDelegate = self;
        _goodsHeaderView.scrollEnabled = NO;
    }
    return _goodsHeaderView;
    
}

- (GoodsDetailBottomView *)goodsBottomView{
    if (_goodsBottomView == nil) {
        _goodsBottomView = [[GoodsDetailBottomView alloc] init];
        _goodsBottomView.backgroundColor = [UIColor whiteColor];
        _goodsBottomView.delegate = self;
        _goodsBottomView.frame = CGRectMake(0.0, SCREEN_HEIGHT - kGoodsDetailBottomHeight - TabBar_Addition_Height, SCREEN_WIDTH, kGoodsDetailBottomHeight);
    }
    return _goodsBottomView;
}

/** 顶部活动描述 */
- (UILabel *)topDescribeLabel{
    if (_topDescribeLabel == nil) {
        _topDescribeLabel = [UILabel labelWithTitleColorStr:@"ffe1b7" fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
        _topDescribeLabel.text = @"满返活动返现将在三个工作日内由系统发放至余额";
        _topDescribeLabel.backgroundColor = [UIColor colorWithHexString:@"f73530"];
    }
    return _topDescribeLabel;
}

/** 商品图片数组 */
- (NSMutableArray *)imageModelArray{
    if (_imageModelArray == nil) {
        _imageModelArray = [NSMutableArray array];
    }
    return _imageModelArray;
}

- (GoodsDetailViewModel *)goodsDetailViewModel{
    if (_goodsDetailViewModel == nil) {
        _goodsDetailViewModel = [[GoodsDetailViewModel alloc] init];
        _goodsDetailViewModel.delegate = self;
    }
    return _goodsDetailViewModel;
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
