//
//  LSMobileRechargeHeadView.h
//  ALAFanBei
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  LSMobileRechargeHeadViewDelegate<NSObject>

@optional
/**
 手机号运营商 城市
 */
-(void)gainMobileRechargeMoneyListWithMobileProvince:(NSString*)province company:(NSString*)company;
//手机号是否完整
-(void)mobileRechargeHeadViewWithMobileState:(BOOL)isFull;
@end

@interface LSMobileRechargeHeadView : UIView
@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UILabel *lbMobileType;
@property(nonatomic,copy  )NSString * mobileValue;
-(instancetype)initMobileRechargeHeadHeadWithDelegate:(id)delegate;
-(void)setPhoneTFText:(NSString *)string anaMobileName:(NSString*)mobileName;
@end
