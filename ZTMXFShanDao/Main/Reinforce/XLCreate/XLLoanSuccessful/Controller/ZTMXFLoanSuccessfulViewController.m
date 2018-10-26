//
//  XLPayResultsViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/21.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanSuccessfulViewController.h"
#import "ZTMXFLoanSuccessfulView.h"
@interface ZTMXFLoanSuccessfulViewController ()

@property (nonatomic, strong)ZTMXFLoanSuccessfulView * loanSuccessfulView;

@end

@implementation ZTMXFLoanSuccessfulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.mj_header.hidden = YES;
    
    _loanSuccessfulView = [[ZTMXFLoanSuccessfulView alloc] initWithFrame:CGRectMake(0, 0, KW, 213 * PX)];
    self.tableView.tableHeaderView = _loanSuccessfulView;
  
    
    
    
    
    
    
    // Do any additional setup after loading the view.
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
