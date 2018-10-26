//
//  LSAlipayProofViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAlipayProofViewController.h"
#import "LSAlipayProofTableViewCell.h"

@interface LSAlipayProofViewController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** proofDataArray */
@property (nonatomic, strong) NSMutableArray    *proofDataArray;

@end

@implementation LSAlipayProofViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"还款凭证";
    [self addProofDataArray];
    [self configueSubViews];
}

//  添加凭证
- (void)addProofDataArray{
    self.proofDataArray = [NSMutableArray array];
    
    AlipayProofModel *proofFirst = [[AlipayProofModel alloc] init];
//    proofFirst.proofImageStr = @"alipay_proof_first";
    proofFirst.proofTitle = @"第1步";
    proofFirst.proofValue = @"支付宝还款后, 打开[我的]界面,点击[账单]";
    [self.proofDataArray addObject:proofFirst];
    
    AlipayProofModel *proofSecond = [[AlipayProofModel alloc] init];
//    proofSecond.proofImageStr = @"alipay_proof_second";
    proofSecond.proofTitle = @"第2步";
    proofSecond.proofValue = @"进入账单页面,\n点击该笔还款记录";
    [self.proofDataArray addObject:proofSecond];
    
    AlipayProofModel *proofThird = [[AlipayProofModel alloc] init];
//    proofThird.proofImageStr = @"alipay_proof_third";
    proofThird.proofTitle = @"第3步";
    proofThird.proofValue = @"截图保存账单详情至手机相册中,回到闪到APP上传凭证";
    [self.proofDataArray addObject:proofThird];

}

#pragma mark UITableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.proofDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSAlipayProofTableViewCell *cell = [LSAlipayProofTableViewCell cellWithTableView:tableView];
    AlipayProofModel *proofModel = self.proofDataArray[indexPath.row];
    cell.alipayProofModel = proofModel;    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
    
    UILabel *headerTitle = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
    headerTitle.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, 54.0);
    headerTitle.text = @"   去哪儿找还款凭证";
    self.tableView.tableHeaderView = headerTitle;
}

#pragma mark - getters and setters

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
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
