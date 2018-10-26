//
//  LSHistoryBillViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSHistoryBillViewController.h"
#import "LSPeriodLoanListCell.h"
#import "MyBillViewModel.h"
#import "LSPeriodBillModel.h"
#import "LSPeriodBillDetailViewController.h"

@interface LSHistoryBillViewController () <MyBillViewModelDelegete,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

/** 历史账单数组 */
@property (nonatomic, strong) NSMutableArray *historyBillListArray;

@property (nonatomic, strong) MyBillViewModel *billListViewModel;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation LSHistoryBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    
//    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"历史账单"];
//    [self set_Title:titleStr];
    
    self.title = @"历史账单";
    
    [self configueSubViews];
    
    self.currentPage = 1;
    self.historyBillListArray = [NSMutableArray array];
    
    //  请求历史账单
    [self.billListViewModel reuestPeriodHistoryBillListWithPageNum:self.currentPage];
}



#pragma mark - 加载更多数据
- (void)loadMoreData{
    self.currentPage += 1;
    self.mainTableView.mj_footer.hidden = NO;
    
    [self.billListViewModel reuestPeriodHistoryBillListWithPageNum:self.currentPage];
}

#pragma mark - MyBillViewModelDelegete
#pragma mark - 获取分期历史账单列表
- (void)requestPeriodHistoryBillListSuccess:(NSArray *)periodHistoryListArray
{
    if (self.currentPage == 1) {
        _mainTableView.mj_header.state = MJRefreshStateIdle;
        _historyBillListArray = [NSMutableArray array];
    } else {
        _mainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    if (periodHistoryListArray.count > 0) {
        [_historyBillListArray addObjectsFromArray:periodHistoryListArray];
    }
    
    if(periodHistoryListArray.count<10){
        _mainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        _mainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (_historyBillListArray.count ==0) {
        self.mainTableView.mj_header.hidden = YES;
        self.mainTableView.mj_footer.hidden = YES;
    }
    
    //增加无数据展现
    [self.view configBlankPage:EaseBlankPageTypeNoBillHistoryList hasData:self.historyBillListArray.count hasError:NO reloadButtonBlock:^(id sender) {
    }];
    
    [_mainTableView reloadData];
}
#pragma mark - 加载最新数据
- (void)loadNewData{
    self.currentPage = 1;
    self.mainTableView.mj_header.hidden = NO;
    
    [self.billListViewModel reuestPeriodHistoryBillListWithPageNum:self.currentPage];
}
#pragma mark - 请求账单数据失败
- (void)requestNoPaidBillListFailure{
    _mainTableView.mj_header.state = MJRefreshStateIdle;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _historyBillListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LSPeriodLoanListCell *cell = [LSPeriodLoanListCell cellWithTableView:tableView Type:LSPeriodLoanHistoryType];
    PeriodBillListModel *model = [_historyBillListArray objectAtIndex:indexPath.row];
    cell.billListModel = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 跳转到账单详情页
    PeriodBillListModel *billModel = [_historyBillListArray objectAtIndex:indexPath.row];
    LSPeriodBillDetailViewController *periodBillDetailVC = [[LSPeriodBillDetailViewController alloc] init];
    periodBillDetailVC.orderId = billModel.orderId;
    [self.navigationController pushViewController:periodBillDetailVC animated:YES];
}



#pragma mark - getter/setter
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height) style:UITableViewStylePlain];
        [_mainTableView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.sectionHeaderHeight = 1;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        
        __weak typeof(self) weakSelf = self;
        //默认block方法：设置下拉刷新
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
        //默认block方法：设置上拉加载更多
        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //Call this Block When enter the refresh status automatically
            [weakSelf loadMoreData];
        }];
    }
    return _mainTableView;
}

-(MyBillViewModel *)billListViewModel{
    if (!_billListViewModel) {
        _billListViewModel = [[MyBillViewModel alloc] init];
        _billListViewModel.delegete = self;
    }
    return _billListViewModel;
}
#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.mainTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
