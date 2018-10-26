//
//  LSIdCardTypeListViewController.m
//  ALAFanBei
//
//  Created by Try on 2017/3/1.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "LSIdCardTypeListViewController.h"
#import "LSBankCardTypeModel.h"
#import "LSIdCardTypeCell.h"
#import "LSBankCardListTypeApi.h"
@interface LSIdCardTypeListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * arrDataList;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation LSIdCardTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"银行列表"];
    [self set_Title:titleStr];
    
    _selectIndex = -1;
    [self setupSubview];
    [SVProgressHUD showLoading];
//    获取数据
    LSBankCardListTypeApi * bankListApi = [[LSBankCardListTypeApi alloc]init];
    [bankListApi requestWithSuccess:^(NSDictionary *responseDict) {
    NSLog(@"获取银行卡列表的返回数据 %@",responseDict);
    NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            self.arrDataList = [LSBankCardTypeModel mj_objectArrayWithKeyValuesArray:dicData[@"bankList"]];
            [_tableView reloadData];
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
#pragma mark-  原生代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrDataList count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSIdCardTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IdBankTypeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cardTypeModel = _arrDataList[indexPath.row];
    cell.isSelect = _selectIndex == indexPath.row?YES:NO;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSBankCardTypeModel * cardTypeModel = _arrDataList[indexPath.row];
    if (cardTypeModel.isValid != YES) {
        return;
    }
    if (_selectIndex!=-1) {
        LSIdCardTypeCell * oldCell = [tableView cellForRowAtIndexPath:    [NSIndexPath indexPathForRow:_selectIndex inSection:0]];
        oldCell.isSelect = NO;
    }
    _selectIndex = indexPath.row;
    LSIdCardTypeCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelect = YES;
    if ([_delegate respondsToSelector:@selector(didSelecteBankCardTypeWith:)]) {
        
        [_delegate didSelecteBankCardTypeWith:cardTypeModel];
        self.view.userInteractionEnabled = NO;
        [self performSelector:@selector(delayBack) withObject:self afterDelay:.5];
    }
}
//延迟返回
-(void)delayBack{
    self.view.userInteractionEnabled = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-  自定义代理

#pragma mark-  按钮方法
#pragma mark-  私有方法

#pragma mark - 添加子视图
-(void)setupSubview{
    [self.view addSubview:self.tableView];
}
#pragma mark - 设置子视图


-(void)setArrDataList:(NSMutableArray *)arrDataList{
    _arrDataList = arrDataList;
    if (_oldBankTypeModel) {
        for (int i = 0; i <[_arrDataList count]; i++) {
            LSBankCardTypeModel * obj = _arrDataList[i];
            if ([obj.bankCode isEqualToString:_oldBankTypeModel.bankCode]) {
                _selectIndex = i;
                break;
            }
        }
    }
}
-(UITableView*)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView * viHead = [[UIView alloc]init];
        viHead.height = .001;
        _tableView.tableHeaderView = viHead;
        _tableView.sectionHeaderHeight = .0001;
        _tableView.sectionFooterHeight = 0.001;
        
        UINib * nib = [UINib nibWithNibName:@"LSIdCardTypeCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"IdBankTypeCell"];
    }
    return _tableView;
}
@end
