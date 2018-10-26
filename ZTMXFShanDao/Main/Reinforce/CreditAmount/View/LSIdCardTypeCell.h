//
//  LSIdCardTypeCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBankCardTypeModel;
@interface LSIdCardTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbBankName;
@property (weak, nonatomic) IBOutlet UILabel *lbBankType;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelectImgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (strong,nonatomic) LSBankCardTypeModel * cardTypeModel;
@property (assign,nonatomic) BOOL isSelect;
@end
