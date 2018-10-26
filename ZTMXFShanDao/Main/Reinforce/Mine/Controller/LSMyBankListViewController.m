//
//  LSMyBankListViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  我的银行卡列表
//
#import "LSMyBankListViewController.h"
#import "BankCardListApi.h"
#import "BankCardListModel.h"
#import "LSBankCardTableViewCell.h"
#import "UIView+instance.h"
#import "DeleteBankCardApi.h"
#import "PasswordPopupView.h"
#import "RealNameManager.h"
#import "BankCardModel.h"
#import "JBScanIdentityCardViewController.h"
#import "LSIdfBindCardViewController.h"
#import "ZTMXFReplaceMainCardApi.h"
//#import <TKAlertViewController.h>
@interface LSMyBankListViewController ()<UITableViewDelegate, UITableViewDataSource, BankCardTableViewCellDelegate,PasswordPopupViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) BankCardListModel *bankCardListModel;
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** data Array */
@property (nonatomic, strong) NSMutableArray    *dataArray;

/** 选中indexpath */
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/** 选中银行卡Model */
@property (nonatomic, strong) BankCardModel *selectedBankCardModel;
/** 点击的cellID */
@property (nonatomic, assign) int seletedIndex;

@end

@implementation LSMyBankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"银行卡管理";
    self.seletedIndex = -1;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSBankCardTableViewCell *cell = [LSBankCardTableViewCell cellWithTableView:tableView];
    cell.delegate = self;
    
    BankCardModel *bankCardModel = self.dataArray[indexPath.row];
    cell.bankCardModel = bankCardModel;
    NSInteger remainder = indexPath.row % 3;
    cell.bgImageView.contentMode = UIViewContentModeScaleToFill;
    if (remainder == 0) {
        //        蓝
        [cell.bgImageView setImage:[UIImage imageNamed:@"bankBgOne"]];
    } else if (remainder == 1) {
        //        黄
        [cell.bgImageView setImage:[UIImage imageNamed:@"bankBgTwo"]];
    } else {
        //        红
        [cell.bgImageView setImage:[UIImage imageNamed:@"bankBgThree"]];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 20.0)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.dataArray == 0) {
        return 0.01;
    }
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //    return nil;
    //    NSLog(@"self.dataArray.count   ===  %ld", self.dataArray.count);
    if (self.dataArray.count == 0) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 100.0)];
    bgView.backgroundColor = [UIColor clearColor];
    UIView *dashView = [[UIView alloc] initWithFrame:CGRectMake(12.5,.0, Main_Screen_Width - 25.0,100.0)];
    [dashView setBackgroundColor:[UIColor whiteColor]];
    [dashView.layer setCornerRadius:6];
    [bgView addSubview:dashView];
    
    UILabel *addLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentCenter];
    addLabel.text = @"添加银行卡";
    addLabel.frame = CGRectMake(0.0, 60.0, CGRectGetWidth(dashView.frame), 20.0);
    [dashView addSubview:addLabel];
    
    UIButton *addBankButton = [UIButton setupButtonWithSuperView:dashView withObject:self action:@selector(addBankCardAction)];
    addBankButton.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(dashView.frame), 68.0);
    [addBankButton setImage:[UIImage imageNamed:@"bankCardAdd"] forState:UIControlStateNormal];
    //
    return bgView;
}

#pragma mark - 删除银行卡代理方法
- (void)bankCardTableViewCellDeleteBankCard:(LSBankCardTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.selectedIndexPath = indexPath;
    self.selectedBankCardModel = self.dataArray[indexPath.row];
    if (indexPath.row < self.dataArray.count) {
        self.seletedIndex = (int)indexPath.row;
        
        UIAlertController *alertController = [[UIAlertController alloc]init];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"设为主卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self replaceMainCard];
        }];
        [alertController addAction:action1];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除银行卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteCard];
        }];
        [alertController addAction:action2];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action3];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (void)replaceMainCard{
    if (self.seletedIndex < 0 || self.seletedIndex > self.dataArray.count - 1) {
        return;
    }
    [SVProgressHUD showLoading];
    ZTMXFReplaceMainCardApi *replaceMainCardApi = [[ZTMXFReplaceMainCardApi alloc]initWithCardRid:[self.dataArray[self.seletedIndex] rid]];
    [replaceMainCardApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *code = [responseDict[@"code"] description];
        if ([code isEqualToString:@"1000"]) {
            [kKeyWindow makeCenterToast:[responseDict[@"msg"] description]];
            [self bankCardList];
        }else{
            [kKeyWindow makeCenterToast:[responseDict[@"msg"] description]];
            return ;
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
    
}

- (void)deleteCard{
    if (self.seletedIndex < 0 || self.seletedIndex > self.dataArray.count - 1) {
        return;
    }
    //  弹出密码框
    PasswordPopupView *passwordPopupView = [PasswordPopupView popupPasswordBoxView];
    passwordPopupView.delegate = self;
}

#pragma mark - 密码框代理方法
- (void)passwordPopupViewEnterPassword:(NSString *)password{
    //  提现
    [self requestDeleteBankCardApiWithBankId:self.selectedBankCardModel.rid password:password];
}

- (void)passwordPopupViewForgetPassword{
    [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
}

#pragma mark - 添加银行卡
- (void)addBankCardAction{
    //    NSLog(@"添加银行卡");
    /** 人脸识别状态【0:未认证,-1:认证失败，1:已认证】 */
    NSInteger faceStatus = self.bankCardListModel.faceStatus;
    if (faceStatus != 1) {
        
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"\n\n请先通过人脸识别添加主卡，\n以保障资金安全\n\n" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.view configBlankPage:EaseBlankPageTypeNoBankList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
                [self addBankCardAction];
            }];
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JBScanIdentityCardViewController * idVc = [[JBScanIdentityCardViewController alloc] init];
            idVc.isAddBankCard = YES;
            [self.navigationController pushViewController:idVc animated:YES];
        }];
        [alert addAction:action1];
        [action1 setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
        
        [alert addAction:action2];
        [action2 setValue:COLOR_SRT(@"2B91F0") forKey:@"titleTextColor"];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        //        TKAlertViewController *alert = [TKAlertViewController alertWithTitle:@"" message:@"\n\n请先通过人脸识别添加主卡，\n以保障资金安全\n\n"];
        //        alert.backgroundColor = [UIColor whiteColor];
        //        [alert addCancelButtonWithTitle:@"取消" block:^(NSUInteger index) {
        //            [self.view configBlankPage:EaseBlankPageTypeNoBankList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
        //                [self addBankCardAction];
        //            }];
        //        }];
        //        [alert setTitleColor:K_2B91F0 forButton:TKAlertViewButtonTypeDestructive];
        //        [alert addDestructiveButtonWithTitle:@"确认" block:^(NSUInteger index) {
        //            //  跳转到实名认证
        //            JBScanIdentityCardViewController * idVc = [[JBScanIdentityCardViewController alloc] init];
        //            idVc.isAddBankCard = YES;
        //            [self.navigationController pushViewController:idVc animated:YES];
        //        }];
        //        alert.dismissWhenTapWindow = NO;
        //        [alert showWithAnimationType:TKAlertViewAnimationDropDown];
        
    } else {
        //  跳转到绑卡
        LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
        if (self.bankCardListModel.bankCardList.count > 0) {
            //  添加副卡
            bankVc.bindCardType = RealNameProgressBindCard;
        } else {
            bankVc.bindCardType = RealNameProgressBindCardMian;
            //  添加主卡
        }
        bankVc.isAddBankCard = YES;
        [self.navigationController pushViewController:bankVc animated:YES];
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

//  删除银行卡
- (void)requestDeleteBankCardApiWithBankId:(NSString *)bankId password:(NSString *)password{
    DeleteBankCardApi *api = [[DeleteBankCardApi alloc] initWithBankId:bankId password:password];
    [SVProgressHUD showLoading];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            if (self.dataArray.count > self.selectedIndexPath.row) {
                [self.view makeCenterToast:@"删除银行卡成功"];
                [self.dataArray removeObjectAtIndex:self.selectedIndexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
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
        _tableView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
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
