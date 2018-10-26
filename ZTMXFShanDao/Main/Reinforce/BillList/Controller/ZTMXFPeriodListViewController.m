//
//  LSPeriodListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPeriodListViewController.h"
#import "LSPeriodListTopView.h"
#import "LSPeriodLoanListCell.h"
#import "MyBillViewModel.h"
#import "LSBillListModel.h"
#import "LSPeriodBillModel.h"
#import "LSLoanRepayViewController.h"
#import "LSHistoryBillViewController.h"
#import "LSPeriodBillDetailViewController.h"

@interface ZTMXFPeriodListViewController () <LSPeriodListTopViewDelegete,UITableViewDataSource,UITableViewDelegate,PeriodLoanListCellDelegete,MyBillViewModelDelegete>

@property (nonatomic, strong) LSPeriodListTopView *topView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *bottomView;
/** 选中所有按钮 */
@property (nonatomic, strong) UIButton *selectedAllBtn;
/** 立即还款按钮 */
@property (nonatomic, strong) UIButton *nowPayBtn;

/** 本月应还账单数组 */
@property (nonatomic, strong) NSMutableArray *monthBillListArray;
/** 选中本月应还账单数组 */
@property (nonatomic, strong) NSMutableArray *monthSelectedBillArray;
/** 剩余应还账单数组 */
@property (nonatomic, strong) NSMutableArray *residueBillListArray;
/** 选中剩余应还账单数组 */
@property (nonatomic, strong) NSMutableArray *residueSelectedBillArray;
/** 还款中账单数组 */
@property (nonatomic, strong) NSMutableArray *progressBillListArray;

/** 本月应还账单金额 */
@property (nonatomic, copy) NSString *monthPayMoney;
/** 剩余应还账单金额 */
@property (nonatomic, copy) NSString *residuePayMoney;

/** 账单类型 */
@property (nonatomic, assign) LSPeriodLoanListCellType billType;
/** 账单ViewModel */
@property (nonatomic, strong) MyBillViewModel *billListViewModel;

@property (nonatomic, strong) LSPeriodBillModel *periodBillModel;

/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ZTMXFPeriodListViewController

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
    
//    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"我的账单"];
//    [self set_Title:titleStr];
    self.title = @"我的账单";
    
    [self setNavgationBarRightTitle:@"历史账单"];
    
    [self configueSubViews];// 初始化页面
    
    [self initBillData];// 初始化数据
    
    [self.billListViewModel reuestPeriodBillListWithBillType:@"0"];
}






#pragma mark - 右边导航点击
- (void)right_button_event:(UIButton *)sender{
    
    // 跳转到历史账单页面
    LSHistoryBillViewController *historyBillVC = [[LSHistoryBillViewController alloc] init];
    [self.navigationController pushViewController:historyBillVC animated:YES];
}

#pragma mark - 加载最新数据
- (void)loadNewData{
    self.mainTableView.mj_header.state = MJRefreshStateIdle;
}

#pragma mark - MyBillViewModelDelegete
- (void)requestPeriodBillListSuccess:(LSPeriodBillModel *)periodBillModel{
    self.periodBillModel = periodBillModel;

    if (self.billType == LSPeriodLoanMonthType) {
        // 本月账单
        [_monthBillListArray setArray:periodBillModel.billList];
        
        self.mainTableView.tableHeaderView = self.topView;
        self.topView.periodBillModel = periodBillModel;
        if (_monthBillListArray.count > 0) {
            self.bottomView.hidden = NO;
        }
    } else if (self.billType == LSPeriodLoanResidueType) {
        // 剩余账单
        [_residueBillListArray setArray:periodBillModel.billList];
        self.topView.periodBillModel = periodBillModel;
        if (_residueBillListArray.count > 0) {
            self.bottomView.hidden = NO;
        }
    } else if (self.billType == LSPeriodLoanProgressType) {
        // 还款中账单
        [_progressBillListArray setArray:periodBillModel.billList];
        self.topView.periodBillModel = periodBillModel;
    }
    [self.mainTableView reloadData];
    // 设置还款状态
    [self setPayMoneyButtonStatus];
}
#pragma mark - 初始化数据
- (void)initBillData{
    
    self.monthPayMoney = @"0.00";
    self.residuePayMoney = @"0.00";
    self.billType = LSPeriodLoanMonthType;// 默认本月账单
    self.monthBillListArray = [NSMutableArray array];
    self.monthSelectedBillArray = [NSMutableArray array];
    self.residueBillListArray = [NSMutableArray array];
    self.residueSelectedBillArray = [NSMutableArray array];
    self.progressBillListArray = [NSMutableArray array];
}
#pragma mark - LSPeriodListTopViewDelegete
#pragma mark - 切换头部账单菜单
- (void)clickTopMenu:(NSInteger)index{
    
    self.bottomView.hidden = YES;
    if (index == 0) {
        // 点击本月应还
        self.billType = LSPeriodLoanMonthType;
        self.monthSelectedBillArray = [NSMutableArray array];
        [self.billListViewModel reuestPeriodBillListWithBillType:@"0"];
    } else if (index == 1){
        // 点击剩余应还
        self.billType = LSPeriodLoanResidueType;
        self.residueSelectedBillArray = [NSMutableArray array];
        [self.billListViewModel reuestPeriodBillListWithBillType:@"1"];
    } else if (index == 2){
        // 点击还款中
        self.billType = LSPeriodLoanProgressType;
        [self.billListViewModel reuestPeriodBillListWithBillType:@"2"];
    }
    self.mainTableView.height = SCREEN_HEIGHT-k_Navigation_Bar_Height-(self.billType == LSPeriodLoanProgressType ? 0 : AdaptedHeight(60));
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.billType == LSPeriodLoanMonthType) {
        return _monthBillListArray.count;
    } else if (self.billType == LSPeriodLoanResidueType) {
        return _residueBillListArray.count;
    } else if (self.billType == LSPeriodLoanProgressType) {
        return _progressBillListArray.count;
    } else{
        return 0;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LSPeriodLoanListCell *cell = [LSPeriodLoanListCell cellWithTableView:tableView Type:self.billType];
    if (self.billType == LSPeriodLoanMonthType) {
        // 本月应还账单
        if (_monthBillListArray.count > 0) {
            PeriodBillListModel *model = [_monthBillListArray objectAtIndex:indexPath.row];
            cell.loanCellType = self.billType;
            cell.billListModel = model;
            cell.delegete = self;
            if ([_monthSelectedBillArray containsObject:model]) {
                cell.selectedBtn.selected = YES;
            }else{
                cell.selectedBtn.selected = NO;
            }
        }
    } else if (self.billType == LSPeriodLoanResidueType) {
        // 剩余应还账单
        if (_residueBillListArray.count > 0) {
            PeriodBillListModel *model = [_residueBillListArray objectAtIndex:indexPath.row];
            cell.loanCellType = self.billType;
            cell.billListModel = model;
            cell.delegete = self;
            if ([_residueSelectedBillArray containsObject:model]) {
                cell.selectedBtn.selected = YES;
            }else{
                cell.selectedBtn.selected = NO;
            }
        }
    } else {
        // 还款中账单
        if (_progressBillListArray.count > 0) {
            PeriodBillListModel *model = [_progressBillListArray objectAtIndex:indexPath.row];
            cell.loanCellType = self.billType;
            cell.billListModel = model;
            cell.delegete = self;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return AdaptedHeight(70);
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    PeriodBillListModel *billModel;
    if (self.billType == LSPeriodLoanMonthType) {
        billModel = [_monthBillListArray objectAtIndex:indexPath.row];
    } else if (self.billType == LSPeriodLoanResidueType) {
        billModel = [_residueBillListArray objectAtIndex:indexPath.row];
    } else if (self.billType == LSPeriodLoanProgressType) {
        billModel = [_progressBillListArray objectAtIndex:indexPath.row];
    }
    // 跳转到账单详情页
    LSPeriodBillDetailViewController *periodBillDetailVC = [[LSPeriodBillDetailViewController alloc] init];
    periodBillDetailVC.orderId = billModel.orderId;
    [self.navigationController pushViewController:periodBillDetailVC animated:YES];
}

#pragma mark - PeriodLoanListCellDelegete
- (void)selectedCellButtonClick:(PeriodBillListModel *)selectedBillModel{
    //1.选中 2.取消选中
    if (self.billType == LSPeriodLoanMonthType) {
        // 本月应还账单
        if ([_monthSelectedBillArray containsObject:selectedBillModel]) {
            // 已经选中的移除
            [_monthSelectedBillArray removeObject:selectedBillModel];
            _monthPayMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:_monthPayMoney rightString:[NSDecimalNumber stringWithFloatValue:selectedBillModel.amount]];
        } else {
            [_monthSelectedBillArray addObject:selectedBillModel];
            _monthPayMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_monthPayMoney rightString:[NSDecimalNumber stringWithFloatValue:selectedBillModel.amount]];
        }
    } else if (self.billType == LSPeriodLoanResidueType) {
        // 剩余应还账单
        if ([_residueSelectedBillArray containsObject:selectedBillModel]) {
            // 已经选中的移除
            [_residueSelectedBillArray removeObject:selectedBillModel];
            _residuePayMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:_residuePayMoney rightString:[NSDecimalNumber stringWithFloatValue:selectedBillModel.amount]];
        } else {
            [_residueSelectedBillArray addObject:selectedBillModel];
            _residuePayMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_residuePayMoney rightString:[NSDecimalNumber stringWithFloatValue:selectedBillModel.amount]];
        }
    }
    // 设置状态
    [self setPayMoneyButtonStatus];
}



#pragma mark -私有方法
#pragma mark - 点击全选按钮
- (void)selectedAllBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    // 获取所有可见cell的索引
    NSArray *cellArr = [self.mainTableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in cellArr) {
        LSPeriodLoanListCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        cell.selectedBtn.selected = sender.selected;
    }
    // 判断是本月应还／剩余应还
    if (self.billType == LSPeriodLoanMonthType) {
        _monthPayMoney = @"0.00";
        // 如果全选
        if (sender.selected) {
            [_monthSelectedBillArray setArray:_monthBillListArray];
            if (_monthSelectedBillArray.count > 0) {
                for (PeriodBillListModel *billModel in _monthSelectedBillArray) {
                    _monthPayMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_monthPayMoney rightString:[NSDecimalNumber stringWithFloatValue:billModel.amount]];
                }
            }
        }else{
            _monthSelectedBillArray = [NSMutableArray array];
        }
    } else if (self.billType == LSPeriodLoanResidueType) {
        _residuePayMoney = @"0.00";
        if (sender.selected) {
            [_residueSelectedBillArray setArray:_residueBillListArray];
            if (_residueSelectedBillArray.count > 0) {
                for (PeriodBillListModel *billModel in _residueSelectedBillArray) {
                    _residuePayMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_residuePayMoney rightString:[NSDecimalNumber stringWithFloatValue:billModel.amount]];
                }
            }
        } else{
            _residueSelectedBillArray = [NSMutableArray array];
        }
    }
    // 设置还款按钮状态
    [self setPayMoneyButtonStatus];
}

#pragma mark - 设置还款按钮的状态
- (void)setPayMoneyButtonStatus
{
    
    if (self.billType == LSPeriodLoanMonthType) {
        // 本月应还
        if (_monthSelectedBillArray.count > 0) {
            if (_monthSelectedBillArray.count == _monthBillListArray.count) {
                self.selectedAllBtn.selected = YES;
            }else{
                self.selectedAllBtn.selected = NO;
            }
            [self.nowPayBtn setTitle:[NSString stringWithFormat:@"立即还款（¥%@）",_monthPayMoney] forState:UIControlStateNormal];
            [self.nowPayBtn setBackgroundColor:K_MainColor];
        }else{
            self.selectedAllBtn.selected = NO;
            self.monthPayMoney = @"0.00";
            [self.nowPayBtn setTitle:@"立即还款" forState:UIControlStateNormal];
            [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:@"D8D8D8"]];
        }
    } else if (self.billType == LSPeriodLoanResidueType) {
        // 剩余应还
        if (_residueSelectedBillArray.count > 0) {
            if (_residueSelectedBillArray.count == _residueBillListArray.count) {
                self.selectedAllBtn.selected = YES;
            }else{
                self.selectedAllBtn.selected = NO;
            }
            [self.nowPayBtn setTitle:[NSString stringWithFormat:@"提前还款（¥%@）",_residuePayMoney] forState:UIControlStateNormal];
            [self.nowPayBtn setBackgroundColor:K_MainColor];
        }else{
            self.selectedAllBtn.selected = NO;
            self.residuePayMoney = @"0.00";
            [self.nowPayBtn setTitle:@"提前还款" forState:UIControlStateNormal];
            [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:@"D8D8D8"]];
        }
    }
}

#pragma mark - 点击立即还款按钮
- (void)nowPayMoneyClick:(UIButton *)sender{
    
    NSArray *selectedBillArray = [NSArray array];
    NSString *payMoney = @"";
    if (self.billType == LSPeriodLoanMonthType) {
        // 本月应还
        if (_monthSelectedBillArray.count == 0) {
            return;
        }
        selectedBillArray = [NSArray arrayWithArray:_monthSelectedBillArray];
        payMoney = self.monthPayMoney;
    } else if (self.billType == LSPeriodLoanResidueType) {
        // 剩余应还
        if (_residueSelectedBillArray.count == 0) {
            return;
        }
        selectedBillArray = [NSArray arrayWithArray:_residueSelectedBillArray];
        payMoney = self.residuePayMoney;
    }
    NSMutableString *billIds;
    // 消费分期
    for (int i=0; i<selectedBillArray.count; i++) {
        PeriodBillListModel *billModel = selectedBillArray[i];
        NSString *billStr = [NSString stringWithFormat:@"%ld",billModel.rid];
        if (i==0) {
            billIds = [[NSMutableString alloc] initWithString:billStr];
        }else{
            [billIds appendString:[NSString stringWithFormat:@",%@",billStr]];
        }
    }
    // 跳转到还款页面
    LSLoanRepayViewController *loanRepayVC = [[LSLoanRepayViewController alloc] init];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:payMoney];
    loanRepayVC.repayAmount = [decNumber doubleValue];
    loanRepayVC.borrowId = billIds;
    loanRepayVC.loanType = MallLoanType;
    [self.navigationController pushViewController:loanRepayVC animated:YES];
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.bottomView];
    self.bottomView.hidden = YES;
}

#pragma mark - get
- (LSPeriodListTopView *)topView{
    if (!_topView) {
        _topView = [[LSPeriodListTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeight(180.0))];
        _topView.tabNum = self.periodBillModel.tableNum;
        _topView.delegete = self;
    }
    return _topView;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height-AdaptedHeight(60)) style:UITableViewStylePlain];
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
    }
    return _mainTableView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-AdaptedHeight(60), SCREEN_WIDTH, AdaptedHeight(60))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        self.selectedAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectedAllBtn setFrame:CGRectMake(0, 0, AdaptedWidth(135), _bottomView.height)];
        [self.selectedAllBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
        [self.selectedAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self.selectedAllBtn setTitleColor:[UIColor colorWithHexString:@"4A4A4A"] forState:UIControlStateNormal];
        [self.selectedAllBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
        [self.selectedAllBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
        [self.selectedAllBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [self.selectedAllBtn addTarget:self action:@selector(selectedAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.selectedAllBtn];
        
        self.nowPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nowPayBtn setFrame:CGRectMake(_selectedAllBtn.right, 0, SCREEN_WIDTH-_selectedAllBtn.width, _bottomView.height)];
        [self.nowPayBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
        [self.nowPayBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [self.nowPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:@"D8D8D8"]];
        [self.nowPayBtn addTarget:self action:@selector(nowPayMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
        self.nowPayBtn.layer.cornerRadius = self.nowPayBtn.height/2;
        self.nowPayBtn.layer.masksToBounds = YES;
        [_bottomView addSubview:self.nowPayBtn];
    }
    return _bottomView;
}

-(MyBillViewModel *)billListViewModel{
    if (!_billListViewModel) {
        _billListViewModel = [[MyBillViewModel alloc] init];
        _billListViewModel.delegete = self;
    }
    return _billListViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
