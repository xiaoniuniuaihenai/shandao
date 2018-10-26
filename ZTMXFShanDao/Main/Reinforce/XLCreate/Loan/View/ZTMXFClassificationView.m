//
//  ZTMXFClassificationView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFClassificationView.h"
#import "ZTMXFClassificationCell.h"
#import "ZTMXFClassification.h"
#import "ZTMXFGoodsCategoryListViewController.h"
#import "UIViewController+Visible.h"
#import "ZTMXFPrimaryCategoryCell.h"
#import "ZTMXFGoodsCategoryApi.h"
#import "CategoryListModel.h"
#import "LSGoodsDetailViewController.h"
@interface ZTMXFClassificationView ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong)NSMutableArray * smallArray;


@end


@implementation ZTMXFClassificationView





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = K_BackgroundColor;
        [self addSubview:view];
        
     
        self.dataArray = [NSMutableArray array];

        [self addSubview:self.tableView];

        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((KW - _tableView.width) / 2 - 0.6, 134 * PX);
        layout.minimumLineSpacing = 0.5;
        layout.minimumInteritemSpacing = 0.5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_tableView.width, _tableView.top, KW - _tableView.width, self.height) collectionViewLayout:layout];
        [_collectionView registerClass:[ZTMXFClassificationCell class] forCellWithReuseIdentifier:@"classificationCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, 90 * PX, self.height) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _tableView.rowHeight = 50 * PX;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_SRT(@"#F7F7F7");
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        @WeakObj(self);
        
//        MJRefreshNormalHeader* headerRefresh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [selfWeak refData];
//        }];
//        headerRefresh.lastUpdatedTimeLabel.hidden = YES;
//        headerRefresh.stateLabel.hidden = YES;
//        //        headerRefresh.stateLabel.font = FONT_LIGHT(14);
//        _tableView.mj_header = headerRefresh;
    }
    return _tableView;
}

#pragma mark -  TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellstr = @"cell";
    ZTMXFPrimaryCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (!cell) {
        cell = [[ZTMXFPrimaryCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.classification = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTMXFClassification * classification = _dataArray[indexPath.row];
    classification.isSelect = YES;
    if (![_classification.rid isEqualToString:classification.rid]) {
        _classification.isSelect = NO;
        _classification = classification;
        [tableView reloadData];
        if (_clickTableViewCell) {
            _clickTableViewCell(_classification);
        }
    }
}





- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZTMXFClassificationCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classificationCell" forIndexPath:indexPath];
    if (_classification.list.count > indexPath.row) {
        cell.categoryGoodsInfoModel = _classification.list[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryGoodsInfoModel * categoryGoodsInfoModel = _classification.list[indexPath.row];
    LSGoodsDetailViewController *goodsDetailVC = [[LSGoodsDetailViewController alloc] init];
    goodsDetailVC.goodsId = [NSString stringWithFormat:@"%ld",categoryGoodsInfoModel.goodsId];
    [[UIViewController currentViewController].navigationController pushViewController:goodsDetailVC animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _classification.list.count;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
