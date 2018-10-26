//
//  LSMessageInfoViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMessageInfoViewController.h"

@interface ZTMXFMessageInfoViewController ()
@property (nonatomic,strong) UITextView * textView;
@end

@implementation ZTMXFMessageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _navTitle.length>0?_navTitle:@"消息详情";
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    _textView = [[UITextView alloc]init];
    [_textView setFrame:CGRectMake(0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height- k_Navigation_Bar_Height)];
    [_textView setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
    _textView.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    _textView.showsHorizontalScrollIndicator = YES;
    _textView.text = _messageStr;
    _textView.userInteractionEnabled = NO;
    [self.view addSubview:_textView];
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
