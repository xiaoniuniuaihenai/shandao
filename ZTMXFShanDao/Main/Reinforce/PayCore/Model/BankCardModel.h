//
//  BankCardModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/17.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

/** 卡号 */
@property (nonatomic, copy) NSString *rid;
/** 银行卡名称 */
@property (nonatomic, copy) NSString *bankName;
/** 银行卡logo */
@property (nonatomic, copy) NSString *bankIcon;
/** 银行卡号 */
@property (nonatomic, copy) NSString *cardNumber;
/** 是否为主卡【1:主卡,0:非主卡】 */
@property (nonatomic, assign) NSInteger isMain;
/** 是否有效【1:有效，0：失效】 */
@property (nonatomic, assign) NSInteger isValid;
/** 无效时文案，以及横幅文案 */
@property (nonatomic, copy) NSString *invalidDesc;
/** 渠道说明 */
@property (nonatomic, copy) NSString *channelDesc;


@end
