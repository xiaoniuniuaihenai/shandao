//
//  ScanIdentityCardView.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanIdentityCardViewDelegate<NSObject>

/** 点击正面 */
- (void)scanIdentityCardViewClickHead;

/** 点击反面 */
- (void)scanIdentityCardViewClickTail;

/** 点击下一步 */
- (void)scanIdentityCardViewClickNextAction;

@end

@interface ScanIdentityCardView : UIView

@property (nonatomic, weak) id<ScanIdentityCardViewDelegate> delegate;

/** 设置身份证正面 */
- (void)setHeadImage:(UIImage *)headImage;
/** 设置身份证反面 */
- (void)setTailImage:(UIImage *)tailImage;

/** 展示身份信息 */
- (void)showIdentityView;
- (void)setIdentityName:(NSString *)name;
- (void)setIdentityIdNumber:(NSString *)IdNumber;

/** 身份证名字 */
- (NSString *)identityEditName;

/** 设置名字是否可编辑 */
- (void)realNameEdit:(BOOL)edit;

/** 清除页面信息 */
- (void)clearViewInfo;

@end
