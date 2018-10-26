//
//  LSIndustryViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFIndustryViewController.h"
#import "LSIndustryCell.h"

#define Identifier @"IndustryCell"

@interface ZTMXFIndustryViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *industryArray;

@end

@implementation ZTMXFIndustryViewController
K_Useless_Code


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.industryArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSIndustryCell *cell = [LSIndustryCell cellWithTableView:tableView];
    NSString *industry = [self.industryArray objectAtIndex:indexPath.row][@"industryName"];
    cell.industryTitle = industry;
    
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"选择行业"];
    [self set_Title:titleStr];
    
    [self configueSubViews];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"position" ofType:@"json"];
    NSString *industryStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //json数据转为字典
    NSData *jsonData = [industryStr dataUsingEncoding:NSUTF8StringEncoding];
    self.industryArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *titleStr = [self.industryArray objectAtIndex:indexPath.row][@"industryName"];
    if (self.delegete && [self.delegete respondsToSelector:@selector(chooseIndustry:)]) {
        
        [self.delegete chooseIndustry:titleStr];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.mainTableView];
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_mainTableView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.sectionHeaderHeight = 1;
        _mainTableView.sectionFooterHeight = 1;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
    
    }
    return _mainTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
