//
//  MobileRechargeItemView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//
typedef NS_ENUM(NSInteger,RechargeItemState) {
    RechargeItemStateNormal = 0,
    RechargeItemStateSelect,
    RechargeItemStateNotEditor,
    RechargeItemStateNotEditorSelect,
};
#import <UIKit/UIKit.h>

@interface MobileRechargeItemView : UIView
-(instancetype)initWithDelegate:(id)delegate;

@property (nonatomic,copy) NSString * oneValue;
@property (nonatomic,copy) NSString * twoValue;

//不能编辑 title
@property (nonatomic,strong)UIColor * notColor;
//选中 title
@property (nonatomic,strong)UIColor * selectColor;
// 默认 tilte
@property (nonatomic,strong)UIColor * defColor;

//不能编辑 提示
@property (nonatomic,strong)UIColor * notTwoColor;
//选中 提示
@property (nonatomic,strong)UIColor * selectTwoColor;
// 提示
@property (nonatomic,strong)UIColor * notSelectTwoColor;
// 默认 提示
@property (nonatomic,strong)UIColor * defTwoColor;



//不能编辑 bg
@property (nonatomic,strong)UIColor * notBgColor;
//不可编辑并选中
@property (nonatomic,strong)UIColor * notSelectBgColor;
//不可编辑并选中 字体
@property (nonatomic,strong)UIColor * notSelectColor;
//不可编辑并选中  边框
@property (nonatomic,strong)UIColor * notSelectBorderColor;

//选中 bg
@property (nonatomic,strong)UIColor * selectBgColor;
// 默认 bg
@property (nonatomic,strong)UIColor * defBgColor;

@property (nonatomic,strong) UIColor * borderColor;
@property (nonatomic,strong) UIColor * borderSelectColor;
@property (nonatomic,strong) UIColor * borderNotColor;

-(void)restoreBtnState:(RechargeItemState)itemState;
@end
@protocol  MobileRechargeItemViewDelegate<NSObject>

@optional
/**
 * 选择充值金额
 */
-(void)mobileRechargeItemViewSelectItem:(MobileRechargeItemView*)itemView;

@end
