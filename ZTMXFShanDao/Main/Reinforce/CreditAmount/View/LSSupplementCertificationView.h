//
//  LSSupplementCertificationView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  补充认证页面

#import <UIKit/UIKit.h>

@interface LSSupplementCertificationView : UIView
@property (weak, nonatomic) IBOutlet UIView *viMainView;

@property (weak, nonatomic) IBOutlet UIButton *btnIconOne;
@property (weak, nonatomic) IBOutlet UIButton *btnIconTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnIconThree;

@property (weak, nonatomic) IBOutlet UILabel *lbRightOne;
@property (weak, nonatomic) IBOutlet UILabel *lbRightTwo;
@property (weak, nonatomic) IBOutlet UILabel *lbRightThree;

@property (weak, nonatomic) IBOutlet UIButton *btnCellOne;
@property (weak, nonatomic) IBOutlet UIButton *btnCellTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnCellThree;

@property (weak, nonatomic) IBOutlet UIView *viLineOne;
@property (weak, nonatomic) IBOutlet UIView *viLineTwo;
@property (weak, nonatomic) IBOutlet UIView *viLineThree;

@end
