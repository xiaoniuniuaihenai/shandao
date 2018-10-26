//
//  LSBasicsCertificationView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBasicsBottomView.h"
@interface LSBasicsCertificationView : UIView
//基础认证
@property (weak, nonatomic) IBOutlet UIView *viMainView;

@property (weak, nonatomic)  LSBasicsBottomView *viBottomView;

@property (weak, nonatomic) IBOutlet UIButton *btnIconOne;
@property (weak, nonatomic) IBOutlet UIButton *btnIconContacts;
@property (weak, nonatomic) IBOutlet UIButton *btnIconMobile;

@property (weak, nonatomic) IBOutlet UILabel *lbRightOne;
@property (weak, nonatomic) IBOutlet UILabel *lbRightContacts;
@property (weak, nonatomic) IBOutlet UILabel *lbRightMobile;

@property (weak, nonatomic) IBOutlet UIButton *btnCellOne;
@property (weak, nonatomic) IBOutlet UIButton *btnCellContacts;
@property (weak, nonatomic) IBOutlet UIButton *btnCellMobile;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmitBtn;
@property (weak, nonatomic) IBOutlet UIView *viLineOne;
@property (weak, nonatomic) IBOutlet UIView *viLineTwo;
//认证是否可点击
-(void)basicsViewCertificationEnabled:(BOOL)isEnabled;
@end
