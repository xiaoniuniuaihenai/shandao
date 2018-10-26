//
//  LSAlertCreditPaidView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  慢必赔

#import <UIKit/UIKit.h>

@interface LSAlertCreditPaidView : UIView
@property (weak, nonatomic) IBOutlet UIView *viMainView;
@property (weak, nonatomic) IBOutlet UILabel *lbContentLb;

@property (weak, nonatomic) IBOutlet UIButton *btnHideBtn;

-(void)show;
-(void)hidden;
@end
