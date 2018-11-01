//
//  ZTMXFCertificationCenterViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationCenterViewController.h"
#import "LSCreditAuthApi.h"
#import "LSCreditAuthModel.h"
#import "LSCreditAmountHeaderView.h"
#import "LSCreditWithOutLoginApi.h"
#import "ZTMXFCertificationCenterCell.h"
#import "ZTMXFCertificationStatusModel.h"
#import "ZTMXFCertificationHelper.h"
#import "ZTMXFCertificationHeaderView.h"
#import "LSSubmitAuthViewController.h"
#import "ZTMXFCertificationListViewController.h"
#import "LSCreditAuthWebViewController.h"
@interface ZTMXFCertificationCenterViewController ()

@property (nonatomic, strong)LSCreditAuthModel *creditAuthModel;

@property (nonatomic, strong) ZTMXFCertificationHeaderView *headerView;

@end

@implementation ZTMXFCertificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的认证";
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = UIColor.whiteColor;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
//    self.tableView.separatorColor = K_LineColor;
    self.tableView.rowHeight = X(100);
    self.tableView.mj_header.hidden = YES;
    self.tableView.frame = CGRectMake(0, k_Navigation_Bar_Height, KW, KH - k_Navigation_Bar_Height);
    _headerView = [[ZTMXFCertificationHeaderView alloc] initWithFrame:CGRectMake(0.0, 0, Main_Screen_Width, 185 * PX)];
    _headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
    if ([LoginManager loginState]) {
        //  登陆了获取数据
        [self requestCreditAuthStatus];
    } else {
        // 获取未登录认证状信息
        [self requestCreditAuthInfoWithOutLogin];
    }
    // Do any additional setup after loading the view.
}

- (void)updateAuthHeaderView
{
    self.headerView.creditAuthModel = _creditAuthModel;
    [self.tableView reloadData];
}




/** 获取认证状态信息 */
- (void)requestCreditAuthStatus
{
    @WeakObj(self);
    LSCreditAuthApi *creditAuthApi = [[LSCreditAuthApi alloc] init];
    [creditAuthApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            [selfWeak.dataArray removeAllObjects];
            selfWeak.creditAuthModel = [LSCreditAuthModel mj_objectWithKeyValues:responseDict[@"data"]];
            ZTMXFCertificationStatusModel * riskModel = [[ZTMXFCertificationStatusModel alloc] init];
            riskModel.certificationName = @"消费贷认证";
            riskModel.certificationStatus = _creditAuthModel.riskStatus;
            riskModel.iconStr = @"XL_XiaoFeiDai";
            riskModel.detailsStr = @"解您燃眉之急";
            [selfWeak.dataArray addObject:riskModel];
            
            ZTMXFCertificationStatusModel * mallModel = [[ZTMXFCertificationStatusModel alloc] init];
            mallModel.certificationName = @"消费分期认证";
            mallModel.iconStr = @"XL_XiaoFeiFenQi";
            mallModel.detailsStr = @"分期购物我帮您";
            mallModel.certificationStatus = _creditAuthModel.mallStatus;
            [selfWeak.dataArray addObject:mallModel];
            [selfWeak updateAuthHeaderView];

        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

/** 获取未登录认证信息 */
- (void)requestCreditAuthInfoWithOutLogin
{
    @WeakObj(self);
    LSCreditWithOutLoginApi *creditWithOutLoginApi = [[LSCreditWithOutLoginApi alloc] init];
    [creditWithOutLoginApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            selfWeak.creditAuthModel = [LSCreditAuthModel mj_objectWithKeyValues:responseDict[@"data"]];
            selfWeak.creditAuthModel.ballAllNum = _creditAuthModel.ballNum;
            //  未登录状态可用和总额保持一致
           
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([LoginManager loginState]) {
        //  登陆了获取数据
        [self requestCreditAuthStatus];
    } else {
        // 获取未登录认证状信息
        [self requestCreditAuthInfoWithOutLogin];
    }
}
#pragma mark -  TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellstr = @"ZTMXFCertificationCenterCell";
    ZTMXFCertificationCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (!cell) {
        cell = [[ZTMXFCertificationCenterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellstr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row + 1 == self.dataArray.count) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
    }
    cell.certificationStatusModel = self.dataArray[indexPath.row];
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KW, 5)];
//    view.backgroundColor = UIColor.clearColor;
//    return view;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd" OtherDict:nil];
    if (![LoginManager loginState]) {
        [LoginManager presentLoginVCWithController:self];
    }else{
        
        ZTMXFCertificationStatusModel * model = self.dataArray[indexPath.row];
        if ([model.certificationName isEqualToString:@"消费贷认证"]) {
            [ZTMXFCertificationHelper certificationPageJumpWithVC:self periodAuthType:ConsumeLoanType];
        }else if ([model.certificationName isEqualToString:@"消费分期认证"]){
            [ZTMXFCertificationHelper certificationPageJumpWithVC:self periodAuthType:MallLoanType];
        }
    }
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
