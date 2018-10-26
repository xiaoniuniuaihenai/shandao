//
//  XLChooseBankViewController.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFChooseBankViewController.h"
#import "PayChannelModel.h"
#import "PayChannelListApi.h"
#import "PayTypeTableViewCell.h"
#import "ZTMXFBankCardSigningApi.h"
@interface ZTMXFChooseBankViewController ()

@property (nonatomic, strong)UILabel * headerLabel;

@property (nonnull, copy)NSString * bankCardId;

@property (nonatomic, strong)UIView * whiteView;

@property (nonatomic, strong)UIButton * backBtn;

@property (nonatomic, strong)UIButton * addBankCardBtn;


@end

@implementation ZTMXFChooseBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, KH, KW, KH / 3 * 2)];
    _whiteView.backgroundColor = COLOR_SRT(@"d3d3d3");
    [self.view addSubview:_whiteView];
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KW, 60)];
    _headerLabel.text = @"选择支付方式";
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.backgroundColor = [UIColor whiteColor];
    [_whiteView addSubview:_headerLabel];
    [_whiteView addSubview:self.backBtn];
    [_whiteView addSubview:self.tableView];
    [_whiteView addSubview:self.addBankCardBtn];
    
    self.tableView.frame = CGRectMake(0, _headerLabel.bottom + 0.7, KW, _whiteView.height - _headerLabel.height - _addBankCardBtn.height);
    self.tableView.mj_header.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showTableView];
    });
    if (_showOfflinePay) {
        //  显示线下还款方式
        [self requestPayChannelListApiWithSourceType:@"1"];
    } else {
        //  不显示线下还款方式
        [self requestPayChannelListApiWithSourceType:@"0"];
    }
    
    // Do any additional setup after loading the view.
}

- (UIButton *)addBankCardBtn
{
    if (!_addBankCardBtn) {
        self.addBankCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBankCardBtn setTitleColor:K_2B91F0 forState:UIControlStateNormal];
        _addBankCardBtn.frame = CGRectMake(0, _whiteView.height - 60 * PX, KW, 60 * PX);
        [_addBankCardBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KW, 1)];
        lineView.backgroundColor = COLOR_SRT(@"E5E5E5");
        [_addBankCardBtn addSubview:lineView];
        [_addBankCardBtn addTarget:self action:@selector(addBankCardBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_addBankCardBtn setImage:[UIImage imageNamed:@"XL_FK_AddBankCard"] forState:UIControlStateNormal];
        _addBankCardBtn.backgroundColor = [UIColor whiteColor];
    }
    return _addBankCardBtn;
}

- (void)addBankCardBtnAction
{
    _bankCardId = @"-111";//添加银行卡
    [self httpBankCardSigningWithBankCardId:_bankCardId];
}

- (void)backBtnAction
{
    [self dismissTableView];
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(12, 0, 40, 60);
        [_backBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_backBtn setTitleColor:COLOR_SRT(@"8A8A8A") forState:UIControlStateNormal];
        _backBtn.titleLabel.font = FONT_Regular(14 * PX);
        //        [_backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

#pragma mark - 获取银行卡列表
- (void)requestPayChannelListApiWithSourceType:(NSString *)sourceType{
    if (!sourceType) {
        sourceType = @"0";
    }
    PayChannelListApi *channelApi = [[PayChannelListApi alloc] initWithSourceType:sourceType];
    [channelApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
            NSArray *dataArray = [PayChannelModel mj_objectArrayWithKeyValuesArray:dataDict[@"payChannelList"]];
            self.dataArray = [NSMutableArray arrayWithArray:dataArray];
            [self.tableView reloadData];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
- (void)setTitleStr:(NSString *)titleStr
{
    if (_titleStr != titleStr) {
        _titleStr = titleStr;
    }
    if (_titleStr) {
        self.headerLabel.text = _titleStr;
    }
}

- (void)dismissWithBankId:(NSString *)bankCardId
{
    if (bankCardId) {
        [self.view endEditing:YES];
        [UIView animateWithDuration:.3f animations:^{
            self.whiteView.frame = CGRectMake(0, KH, KW, KH / 3 * 2);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                if (self.delegate && [_delegate  respondsToSelector:@selector(chooseUseBankCardId:)]) {
                    [_delegate chooseUseBankCardId:_bankCardId];
                }
            }];
        }];
    }
}

- (void)httpBankCardSigningWithBankCardId:(NSString *)bankCardId
{
    NSInteger bankid = [bankCardId integerValue];
    MJWeakSelf
    if (bankid > 0) {
        self.view.userInteractionEnabled = NO;
        ZTMXFBankCardSigningApi * bankCardSigningApi = [[ZTMXFBankCardSigningApi alloc] initWithBankCardId:bankCardId amount:_amountStr bizCode:_bizCode borrowId:_borrowId];
        [bankCardSigningApi requestWithSuccess:^(NSDictionary *responseDict) {
            weakSelf.view.userInteractionEnabled = YES;
            NSString * code = [responseDict[@"code"] description];
            if ([code isEqualToString:@"1000"]) {
                NSDictionary * dic = responseDict[@"data"];
                [weakSelf bankCardSigningWithDic:dic];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            weakSelf.view.userInteractionEnabled = YES;
        }];
    }else{
        [weakSelf dismissWithBankId:bankCardId];
    }
}

- (void)bankCardSigningWithDic:(NSDictionary *)bankInfoDic
{
    //    [self pushSecurityPayVCWithBanKDic:bankInfoDic];
    if ([[bankInfoDic allKeys] containsObject:@"signingState"]) {
        BOOL signingState = [bankInfoDic[@"signingState"] boolValue];
        if (signingState) {
            [self dismissWithBankId:_bankCardId];
        }else{
            [self pushSecurityPayVCWithBanKDic:bankInfoDic];
        }
    }
}

- (void)pushSecurityPayVCWithBanKDic:(NSDictionary *)dic
{
    if (_bankCardId) {
        [self.view endEditing:YES];
        [UIView animateWithDuration:.3f animations:^{
            self.whiteView.frame = CGRectMake(0, KH, KW, KH / 3 * 2);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                if (self.delegate && [_delegate  respondsToSelector:@selector(chooseUseBankCardId:)]) {
                    [_delegate chooseUseBankCardId:_bankCardId bankInfoDic:dic];
                }
            }];
        }];
    }
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayChannelModel *_payChannelModel =(PayChannelModel *)self.dataArray[indexPath.row];
    if (_payChannelModel.isValid == 0) {
        return 70;
    } else {
        if (kStringIsEmpty(_payChannelModel.channelDesc)) {
            return 52;
        }else{
            return 70;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayTypeTableViewCell *cell = [PayTypeTableViewCell cellWithTableView:tableView];
    PayChannelModel *channelModel = self.dataArray[indexPath.row];
    cell.showSelectedImage = NO;
    cell.channelModel = channelModel;
    cell.showRowImage = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayChannelModel *channelModel = self.dataArray[indexPath.row];
    //判断选中的cell是否表示有效的银行卡或渠道
    if (channelModel.isValid == 0) {
        [self.view makeCenterToast:channelModel.inValidDesc];
        return;
    }
    self.bankCardId = channelModel.channelId;
    [self httpBankCardSigningWithBankCardId:_bankCardId];
    
}


- (void)tapAction
{
    [self dismissTableView];
}

- (void)dismissTableView
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3f animations:^{
        self.whiteView.frame = CGRectMake(0, KH, KW, KH / 3 * 2);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
        }];
    }];
}

- (void)showTableView
{
    [UIView animateWithDuration:.3f animations:^{
        self.whiteView.frame = CGRectMake(0, KH / 3, KW, KH / 3 * 2);
    }];
}

- (void)didReceiveMemoryWarning
{
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
