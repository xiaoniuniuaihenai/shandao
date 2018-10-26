//
//  LSMineModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMineModel : NSObject

/** 余额 */
@property (nonatomic, copy) NSString *rebateAmount;
/** 绑卡数量 */
@property (nonatomic, copy) NSString *bankcardCount;
/** 优惠券数量 */
@property (nonatomic, copy) NSString *couponCount;
/** 借款利率 */
@property (nonatomic, copy) NSString *borrowRate;
/** 信用等级 */
@property (nonatomic, copy) NSString *credit;
/** 邀请有礼url */
@property (nonatomic, copy) NSString *invitation;
/** 是否显示邀请有礼 1有邀请,0没有邀请*/
@property (nonatomic, assign) NSInteger inviteSwitch;

/** 0:未绑卡  1：绑卡 */
@property (nonatomic, assign) NSInteger bindStatus;
/** 0:未识人  1：识人成功 */
@property (nonatomic, assign) NSInteger facesStatus;

/** 还款日：0为没有还款日 */
@property (nonatomic, assign) NSInteger repayDay;
/** 本期应还 */
@property (nonatomic, assign) CGFloat billAmount;
/** 剩余应还款金额 */
@property (nonatomic, assign) CGFloat surplusBillAmount;

@end
