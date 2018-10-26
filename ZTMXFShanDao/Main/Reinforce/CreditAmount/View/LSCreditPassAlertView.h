//
//  LSCreditPassAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCreditPassAlertView : UIView

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (nonatomic, copy) NSString * awardMoney;

-(void)show;

@end
