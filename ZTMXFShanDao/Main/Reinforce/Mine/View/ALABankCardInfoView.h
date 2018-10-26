//
//  ALABankCardInfoView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/17.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALABankCardInfoView : UIView

/** 银行icon ImageView */
@property (nonatomic, strong) UIImageView *bankIconImageView;
/** 银行账户 */
@property (nonatomic, strong) UILabel *bankAccountLabel;
/** 银行名字 */
@property (nonatomic, strong) UILabel *bankNameLabel;
/** 尾号 */
@property (nonatomic, strong) UILabel *tailNumberLabel;

//  设置银行卡数据
- (void)configueBankCardInfoView:(NSDictionary *)infoData;

@end
