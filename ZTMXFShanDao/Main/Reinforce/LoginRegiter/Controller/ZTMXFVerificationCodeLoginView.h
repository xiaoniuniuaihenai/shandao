//
//  ZTMXFVerificationCodeLoginView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

typedef enum : NSUInteger {
    XL_LOGINVC_VERIFICATION_CODE,
    XL_LOGINVC_PASSWORD,
} XL_VERIFICATION_OR_PASSWORD;

typedef void(^ActionBlock)(void);
typedef void(^CallBackBlock)(id obj);

#import <UIKit/UIKit.h>
@class JKCountDownButton;
@class LSInputTextField;
/*登录页面布局*/
@interface ZTMXFVerificationCodeLoginView : UIView
@property (nonatomic, copy) CallBackBlock getVerificationCodeBlock;
@property (nonatomic, copy) ActionBlock loginBlock;
@property (nonatomic, copy) ActionBlock advertisingClickBlock;

- (instancetype)initWithFrame:(CGRect)frame Type:(XL_VERIFICATION_OR_PASSWORD)type;
/** 获取页面上用于上传的数据 */
- (NSDictionary *)getData;

/** 获取验证码按钮 */
@property (nonatomic, strong) JKCountDownButton *getCodeButton;
/** 手机号输入框 */
@property (nonatomic, strong) LSInputTextField  *phoneInput;
@property (nonatomic, strong) UIButton          *loginButton;
//* 控制验证码按钮是否可点 */
@property (nonatomic, assign) BOOL               getCodeButtonEnabled;
//160新增,控制是否给手机号输入框进行氪信埋点
@property (nonatomic, assign) BOOL credixForPhoneTextField;
/** 广告  appstore审核时不显示 */
@property (nonatomic, strong) UIImageView *advertisingImageView;
@end
