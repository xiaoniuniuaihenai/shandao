//
//  LSCompanyAuthView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSCompanyInfoModel;

@protocol LSCompanyAuthViewDelegete <NSObject>

@optional

/** 点击选择行业、岗位 */
- (void)clickTextFieldButon:(NSInteger)tag;
/** 点击下一步按钮 */
- (void)clickNextStep;
/** 选择省市区 */
- (void)chooseAeraWithProvice:(NSString *)provice city:(NSString *)city region:(NSString *)region;

@end

@interface LSCompanyAuthView : UIView

/** 行业输入框 */
@property (nonatomic, strong) UITextField *industryField;
/** 其他行业输入框 */
@property (nonatomic, strong) UITextField *otherIndustryField;
/** 公司名称输入框 */
@property (nonatomic, strong) UITextField *companyField;
/** 公司地址输入框 */
@property (nonatomic, strong) UITextField *addressField;
/** 详细地址输入框 */
@property (nonatomic, strong) UITextField *detailAddressField;
/** 公司电话输入框 */
@property (nonatomic, strong) UITextField *phoneField;
/** 任职部门输入框 */
@property (nonatomic, strong) UITextField *departmentField;
/** 任职岗位输入框 */
@property (nonatomic, strong) UITextField *positionField;
/** 其他任职岗位输入框 */
@property (nonatomic, strong) UITextField *otherPositionField;

@property (nonatomic, weak) id <LSCompanyAuthViewDelegete> delegete;

@property (nonatomic, strong) LSCompanyInfoModel *companyInfoModel;

- (void)chooseIndustry;

@end
