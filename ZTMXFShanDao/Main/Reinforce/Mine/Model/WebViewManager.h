//
//  WebViewManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UIWebViewRefreshType) {
    UIWebViewRefreshNotRefreshType,  //不做刷新处理
    UIWebViewRefreshGoBackRefreshType, //返回刷新
};

typedef NS_ENUM(NSInteger, CYwebAddAppUINameType) {
    CYwebAddAppUINameTypeDef,  //不做任何处理
    CYwebAddAppUINameTypeShare, //添加分享按钮
    CYwebAddAppUINameTypeMyCoupon,  //  我的优惠券按钮
    CYwebAddAppUINameTypeLastWinRank, //  上月获奖名单
    CYwebAddAppUINameTypeCustomerServices, //  客服
};

typedef NS_ENUM(NSInteger, CYWebOpennativeNameType) {
    //添加时注意添加NSString (Additions) 转化添加 中的 getCYWebOpennativeNameTypeStringToInteger 类型修改
    GOODS_DETAIL_INFO,      //商品详情
    CATEGORY,               //商品分区
    APP_LOGIN,              //登录
    COMMON_VIEW_CONTROLLER, //不做任何处理
    BORROW_MONEY,           //  借钱
    APP_SHARE,              // 分享
    APP_SIGNIN,             //  签到
    MINE_COUPON_LIST,       //  我的优惠券
    BOLUOMI_CHOISE_PAYMENT, // 菠萝蜜选择支付方式
    JUMP_HOMEPAGE,          // 跳转到首页
    APP_TRADE_PAY,          //   跳转到付款页面
    APP_TRADE_PROMOTE,      //   商圈H5提升额度
    DO_SCAN_ID,             //  去扫描身份证
    DO_FACE,                //  去人脸识别活体认证
    DO_BIND_CARD,           //  去绑定银行卡
    DO_PROMOTE_BASIC,       //  去提升信用基础认证
    DO_PROMOTE_EXTRA,       //  去提升补充认证,
    APP_CONTACT_CUSTOMER,   //  联系客服
    APP_INVITE,             //  邀请有礼
    RETURN_BACK,            //  返回上一个页面
    DO_WHITE_RISK,           //  白领贷实名认证
    MALL_HOME,               //商城页面
    MALL_AUTH_LIST,          //消费分期认证列表页
    LOAN_AUTH_LIST,          //消费贷认证列表页
    FORGET_PASSWORD,         //忘记密码
    ORDER_DETAILS           //订单详情
    
};

@interface WebViewManager : NSObject

//配合H5 添加对应UI
+(CYwebAddAppUINameType)addAppUINameTypeWithName:(NSString*)addUiName;
//打开原生UI
+(CYWebOpennativeNameType)opennativeNameTypeWithName:(NSString *)name;

@end
