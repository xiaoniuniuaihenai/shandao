//
//  CreditXAgent.h
//
//  Copyright (C) 2015-2017 creditx.com . All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WKUserScript;
@class CXDeviceID;

typedef enum : NSInteger {
    CXPageNameUnknown = 1,
    CXPageNameRegister,
    CXPageNameLogin,
    CXPageNameIdVerify,
    CXPageNameOperator,
    CXPageNameBiometricAuth,
    CXPageNameBindDebitCard,
    CXPageNameBindCreditCard,
    CXPageNamePersonalInfo,
    CXPageNameContactsInfo,
    CXPageNameLoanIndex,
    CXPageNameLoanSubmission,
} CXPageName;

typedef enum : NSInteger {
    CXClickRegisterGetVerifyCode = 1,
    CXClickLoginForgetPassword,
    CXClickLoanIndexLoanClicked,
    CXClickVerifyIDPicFrnt,
    CXClickVerifyIDPicBak,
    CXClickVerifyIDPicWithOwner,
    CXClickBindDebitCardSelectBank,
    CXClickContactInfoContact1FromAddressBook,
    CXClickContactInfoContact2FromAddressBook,
} CXClickActionName;

typedef enum : NSInteger {
    CXSubmitRegister = 1,
    CXSubmitLogin,
    CXSubmitVerifyID,
    CXSubmitVerifyIDPicWithOwner,
    CXSubmitOperator,
    CXSubmitBiometricAuth,
    CXSubmitBindDebitCard,
    CXSubmitBindCreditCard,
    CXSubmitPersonalHomeInfo,
    CXSubmitPersonalCompanyInfo,
    CXSubmitContactInfoSaveContacts,
    CXSubmitLoanSubmission,
} CXSubmitActionName;

typedef enum : NSInteger {
    CXInputRegisterUserID = 1,
    CXInputRegisterVerifyCode,
    CXInputRegisterPassword,
    CXInputLoginUserID,
    CXInputLoginPassword,
    CXInputLoanIndexLoanAmount,
    CXInputVerifyIDName,
    CXInputVerifyIDIdentity,
    CXInputOperatorMobileNumber,
    CXInputOperatorServicePassword,
    CXInputBindDebitCardNumber,
    CXInputBindDebitCardName,
    CXInputBindDebitCardContactPhone,
    CXInputBindCreditCardNumber,
    CXInputBindCreditCardName,
    CXInputBindCreditCardContactPhone,
    CXInputPersonalHomeAddress,
    CXInputPersonalHomePhone,
    CXInputPersonalCompanyName,
    CXInputPersonalCompanyAddress,
    CXInputPersonalJobTitle,
    CXInputPersonalCompanyPhone,
    CXInputContactInfoContact1Name,
    CXInputContactInfoContact1Relation,
    CXInputContactInfoContact1Phone,
    CXInputContactInfoContact2Name,
    CXInputContactInfoContact2Relation,
    CXInputContactInfoContact2Phone,
    CXInputLoanSubmissionAmount,
} CXInputActionName;

typedef enum : NSInteger {
    CXSubmitStatusSuccess = 0,
    CXSubmitStatusFailed = 1,
} CXSubmitStatus;

typedef enum : NSInteger {
    CXLoginMethodPassword = 1,          // 使用账号密码登陆
    CXLoginMethodAutoLogin,             // 账号免密登陆（自动登录）
    CXLoginMethodVerificationCode,      // 验证码快速登录
    CXLoginMethodThirdPartyAuth,        // 第三方授权登录
    CXLoginMethodThirdAuth,             // 第三方授权自动登陆
    CXLoginMethodOthers,                // 其他登陆方式
} CXLoginMethod;

@interface CreditXAgent : NSObject
@property(nonatomic, strong) NSString *appKey;

+ (CreditXAgent *)sharedInstance;

+ (void)initWithAppKey:(NSString *)appKey;

+ (CXDeviceID *)getCreditXDeviceID;

+ (void)onEnteringPage:(CXPageName)pageName;

+ (void)onLeavingPage:(CXPageName)pageName;

+ (void)onClick:(CXClickActionName)actionName;

#pragma mark -
#pragma mark Input Actions

+ (void)onInput:(CXInputActionName)actionName contentChanged:(NSString *)content;

+ (void)onInput:(CXInputActionName)actionName focusChanged:(BOOL)hasFocus;

+ (void)setInputObserver:(CXInputActionName)actionName forTextField:(UITextField *)textField;

+ (void)setDelegate:(CXInputActionName)actionName forTextView:(UITextView *)textView;

#pragma mark -
#pragma mark Submit Actions

/**
 * 当提交数据并获得结果时
 * @param actionName 行为名称
 * @param result     结果，成功或失败
 * @param msg        描述，如失败的原因
 */
+ (void)onSubmit:(CXSubmitActionName)actionName result:(BOOL)result withMessage:(NSString *)msg;

/**
 * 当用户登录成功时
 * @param userID        在客户业务系统中的用户ID。请务必正确设置此ID。
 * @param loginMethod   登录方式
 */
+ (void)onUserLoginSuccessWithUserID:(NSString *)userID loginMethod:(CXLoginMethod)loginMethod;

/**
 * 当用户退出登录时调用此方法
 */
+ (void)onUserLogout;

+ (void)handleUrl:(NSString *)urlStr;

+ (NSString *)getAppKey;

+ (WKUserScript *)createUserScript;

/**
 * 设置是否允许SDK主动申请位置权限，默认为YES
 * @param allowed 是否允许
 */
+ (void)setAutoRequestLocationAuth:(BOOL)allowed;

/**
 * 设置是否允许SDK主动申请通讯录权限，默认为YES
 * @param allowed 是否允许
 */
+ (void)setAutoRequestContactsAuth:(BOOL)allowed;
@end

#pragma mark -
#pragma mark CXDeviceID

typedef enum : NSInteger {
    CXDeviceIDTypeIDFA = 1,
    CXDeviceIDTypeCXDID,
} CXDeviceIDType;

@interface CXDeviceID: NSObject
@property(nonatomic, strong) NSString *value;
@property(nonatomic, assign) CXDeviceIDType type;

- (NSString *)getTypeName;
@end
