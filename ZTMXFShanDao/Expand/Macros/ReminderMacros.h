//
//  ReminderMacros.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#ifndef ReminderMacros_h
#define ReminderMacros_h
//补充认证类型
typedef NS_ENUM(NSInteger,AuthSupplyType){
    AuthSupplyTypeGongJiJin = 0,
    AuthSupplyTypeSheBao,
    AuthSupplyTypeXinYongKa,
    AuthSupplyTypeZhiFuBao,
    AuthSupplyTypeJingDong,
    AuthSupplyTypeTaoBao,
};

//  借钱类型
typedef enum : NSUInteger {
    ConsumeLoanType,   //  消费贷
    CashLoanType,      //  现金贷
    WhiteLoanType,     //  白领贷
    MallLoanType,      //  消费分期
    MallPurchaseType,  //  消费分期购物
} LoanType;

//  实名认证类型
typedef enum : NSUInteger {
    YiTuAuthentication,         //  依图认证
    FacePlusAuthentication,     //  face++认证
} RealNameAuthenticationType;


#define kUserAccessToken            @"accessToken"
#define kUserPhoneNumber            @"phoneNumber"
#define kUserPassword               @"password"
#define kUserID                     @"userID"
#define KAppVersionOld              @"AppVersionOld"


#define kPhoneInputReminder @"请输入手机号"
#define kVerifyCodeInputReminder @"请输入验证码"
#define kPasswordInputReminder @"请输入6-18位数字、字母组合的密码"
#define kRecommenderPhoneInputReminder @"请输入推荐人手机号"
#define kUserIdNumberInputReminder  @"请输入身份证号"


#define kPhoneInputErrorReminder @"请输入正确的手机号"
#define kOriginalPasswordInputRemider @"请输入原密码"
#define kNewPasswordInputRemider      @"请输入新密码"


#pragma mark - 商城订单显示按钮
#define kOrderButtonPay                @"去付款"
#define kOrderButtonCancelOrder        @"取消订单"
#define kOrderButtonApplyRefund        @"申请退款"
#define kOrderButtonCheckRefundDetail  @"查看详情"   //  查看退款详情
#define kOrderButtonConfirmReceive     @"确认收货"
#define kOrderButtonViewLogistics      @"查看物流"
#define kOrderButtonRepayOrder         @"重新购买"

#pragma mark - 白领贷订单显示按钮
#define kOrderButtonWriteAddress       @"填写地址"

#define kNetworkConnectFailure @"网络连接失败,请稍后重试"

#define kCompanyName    @""


#pragma mark - 借款类型
#define kWhiteLoanType       @"3"    //  白领贷
#define kConsumeLoanType     @"2"    //  消费贷


#pragma mark - 通知自定义KEY
//登录成功
#define kLoginSuccess @"kLoginSuccess"
//退出登录成功
#define kLogoutSuccess @"kLogoutSuccess"
//从哪个类进入的实名认证  最后返回
#define kRealNameInVcNameKey @"kRealNameInVcNameKey"

/** cell title value 宏定义 */
#define kTitleValueCellManagerKey @"kTitleValueCellManagerKey"
#define kTitleValueCellManagerValue @"kTitleValueCellManagerValue"

#pragma mark - 银行卡
#define kFanBeiBankCardInfoName         @"kFanBeiBankCardInfoName"
#define kFanBeiBankCardInfoTailNumber   @"kFanBeiBankCardInfoTailNumber"
#define kFanBeiBankCardIconUrl          @"kFanBeiBankCardIconUrl"

#pragma mark - 客服电话
#define kCustomerServicePhone @"400-185-8811"//old:400-161-8585

#pragma mark - 极光推送
#define kJPushSequence 9999
//  设置204跳转到H5的弹窗key
#define kJumpToWebViewController @"kJumpToWebViewController"
//  204
#define kJumpToWebViewControllerKey @"kJumpToWebViewControllerKey"

//  设置205跳转到原生的弹窗key
#define kJumpToNativeViewController @"kJumpToNativeViewController"
//  205
#define kJumpToNativeViewControllerKey @"kJumpToNativeViewControllerKey"

// 206 207 208  借钱页面状态变更  刷新页面消息

#define kNotRefreshBorrowMoneyPage  @"kNotRefreshBorrowMoneyPage"

// 206 207 208  借钱页面状态变更  刷新页面消息
#define kAppReviewState  @"kAppReviewState"
//  209 刷新  基础认证 信息
#define kNotRefreshCreditPromotePage @"kNotRefreshCreditPromotePage"
//  300  慢必赔  赔偿弹窗
#define kNotCreditPromoteCompensate @"kNotCreditPromoteCompensate"
//  301  强风控通过
#define kNotCreditStrongRiskSucceed @"kNotCreditStrongRiskSucceed"
// 302    强风控 未通过
#define kNotCreditStrongRiskFail @"kNotCreditStrongRiskFail"
/** 1.4 版本*/
// 303 认证有礼
#define kNotAuthentication @"kNotAuthentication"
// 当天是否第一次登录
#define kNotAuthenticationIsPop @"kNotAuthenticationIsPop"

/** 1.6 版本*/
// 309 白领贷认证通过
#define kWhiteLoanAuthSucceed @"kWhiteLoanAuthSucceed"

//登录 过得账号
#define LSOldMobileKey  @"LSOldMobileKey"
// 手动修改  底层地址
#define BaseLocalSaveUrlKey @"BaseLocalSaveUrlKey"

#pragma mark - App骨头中通知
#define kAppInReviewNotification @"kAppInReviewNotification"

//  商品详情里面使用
#define kGoTopNotificationName      @"goTop"//进入置顶命令
#define kLeaveTopNotificationName   @"leaveTop"//离开置顶命令

#pragma mark - 统计埋点
/** banner 点击 */
#define kBanner     @"banner"



/** 消费贷续借支付失败 */
#define k_Extendloan_pay_fail_xf @"extendloan_pay_fail_xf"
/** 消费贷续借支付成功 */
#define k_Extendloan_pay_succ_xf @"extendloan_pay_succ_xf"
/** 续借页面支付 */
#define k_Extendloan_pay_xf @"extendloan_pay_xf"
/** 消费贷续借入口 */
#define k_Extendloan_click_xf @"extendloan_click_xf"
/** 消费贷还款失败 */
#define k_Payback_fail_xf @"payback_fail_xf"
/**消费贷还款成功 */
#define k_Payback_succ_xf @"payback_succ_xf"
/** 消费贷确认还款点击支付 */
#define k_Payback_confirm_click_xf @"payback_confirm_click_xf"
/** 消费贷还款按钮点击次数 */
#define k_Payback_click_xf @"payback_click_xf"
/** 消费贷放款成功*/
#define k_lend_succ_xf @"lend_succ_xf"
/** 消费贷借钱失败 */
#define k_do_loan_fail_xf @"do_loan_fail_xf"
/** 消费贷借钱成功 */
#define k_do_loan_succ_xf @"do_loan_succ_xf"
/** 消费贷确认借钱 */
#define k_confirm_loan_xf @"confirm_loan_xf"
/** 消费贷强风控失败 */
#define k_risk_fail_xf @"risk_fail_xf"
/** 消费贷强风控通过 */
#define k_risk_succ_xf @"risk_succ_xf"
/** 消费贷提交强风控 */
#define k_submit_risk_xf @"submit_risk_xf"
/** 消费贷运营商认证失败 */
#define k_operator_fail_xf @"operator_fail_xf"
/** 消费贷运营商认证成功 */
#define k_operator_succ_xf @"operator_succ_xf"
/** 消费贷运营商入口点击 */
#define k_operator_click_xf @"operator_click_xf"
/** 消费贷绑定银行卡入口点击 */
#define k_bankcard_click_xf @"bankcard_click_xf"
/** 消费贷用户扫脸但未获取信息 *///5.8日产品说此埋点取消
#define k_facescan_empty_faceplus_xf @"facescan_empty_faceplus_xf"
/** 消费贷face++扫脸不通过 */
#define k_facescan_fail_faceplus_xf @"facescan_fail_faceplus_xf"
/** 消费贷face++扫脸通过 */
#define k_facescan_success_faceplus_xf @"facescan_success_faceplus_xf"
/** 消费贷身份证 下一步按钮 */
#define k_idcard_page_next_xf @"idcard_page_next_xf"
/** 消费贷face++OCR  SDK调取失败 */
#define k_idcard_sdk_fail_faceplus_xf @"idcard_sdk_fail_faceplus_xf"
/** 消费贷face++身份正面识别失败 */
#define k_idcard_front_fail_faceplus_xf @"idcard_front_fail_faceplus_xf"
/** 消费贷face++身份正面识别成功 */
#define k_idcard_front_succ_faceplus_xf @"idcard_front_succ_faceplus_xf"
/** 消费贷face++识别身份证反面 */
#define k_idcard_backside_faceplus_xf @"idcard_backside_faceplus_xf"
/** 消费贷face++识别身份证正面 */
#define k_Idcard_front_faceplus_xf @"Idcard_front_faceplus_xf"
/** 消费贷身份认证入口点击 */
#define k_do_idcard_xf @"do_idcard_xf"
/** 消费贷身份证页面 pv */
#define k_Idcard_page_pv_xf @"Idcard_page_pv_xf"
/** 消费贷信用认证页面 pv */
#define k_credit_page_pv_xf @"credit_page_pv_xf"
/** 借钱页面点击借钱 */
#define k_do_loan @"do_loan"
/** 注册页面点击密码可见 */
#define k_regist_doSeePassword @"regist_doSeePassword"
/** 注册页面点击注册 */
#define k_regist_doRegist @"regist_doRegist"
/** 注册页面点击获取验证码 */
#define k_regist_getYZM @"regist_getYZM"
/** 登录页面点击注册 */
#define k_logoin_regist_click @"logoin_regist_click"
/** 注册结果 */
#define k_regist_result @"regist_result"
/** 消费贷绑卡页面获取验证码 */
#define k_bankcard_getcode_xf @"bankcard_getcode_xf"
/** 消费贷跳过支付密码 */
#define k_skippassword_xf @"skippassword_xf"
/** 消费贷芝麻信用入口点击 */
#define k_do_zhima_xf @"do_zhima_xf"
/** 消费贷通讯录入口点击 */
#define k_contactlist_click_xf @"contactlist_click_xf"
/** 消费贷通讯录获取 */
#define k_contactlist_get_xf @"contactlist_get_xf"

/********************************版本1.2新增*********************************/
/** 原生注册-登录页面点击获取验证码 */
#define k_regist_getYZM_130 @"regist_getYZM_130"
/** 原生注册-登录页面图片验证码点击确定 */
#define k_regist_inputYZM_130 @"regist_inputYZM_130"
/** 原生注册-登录页面点击登录 */
#define k_regist_doRegist_130 @"regist_doRegist_130"
/** 原生贷超广告位点击量 */
#define k_Adv_click_app_daichao @"Adv_click_app_daichao"
/** APP贷超各个产品入口的点击量 */
#define k_appDaichao_list_click @"appDaichao_list_click"
/** 借钱页面贷超入口点击量 */
#define k_zhouzhuan_click @"zhouzhuan_click"
/** banner 点击次数 */
#define k_banner_click @"banner_click"

/** 商城 每个banner 点击次数 */
#define k_super_banner_click @"super_banner_click"
/********************************版本134新增*********************************/
//------------------------------注册登录
/** 1.3.4版本注册页面，点击密码登录时埋点 */
#define k_regist_loginclick_130 @"regist_loginclick_130"
/** 1.3.4版本注册页面,登陆成功时候埋点 */
#define k_login_result_success130 @"login_result_success130"
//------------------------------基础认证
/** 1.3.4版本基础认证,芝麻认证成功时埋点 */
#define k_zhima_success_xf @"zhima_success_xf"
/** 1.3.4版本基础认证,face++进入人脸识别页面时埋点 */
#define k_facescan_faceplus_pv @"facescan_faceplus_pv"
/** 1.3.4版本基础认证,消费贷，face++身份证正面识别页面埋点 */
#define k_idcard_frontpace_faceplus_pv_xf @"idcard_frontpace_faceplus_pv_xf"


//-------------------------------绑定银行卡页面
/** 1.3.4版本绑定银行卡页面,银行卡绑卡成功埋点 */
#define k_bankcard_success @"bankcard_success"
/** 1.3.4版本绑定银行卡页面,银行卡绑卡失败埋点 */
#define k_bankcard_fail @"bankcard_fail"
/** 1.3.4版本绑定银行卡页面,绑定银行卡页面 pv埋点 */
#define k_bankcard_page_pv_xf @"bankcard_page_pv_xf"



/** 强风控等待页埋点 */
#define k_credit_ing1_pv @"credit_ing1_pv"
/** 认证等待结果页 pv */
#define k_credit_ing2_pv @"credit_ing2_pv"
/** 点击返回按钮 */
#define k_credit_ing2_return @"credit_ing2_return"
/** 点击我知道了按钮 */
#define k_credit_ing2_iknow_click @"credit_ing2_iknow_click"
/** 点击查看优客专享 */
#define k_reject_clickDaichao @"reject_clickDaichao"
/** 被拒贷超页面PV */
#define k_reject_superMarket_pv @"reject_superMarket_pv"
/** 点击查看优客专享  -Return */
#define k_reject_Return @"reject_Return"
/** 被拒贷超页面PV --H5页面 */
#define k_reject_superMarket_pv @"reject_superMarket_pv"

//---------------------------------立即还款页面
/** 立即还款页面 pv */
#define k_payback_page_pv_xf @"payback_page_pv_xf"



//--------周六
/** 强风控认证失败页面pv */
#define k_reject_pave_pv @"reject_pave_pv"

#endif /* ReminderMacros_h */
