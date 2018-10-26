//
//  LSMyCouponListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSMyCouponListViewController.h"
#import "CouponListApi.h"
#import "CounponModel.h"
#import "LSCouponListTableViewCell.h"
#import "LSCouponListTableViewCellNew.h"
#import "LSRepaymentCouponListApi.h"
#import "XLGetCouponListApi.h"

@interface LSMyCouponListViewController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
//@property (nonatomic, strong) UITableView       *tableView;
/** footer View */
@property (nonatomic, strong) UIView            *footerView;
/** Service Button*/
@property (nonatomic, strong) UIButton          *serviceButton;

/** 优惠券数组 */
//@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation LSMyCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券";
    
    [self configueSubViews];
    self.pageNum = 1;
    [self httpCouponList];
    
    
}

- (void)httpCouponList
{
    if (_couponType == RepaymentCouponListType) {
        //  还款优惠券
        [self repaymentCouponListWithPage:self.pageNum borrowId:self.borrowId repaymentAmount:self.repaymentAmount];
    }else if(_couponType == LoanCouponListType){
        [self loanCouponListWithAmount:self.amount];
    } else {
        //  我的优惠券
        if (![LoginManager appReviewState]) {
            [self couponListWithPage:self.pageNum];
        }else{
            //增加无数据展现
            [self.view configBlankPage:EaseBlankPageTypeNoCouponList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
            }];
        }
    }
}

/** 更多数据 150改为一次显示*/
- (void)moreData
{
    //    [self httpCouponList];
    
}
/** 刷新数据 */
- (void)refData
{
    self.pageNum = 1;
    [self httpCouponList];
    
}

#pragma mark UITableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSCouponListTableViewCellNew *cell = [LSCouponListTableViewCellNew cellWithTableView:tableView];
    CounponModel *couponModel = self.dataArray[indexPath.row];
    cell.isMine = self.couponType == MyCouponListType ? YES:NO;
    cell.couponModel = couponModel;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return X(122);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_couponType == RepaymentCouponListType || _couponType == LoanCouponListType) {
        CounponModel *couponModel = self.dataArray[indexPath.row];
        if (couponModel.status == 1) {
            //  还款优惠券
            if (self.delegate && [self.delegate respondsToSelector:@selector(couponListViewSelectCoupon:)]) {
                [self.delegate couponListViewSelectCoupon:couponModel];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}
#pragma mark - 接口请求
//  获取优惠券列表
- (void)couponListWithPage:(NSInteger)currentPage{
    CouponListApi *couponApi = [[CouponListApi alloc] initWithPage:currentPage];
    [SVProgressHUD showLoadingWithOutMask];
    @WeakObj(self);
    [couponApi requestWithSuccess:^(NSDictionary *responseDict) {
        if (self.pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        @StrongObj(self);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *couponArray = responseDict[@"data"][@"couponList"];
            if (couponArray.count > 0) {
                NSArray *couponModelArray = [CounponModel mj_objectArrayWithKeyValuesArray:couponArray];
                [self.dataArray addObjectsFromArray:couponModelArray];
            }
            self.pageNum++;
            [self endRef];
            //增加无数据展现
            [self.view configBlankPage:EaseBlankPageTypeNoCouponList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
            }];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

//  获取优惠券列表
- (void)repaymentCouponListWithPage:(NSInteger)currentPage borrowId:(NSString *)borrowId repaymentAmount:(NSString *)repaymentAmount{
    LSRepaymentCouponListApi *couponApi = [[LSRepaymentCouponListApi alloc] initWithBorrowId:borrowId repaymentAmount:repaymentAmount pageNum:currentPage];
    [SVProgressHUD showLoadingWithOutMask];
    @WeakObj(self);
    [couponApi requestWithSuccess:^(NSDictionary *responseDict) {
        if (self.pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        @StrongObj(self);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *couponArray = responseDict[@"data"][@"couponList"];
            if (couponArray.count > 0) {
                NSArray *couponModelArray = [CounponModel mj_objectArrayWithKeyValuesArray:couponArray];
                [self.dataArray addObjectsFromArray:couponModelArray];
            }
            self.pageNum++;
            [self endRef];
            //增加无数据展现
            [self.view configBlankPage:EaseBlankPageTypeNoCouponList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
            }];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
//借款券
- (void)loanCouponListWithAmount:(float)amount{
    XLGetCouponListApi *api = [[XLGetCouponListApi alloc]initWithAmount:amount];
    [SVProgressHUD showLoadingWithOutMask];
    @WeakObj(self);
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        if (self.pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        @StrongObj(self);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *couponArray = responseDict[@"data"][@"couponList"];
            if (couponArray.count > 0) {
                NSArray *couponModelArray = [CounponModel mj_objectArrayWithKeyValuesArray:couponArray];
                [self.dataArray addObjectsFromArray:couponModelArray];
            }
            self.pageNum++;
            [self endRef];
            //增加无数据展现
            [self.view configBlankPage:EaseBlankPageTypeNoCouponList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
            }];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 按钮点击事件
- (void)serviceButtonAction{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(serviceCenter);
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height);
    self.tableView.backgroundColor = K_BackgroundColor;
    
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
