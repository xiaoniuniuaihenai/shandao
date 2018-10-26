//
//  ZTMXFCardDefaultViewController.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/3/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCardDefaultViewController.h"

@interface ZTMXFCardDefaultViewController ()

@end

@implementation ZTMXFCardDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];

    

    // Do any additional setup after loading the view.
}



#pragma mark - Super Detect Result


- (void)cancelIDCardDetect{
    [super cancelIDCardDetect];
    
    if (self && self.errorBlcok) {
        self.errorBlcok(MGIDCardErrorCancel);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatView
{
    [super creatView];
    self.boxLayer.isQualified = YES;
}

- (void)detectSucess:(MGIDCardQualityResult *)result{
    [super detectSucess:result];
    
    MGIDCardModel *model = [[MGIDCardModel alloc] initWithResult:result];
    if (self && self.finishBlock){
        self.finishBlock(model);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
