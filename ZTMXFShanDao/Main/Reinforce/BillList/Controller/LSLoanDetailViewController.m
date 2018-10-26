//
//  LSLoanDetailViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanDetailViewController.h"
#import "ALATitleValueTableViewCell.h"
#import "LSLoanRenewalViewController.h"
#import "LoanDetailApi.h"
#import "ALABorrowDetailManager.h"
#import "LSLoanDetailModel.h"
#import "LSRepaymentListViewController.h"
#import "LSLoanRepayViewController.h"
#import "LSRenewListViewController.h"
#import "LSWebViewController.h"
#import "LSLoanDetailHeaderView.h"
#import "NTalkerChatViewController.h"
#import "NTalker.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "LSReminderButton.h"
#import "XNSDKCore.h"
#import "RealNameManager.h"
#import "AlertSheetActionManager.h"
@interface LSLoanDetailViewController ()<UITableViewDelegate, UITableViewDataSource, LoanDetailHeaderViewDelegate>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 客服按钮 */
@property (nonatomic, strong) LSReminderButton *customerServiceButton;
/** 借款详情状态view */
@property (nonatomic, strong) LSLoanDetailHeaderView *loanDetailHeaderView;
/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 借钱详情Model */
@property (nonatomic, strong) LSLoanDetailModel *loanDetailModel;

@property(nonatomic, strong)XLButton * payBtn;

@end

@implementation LSLoanDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"借款详情";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xNTalkerUnreadMsg) name:NOTIFINAME_XN_UNREADMESSAGE object:nil];
    [self configueSubViews];
}




- (LSReminderButton *)customerServiceButton{
    if (_customerServiceButton == nil) {
        _customerServiceButton = [LSReminderButton buttonWithType:UIButtonTypeCustom];
        _customerServiceButton.frame = CGRectMake(0.0,Status_Bar_Height, 40.0, 44.0);
    }
    return _customerServiceButton;
}

//  小能未读消息
- (void)xNTalkerUnreadMsg{
    [self.customerServiceButton showReminderCount:@"1"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super viewWillAppear:animated];
    [self boneDetailWithBorrowId:self.borrowId];
    
    //  小能客服未读消息提示
    NSMutableArray *chatListArray = [[XNSDKCore sharedInstance] chatListMessagFromDB];
    if (chatListArray.count > 0) {
        NSDictionary *infoDict = chatListArray[0];
        NSInteger unreadMessage = [infoDict[@"unreadMsgNum"] integerValue];
        if (unreadMessage > 0) {
            [self.customerServiceButton showRedReminderCount:[NSString stringWithFormat:@"%ld", unreadMessage]];
        } else {
            [self.customerServiceButton showRedReminderCount:@"0"];
        }
    }
}

- (void)customerServiceButtonAction:(UIButton *)sender{
    NSLog(@"点击客服");
    NTalkerChatViewController *chat = [[NTalker standardIntegration] startChatWithSettingId:kXNSettingId];
    chat.pushOrPresent = YES;
    chat.isHaveVoice = NO;
    [self.navigationController pushViewController:chat animated:YES];
}
- (void)setNavgationRightButtonWithImageStr:(NSString *)imageStr{
    self.navigationItem.rightBarButtonItem = nil;
    UIImage *rightImage = [UIImage imageNamed:imageStr];
    if (rightImage) {
        [self.customerServiceButton setImage:rightImage forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.customerServiceButton];
        self.navigationItem.rightBarButtonItem = item;
    }
}


#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50.0;
    } else {
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALATitleValueTableViewCell *cell = [ALATitleValueTableViewCell cellWithTableView:tableView];
    NSDictionary *cellDict = self.dataArray[indexPath.section][indexPath.row];
    cell.titleLabel.text = cellDict[kTitleValueCellManagerKey];
    cell.valueLabel.text = cellDict[kTitleValueCellManagerValue];
    cell.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    cell.bottomLineView.hidden = YES;
    if (indexPath.section == 0) {
        cell.dashImageView.hidden = YES;
        cell.titleLabel.textColor = K_888888;
        cell.valueLabel.textColor = K_333333;
        cell.titleLabel.font = FONT_Regular(15 * PX);
        cell.valueLabel.font = FONT_Regular(15 * PX);
        cell.valueLabel.textAlignment = NSTextAlignmentRight;
        if ([self.dataArray[0] count] == indexPath.row + 1) {
            cell.bottomLineView.hidden = NO;
        }
        
    } else {
        cell.dashImageView.hidden = YES;
        cell.titleLabel.textColor = K_888888;
        cell.valueLabel.textColor = K_888888;
        cell.titleLabel.font = FONT_Regular(15 * PX);
        cell.valueLabel.font = FONT_Regular(15 * PX);
        cell.valueLabel.textAlignment = NSTextAlignmentRight;
    }

    if ([cell.titleLabel.text isEqualToString:@"还款记录"] || [cell.titleLabel.text isEqualToString:@"借款编号"] || [cell.titleLabel.text isEqualToString:@"延期还款记录"]) {
        cell.showRowImageView = YES;
    } else {
        cell.showRowImageView = NO;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"XL_loan_detail_center"];
        imageView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width - 30.0, 20.0);
        return imageView;
    } else {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellDict = self.dataArray[indexPath.section][indexPath.row];
    NSString *keyTitle = cellDict[kTitleValueCellManagerKey];
    if ([keyTitle isEqualToString:@"还款记录"]) {
        //  还款列表
        LSRepaymentListViewController *loanListVC = [[LSRepaymentListViewController alloc] init];
        loanListVC.borrowId = self.borrowId;
        [self.navigationController pushViewController:loanListVC animated:YES];
    } else if ([keyTitle isEqualToString:@"借款编号"]) {
        NSString *borrowAmount = [NSString stringWithFormat:@"%.2f",self.loanDetailModel.amount];
        NSArray * arrActionTitle = @[@"《闪到借款协议》",@"《委托融资协议》"];
        MJWeakSelf
        [AlertSheetActionManager sheetActionTitle:@"协议" message:nil arrTitleAction:arrActionTitle superVc:self blockClick:^(NSInteger index) {
            NSString * webUrl = @"";
                if (index==0) {
                    webUrl = DefineUrlString(personalCashProtocol([LoginManager userPhone], weakSelf.borrowId, borrowAmount, @"",@""));
                }else{
                    webUrl = DefineUrlString(entrustBorrowCashProtocol(weakSelf.borrowId,borrowAmount,@"2"));
                }
            LSWebViewController *borrowNumVC = [[LSWebViewController alloc] init];
            borrowNumVC.webUrlStr = webUrl;
            [weakSelf.navigationController pushViewController:borrowNumVC animated:YES];
         }];
    } else if ([keyTitle isEqualToString:@"延期还款记录"]){
        LSRenewListViewController *renewListVC = [[LSRenewListViewController alloc] init];
        renewListVC.borrowId = self.borrowId;
        [self.navigationController pushViewController:renewListVC animated:YES];
    }
}

#pragma mark - LoanDetailHeaderViewDelegate


- (void)boneDetailHeaderViewClickRepayment{
    //  点击还款
    LSLoanRepayViewController *repayVC = [[LSLoanRepayViewController alloc] init];
    repayVC.repayAmount = self.loanDetailModel.returnAmount;
    repayVC.borrowId = self.loanDetailModel.rid;
    if (self.loanDetailModel.borrowType == 1) {
        repayVC.loanType = CashLoanType;
    } else {
        repayVC.loanType = ConsumeLoanType;
    }
    [self.navigationController pushViewController:repayVC animated:YES];
}

- (void)boneDetailHeaderViewClickRenew{
    //  点击延期还款
    LSLoanRenewalViewController *renewalVC = [[LSLoanRenewalViewController alloc] init];
    renewalVC.borrowId = self.borrowId;
    renewalVC.repaymentAmount = self.loanDetailModel.noReturnAmount;
    if (self.loanDetailModel.borrowType == 1) {
        renewalVC.loanType = CashLoanType;
    } else {
        renewalVC.loanType = ConsumeLoanType;
    }
    [self.navigationController pushViewController:renewalVC animated:YES];
}
- (void)boneDetailHeaderViewClickPromoteAmount{
    //  提升额度
    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressCreditPromote isSaveBackVcName:YES];
}


#pragma mark - 接口请求
//  获取借钱详情
- (void)boneDetailWithBorrowId:(NSString *)borrowId{
    LoanDetailApi *api = [[LoanDetailApi alloc] initWithBorrowId:borrowId];
    if (!self.loanDetailModel) {
        [SVProgressHUD showLoading];
    }
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.loanDetailModel = [LSLoanDetailModel mj_objectWithKeyValues:dataDict];
            //  设置页面数据
            self.loanDetailHeaderView.loanDetailModel = self.loanDetailModel;
            //  设置tableHeaderView的frame
            [self setupTableHeaderView];
            
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
            self.dataArray = [ALABorrowDetailManager manageRenewDetailModel:self.loanDetailModel];
            [self.tableView reloadData];

        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

//  设置tableHeaderView
- (void)setupTableHeaderView
{
    CGRect newFrame = self.loanDetailHeaderView.frame;
    newFrame.size.height = self.loanDetailHeaderView.size.height;
    self.loanDetailHeaderView.frame = newFrame;
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:self.loanDetailHeaderView];
    [self.tableView endUpdates];    
    if (_loanDetailModel.status == 5 || _loanDetailModel.status == 7) {
        if (self.loanDetailModel.renewalStatus == 2) {
            _payBtn.hidden = YES;
            _payBtn.userInteractionEnabled = NO;
            self.tableView.frame = self.view.bounds;
        }else{
            _payBtn.hidden = NO;
            _payBtn.userInteractionEnabled = YES;
            self.tableView.frame = CGRectMake(0, 0, KW, KH - 84 * PX);
        }
    }else{
        _payBtn.hidden = YES;
        _payBtn.userInteractionEnabled = NO;
        self.tableView.frame = self.view.bounds;
    }
}

- (LSLoanDetailHeaderView *)loanDetailHeaderView{
    if (_loanDetailHeaderView == nil) {
        _loanDetailHeaderView = [[LSLoanDetailHeaderView alloc] init];
        _loanDetailHeaderView.delegate = self;
    }
    return _loanDetailHeaderView;
}

#pragma mark - configuSubViews
- (void)configueSubViews{

    //  添加TableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.clipsToBounds = YES;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    
    _payBtn = [XLButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame = CGRectMake(20, KH - 64 * PX, KW - 40, 44 * PX);
    [self.view addSubview:_payBtn];
    _payBtn.hidden = YES;
    _payBtn.userInteractionEnabled = NO;
    [_payBtn setTitle:@"立即还款" forState:UIControlStateNormal];
    [_payBtn addTarget:self action:@selector(boneDetailHeaderViewClickRepayment) forControlEvents:UIControlEventTouchUpInside];
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
