//
//  LSChoiseBankCardViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSChoiseBankCardViewController.h"
#import "BankCardListApi.h"
#import "BankCardListModel.h"
#import "OrderChoiseBankCardCell.h"
#import "RealNameManager.h"
#import "BankCardModel.h"
#import "LSIdfBindCardViewController.h"
#import "JBScanIdentityCardViewController.h"
@interface LSChoiseBankCardViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) BankCardListModel *bankCardListModel;
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** data Array */
@property (nonatomic, strong) NSMutableArray    *dataArray;

/** 选中indexpath */
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/** 选中银行卡Model */
@property (nonatomic, strong) BankCardModel *selectedBankCardModel;

@end

@implementation LSChoiseBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"银行卡管理";
    [self configueSubViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self bankCardList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark UITableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(80.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderChoiseBankCardCell *cell = [OrderChoiseBankCardCell cellWithTableView:tableView];
    BankCardModel *bankCardModel = self.dataArray[indexPath.row];
    cell.bankCardModel = bankCardModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BankCardModel *bankCardModel = self.dataArray[indexPath.row];
    
    if (bankCardModel && bankCardModel.isValid) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(choiseBankCardViewSelectBankCard:)]) {
            [self.delegate choiseBankCardViewSelectBankCard:bankCardModel];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 20.0)];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 80.0)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIButton *addBankButton = [UIButton setupButtonWithSuperView:bgView withObject:self action:@selector(addBankCardAction)];
    addBankButton.frame = CGRectMake(AdaptedWidth(24.0), 0.0, Main_Screen_Width - AdaptedWidth(24.0), CGRectGetHeight(bgView.frame));
    addBankButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [addBankButton setImage:[UIImage imageNamed:@"add_bank_card"] forState:UIControlStateNormal];

    UILabel *addLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
    addLabel.text = @"添加新银行卡";
    addLabel.frame = CGRectMake(AdaptedWidth(70.0), 0.0, 120.0, CGRectGetHeight(bgView.frame));
    [bgView addSubview:addLabel];
    
    UIImageView *rowImageView = [[UIImageView alloc] init];
    rowImageView.userInteractionEnabled = YES;
    rowImageView.contentMode = UIViewContentModeScaleAspectFit;
    rowImageView.image = [UIImage imageNamed:@"XL_common_right_arrow"];
    rowImageView.frame = CGRectMake(Main_Screen_Width - AdaptedWidth(28.0), 0.0, AdaptedWidth(8.0), CGRectGetHeight(bgView.frame));
    [bgView addSubview:rowImageView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    lineView.frame = CGRectMake(AdaptedWidth(20.0), CGRectGetHeight(bgView.frame) - 0.5, Main_Screen_Width - AdaptedWidth(20.0), 0.5);
    [bgView addSubview:lineView];
    
    return bgView;
}


#pragma mark - 添加银行卡
- (void)addBankCardAction{
    NSLog(@"添加银行卡");
    /** 人脸识别状态【0:未认证,-1:认证失败，1:已认证】 */
    NSInteger faceStatus = self.bankCardListModel.faceStatus;
    if (faceStatus != 1) {
//        if (self.loanType == MallPurchaseType) {
//            //  跳转到实名认证
//            [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES loanType:MallPurchaseType];
//        } else {
            //  跳转到实名认证
            JBScanIdentityCardViewController * idVc = [[JBScanIdentityCardViewController alloc]init];
            idVc.isAddBankCard = YES;
            [self.navigationController pushViewController:idVc animated:YES];
//            [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES];
//        }
    } else {
        //  跳转到绑卡
        if (self.bankCardListModel.bankCardList.count > 0) {
            //  添加副卡
            LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
            bankVc.isAddBankCard = YES;
            bankVc.bindCardType = RealNameProgressBindCard;
            [self.navigationController pushViewController:bankVc animated:YES];
//            [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCard isSaveBackVcName:YES];
        } else {
//            if (self.loanType == MallPurchaseType) {
//                //  添加主卡
//                [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES loanType:MallPurchaseType];
//            } else {
//                [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES];
                LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
                bankVc.isAddBankCard = YES;
                bankVc.bindCardType = RealNameProgressBindCardMian;
                [self.navigationController pushViewController:bankVc animated:YES];
//            }
        }
    }
    
}

#pragma mark - 接口请求
//  获取银行卡列表
- (void)bankCardList{
    BankCardListApi *bankCardApi = [[BankCardListApi alloc] init];
    if (kArrayIsEmpty(self.dataArray)) {
        [SVProgressHUD showLoading];
    }
    [bankCardApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.bankCardListModel = [BankCardListModel mj_objectWithKeyValues:dataDict];
            if (!kArrayIsEmpty(self.dataArray)) {
                [self.dataArray removeAllObjects];
            }
            
            if (self.bankCardListModel.bankCardList.count > 0) {
                [self.dataArray addObjectsFromArray:self.bankCardListModel.bankCardList];
            }
            [self.view configBlankPage:EaseBlankPageTypeNoBankList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
                [self addBankCardAction];
            }];
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
}


#pragma mark - getters and setters
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height - TabBar_Addition_Height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
