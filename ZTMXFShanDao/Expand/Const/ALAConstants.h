//
//  ALAConstants.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#ifndef ALAConstants_h
#define ALAConstants_h
//网络状态监控地址
static NSString* const kURL_Reachability__Address=@"www.baidu.com";

//断开网络
static NSString* const kDisconnect_network=@"网络断开,请检查网络";



#pragma mark - URL 拼接
#define DefineUrlString(urlStr)    [NSString stringWithFormat:@"%@%@",BaseHtmlUrl,urlStr]

#pragma mark - 固定URL
//  服务中心
#define serviceCenter @"/h5/serviceCenter.html"
//  服务中心 认证问题
#define serviceCenter_que_first @"/h5/serviceKinds.html?que=1"
//  服务中心 还款问题
#define serviceCenter_que_three @"/h5/serviceKinds.html?que=3"
//支付宝还款页面
#define alipayPayment @"/h5/alipayRefund.html"
//  其他支付方式
#define otherPayType @"/h5/otherPayType.html"
//  关于我们
#define abountUs @"/h5/aboutUs.html"
//  排行榜
#define inviteRankList @"/h5/inviteRankList.html"
//  h5 借款超市
#define borrowGoods @"/h5/otherBorrow.html?channel=h5"

//  h5 还款教程
#define kRepaymentCourse @"/h5/repaymentCourse.html"
//  h5 还款帮助
#define kRepayHelp @"/h5/repayQuestion.html"
//  h5 强风控 未通过 V1.1.5
//  h5 借款超市   1.2.0新增
//#define strongRiskFail @"/h5/borrowRefused.html"
#define strongRiskFail @"/h5/otherBrwRiskFail.html"
//  h5 身份认证描述 V1.2.0
#define idCardExplain @"/h5/idCardExplain.html"
//  白领贷推广页面
#define kWhiteLoanPromotion @"/h5/whiteBorrowDetail.html"
//  白领贷审核未通过
#define kWhiteLoanUnapprove(whiteRiskRetrialRemindDay) [NSString stringWithFormat:@"/h5/whiteUnverify.html?whiteRiskRetrialRemindDay=%@",whiteRiskRetrialRemindDay]
//  白领贷审核中
#define kWhiteLoanInReview @"/h5/whiteBorrowAudit.html"

/** ***********************版本1.2.0新增***********************    */
//  h5 支付宝传订单号教程
#define alipayRefundTips @"/h5/alipayRefundTips.html"
//  h5 认证中的链接
#define k_mobile_identify @"/h5/identify.html"
/** ***********************版本1.2.0新增***********************    */
#pragma mark - 协议
//  消费贷、现金贷借款协议
#define personalCashProtocol(userName,borrowId,borrowAmount,borrowUse,borrowType)  [NSString stringWithFormat:@"/h5/ptlPersCash.html?userName=%@&borrowId=%@&borrowAmount=%@&borrowUse=%@&borrowType=%@",userName,borrowId,borrowAmount,borrowUse,borrowType]
//  白领贷借款协议
#define personalWhiteCashProtocol(userName,borrowId,borrowAmount,borrowUse)  [NSString stringWithFormat:@"/h5/ptlWhiteCash.html?userName=%@&borrowId=%@&borrowAmount=%@&borrowUse=%@",userName,borrowId,borrowAmount,borrowUse]
//  注册协议
#define registerProtocol @"/h5/ptlRegister.html"
//  延期还款协议
#define renewalProtocol(userName,renewalId,borrowId,renewalDay,renewalAmount)  [NSString stringWithFormat:@"/h5/ptlRenewal.html?userName=%@&renewalId=%@&borrowId=%@&renewalDay=%@&renewalAmount=%@",userName,renewalId,borrowId,renewalDay,renewalAmount]
//  服务协议(绑定银行卡)
#define serviceProtocol @"/h5/ptlService.html"

// 消费分期借款协议
#define personalMallCashProtocol(orderId,amount,nper,borrowNo) [NSString stringWithFormat:@"/h5/ptlMallStagesCash.html?orderId=%@&amount=%@&nper=%@&borrowNo=%@",orderId,amount,nper,borrowNo]

// 委托协议 借款类型（2：消费贷 3：白领贷 4:消费分期）
#define entrustBorrowCashProtocol(borrowId,borrowAmount,borrowType) [NSString stringWithFormat:@"/h5/ptlEntrust.html?borrowId=%@&borrowAmount=%@&borrowType=%@",borrowId,borrowAmount,borrowType]

#endif /* ALAConstants_h */
