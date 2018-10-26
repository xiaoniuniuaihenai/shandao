//
//  LSPositionViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPositionViewController.h"
#import "PFDropMenuView.h"

@interface ZTMXFPositionViewController () <PFDropMenuViewDataSource,PFDropMenuViewDelegate>

@property (nonatomic, strong) NSArray *industryArray;

@property (nonatomic, strong) NSArray *tradeArray;

@property (nonatomic, strong) NSArray *positionArray;

@property (nonatomic, strong) PFDropMenuView *industryView;

@end

@implementation ZTMXFPositionViewController



#pragma mark - setter
- (void)getIndustryData{
    
    _industryArray = [NSArray array];
    _tradeArray = [NSArray array];
    _positionArray = [NSArray array];
    
    //得到融资列表的字典
    NSString *path = [[NSBundle mainBundle] pathForResource:@"position" ofType:@"json"];
    NSString *industryStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //json数据转为字典
    NSData *jsonData = [industryStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *industryArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    _industryArray = industryArray;
}

#pragma mark - WSDropMenuView DataSource -
- (NSInteger)dropMenuView:(PFDropMenuView *)dropMenuView numberWithIndexPath:(PFIndexPath *)indexPath{
    
    //WSIndexPath 类里面有注释
    
    if (indexPath.row == WSNoFound) {
        
        return _industryArray.count;
    }
    if (indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        NSArray *tradeAry = [_industryArray objectAtIndex:indexPath.row][@"jobs"];
        return tradeAry.count;
    }
    
    if (indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        NSArray *positionAry = [_industryArray objectAtIndex:indexPath.row][@"jobs"][indexPath.item][@"positions"];
        return positionAry.count;
    }
    
    return 0;
}

- (NSString *)dropMenuView:(PFDropMenuView *)dropMenuView titleWithIndexPath:(PFIndexPath *)indexPath{
    
    //return [NSString stringWithFormat:@"%ld",indexPath.row];
    
    // 第一级
    if (indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        NSString *industry = [_industryArray objectAtIndex:indexPath.row][@"industryName"];
        return industry;
    }
    // 第二级
    if (indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        NSString *trade = [_industryArray objectAtIndex:indexPath.row][@"jobs"][indexPath.item][@"jobName"];
        return trade;
    }
    // 第三级
    if (indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank != WSNoFound) {
        NSString *position = [_industryArray objectAtIndex:indexPath.row][@"jobs"][indexPath.item][@"positions"][indexPath.rank][@"positionName"];
        return position;
    }
    
    return @"";
}

#pragma mark - WSDropMenuView Delegate -
- (void)dropMenuView:(PFDropMenuView *)dropMenuView didSelectWithIndexPath:(PFIndexPath *)indexPath title:(NSString *)title{
    if (self.delegete && [self.delegete respondsToSelector:@selector(choosePosition:)]) {
        [self.delegete choosePosition:title];
    }
    // 返回到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"选择岗位"];
    [self set_Title:titleStr];
    
    [self configueSubViews];
    
    [self getIndustryData];
}
#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.industryView = [[PFDropMenuView alloc] initWithFrame:CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height)];
    _industryView.industryName = self.industryName;
    _industryView.dataSource = self;
    _industryView.delegate  =self;
    [self.view addSubview:self.industryView];
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
