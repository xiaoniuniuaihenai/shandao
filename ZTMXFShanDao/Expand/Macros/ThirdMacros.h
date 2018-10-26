//
//  ThirdMacros.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h


//  小能客服
#define kXNSiteId       @"kf_10361"   //  企业ID
#define kXNSDKKey       @"fbfc3f60-ee30-4dd8-866a-dbbb0ddde5b3"   //  企业SDKKey

//  支付宝收款账号
#define kAlipayRepaymentAccount @"letu@imuzhuang.com"

//  高德地图SDK的key
#define kGaoDeMapKey    @"9ce45d9ae8035e9e96e7769ba19a874e"

// 极光推送key  
#define kJPushAppKey    @"66483186555c66627a1d8bd6"


#define k_MQsecretKey   @"f615a6327808fcaa01e63543324bef36"

#define kAppSource      @"shandao"


#ifdef ShanDaoEnterprise

    #define kJPushChannel   @"AppStore_Enter_shandao"
    #define kChannelId      @"AppStore_Enter_shandao"
    #define kUMengChannelId @"AppStore_Enterprise"

#else

    #define kJPushChannel   @"AppStore_shandao"
    #define kChannelId      @"AppStore_shandao"
    #define kUMengChannelId @"AppStore_Store"

#endif




//氪信Key
#define KCreditXAgentKey @"cxa3aff9f229116459ed783e"
//https://itunes.apple.com/cn/app/id1414918746?mt=8
//

#endif /* ThirdMacros_h */
