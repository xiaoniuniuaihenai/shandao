//
//  XLNewLoanRenewalViewController.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/5/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLLoanRenewalViewController.h"
#import "XLLoanRenewalTopCell.h"
#import "XLLoanRenewalCenterCell.h"
#import "LSLoanRenewalViewModel.h"

@interface XLLoanRenewalViewController ()<UITableViewDelegate,UITableViewDataSource,LSLoanRenewalViewModelDelegate>
@property (nonatomic, strong) UILabel                *topDescribeLabel;
@property (nonatomic, strong) UITableView            *loanRenewalView;
@property (nonatomic, strong) NSMutableArray         *dataSource;
@property (nonatomic, strong) LSLoanRenewalViewModel *loanRenewalViewModel;

@end

@implementation XLLoanRenewalViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        _topDescribeLabel.alpha = 1;
        self.loanRenewalView.frame = CGRectMake(0.0, k_Navigation_Bar_Height + 36.0, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"延期还款";
    self.view.backgroundColor = K_BackgroundColor;
    [self.view addSubview:self.loanRenewalView];
    //  获取延期页面信息
    [self.loanRenewalViewModel requestLoanRenewalViewInfoWithBorrowId:self.borrowId loanType:self.loanType];
    self.fd_interactivePopDisabled = YES;
}

#pragma mark - 自定义代理方法
//  延期还款页面信息获取成功
- (void)requestLoanRenewalViewInfoSuccess:(LSBrwRenewalaInfoModel *)renewalInfoModel{
    if (renewalInfoModel) {
//        self.loanRenewalView.renewalInfoModel = renewalInfoModel;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 1?220:45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        if (indexPath.row == 1) {
            cell = [[XLLoanRenewalCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }else{
            cell = [[XLLoanRenewalTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValue:self.dataSource[indexPath.row] forKey:@"dict"];
    return cell;
}

- (UITableView *)loanRenewalView{
    return _loanRenewalView?:({
        _loanRenewalView = [[UITableView alloc]init];
        _loanRenewalView.delegate = self;
        _loanRenewalView.dataSource = self;
        _loanRenewalView.backgroundColor = K_BackgroundColor;
        _loanRenewalView.tableFooterView = [UIView new];
        _loanRenewalView.frame = self.view.frame;
        _loanRenewalView;
    });
}

- (UILabel *)topDescribeLabel{
    if (_topDescribeLabel == nil) {
        _topDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentCenter];
        _topDescribeLabel.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 36.0);
        _topDescribeLabel.alpha = 0;
        _topDescribeLabel.text = @"您必须还掉20%本金与延期手续费才能办理延期还款。";
        _topDescribeLabel.backgroundColor = [UIColor colorWithHexString:@"FFEAAB"];
    }
    return _topDescribeLabel;
}

- (NSMutableArray *)dataSource{
    return _dataSource?:({
        _dataSource = [NSMutableArray new];
        [_dataSource addObject:@{@"下次还款日期":@""}];
        [_dataSource addObject:@{@"还一部分(元)":@""}];
        [_dataSource addObject:@{@"延期天数":@""}];
        [_dataSource addObject:@{@"延期手续费":@""}];
        [_dataSource addObject:@{@"本次逾期费":@""}];
        _dataSource;
    });
}

- (LSLoanRenewalViewModel *)loanRenewalViewModel{
    if (_loanRenewalViewModel == nil) {
        _loanRenewalViewModel = [[LSLoanRenewalViewModel alloc] init];
        _loanRenewalViewModel.delegate = self;
    }
    return _loanRenewalViewModel;
}


@end
