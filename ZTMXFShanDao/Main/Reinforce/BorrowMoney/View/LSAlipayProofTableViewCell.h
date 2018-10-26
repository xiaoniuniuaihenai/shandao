//
//  LSAlipayProofTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlipayProofModel : NSObject

@property (nonatomic, copy) NSString *proofImageStr;
@property (nonatomic, copy) NSString *proofTitle;
@property (nonatomic, copy) NSString *proofValue;

@end


@interface LSAlipayProofTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) AlipayProofModel *alipayProofModel;

@end
