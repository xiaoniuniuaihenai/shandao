//
//  ZTMXFChooseGoodsViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ShanDaoChooseGoodsViewController.h"
#import "ZTMXFLoanGoodsListCell.h"
#import "LSBorrwingCashInfoModel.h"
@interface ShanDaoChooseGoodsViewController ()

@end

@implementation ShanDaoChooseGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择商品";
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, k_Navigation_Bar_Height, KW, KH - k_Navigation_Bar_Height);
    self.tableView.backgroundColor = K_BackgroundColor;
    self.tableView.mj_header.hidden = YES;
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return X(75);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _goodsDtoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTMXFLoanGoodsListCell * loanGoodCell = [ZTMXFLoanGoodsListCell cellWithTableView:tableView];
    loanGoodCell.goodsInfoModel = _goodsDtoList[indexPath.section];
    //    loanGoodCell.chooseBtn.selected = loanGoodCell.goodsInfoModel.selected;
    @WeakObj(self);
    loanGoodCell.clickHandle = ^(ZTMXFLoanGoodsListCell *loanGoodsListCell) {
        [selfWeak refTableViewGoodsInfoModel:loanGoodsListCell.goodsInfoModel];
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                [self.navigationController popViewControllerAnimated:YES];
        if (_clickCell) {
            _clickCell(loanGoodsListCell.goodsInfoModel);
            [selfWeak cancelSelected:loanGoodsListCell.goodsInfoModel];
        }
        //            });
        //        });
        
    };
    return loanGoodCell;
}

- (void)refTableViewGoodsInfoModel:(GoodsInfoModel * )goodsInfoModel
{
    for (GoodsInfoModel * InfoModel in _goodsDtoList) {
        if (![InfoModel.goodsId isEqualToString:goodsInfoModel.goodsId]) {
            InfoModel.selected = NO;
        }
    }
    
    for (ZTMXFLoanGoodsListCell * cell in self.tableView.visibleCells) {
        if ([cell.goodsInfoModel.goodsId isEqualToString:goodsInfoModel.goodsId]) {
            cell.chooseBtn.selected = YES;
        }else{
            cell.chooseBtn.selected = NO;
        }
    }
}

- (void)cancelSelected:(GoodsInfoModel * )goodsInfoModel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    GoodsInfoModel * goodsInfoModel = _goodsDtoList[indexPath.section];
    webVC.webUrlStr = goodsInfoModel.descUrl;
    [self.navigationController pushViewController:webVC animated:YES];
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
