//
//  TargetConfigMacros.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#ifndef TargetConfigMacros_h
#define TargetConfigMacros_h



#define isAppOnline 2  //0、测试环境   1、正式环境 2 预发环境


//线上环境是不能 切换IP
#define LocalBaseUrl [[NSUserDefaults standardUserDefaults]objectForKey:BaseLocalSaveUrlKey]
#define BaseLocalUrl(baseUrl) [LocalBaseUrl length]>0&&isAppOnline!=1?LocalBaseUrl: baseUrl


#if isAppOnline == 1
// 正式环境开始--------------
    #define EnvironmentDesc @"生产环境"
    // 域名
    #define k_letto8_Domain @"musitech8.com"

    /** 请求证书name */
    #define CertificateName @"server"

    ///** 文件上传 Base Url */
    #define UploadBaseUrl @"http://pfile.musitech8.com"

    //线上 h5
    #define BaseHtmlUrl    @"http://papi.musitech8.com"
    /** 请求Api Base Url */
    #define BaseUrl @"http://papi.musitech8.com"

    //友盟统计SDK的key
    #define kUmengKey @"5b98f2eff29d982097000207"

    //魔蝎 公积金
    #define MoxieSDKKEY @"a07d235739e240ecbd34dad62a5f4ec5"
    //   小能接待组ID
    #define kXNSettingId @"kf_10361_1536630610870"
    /**
     统计url
     */
    #define k_statisticalURL @"http://ppvuv.musitech8.com"

// 正式环境结束--------------
#elif isAppOnline == 2
// 预发环境开始--------------
    #define EnvironmentDesc @"预发环境"
    // 域名
//    #define k_letto8_Domain @"bjibei.xyz"
   // 域名
   #define k_letto8_Domain @"47.96.2.80:8080"

    /** 请求证书name */
    #define CertificateName @"server"
    #define BaseUrl BaseLocalUrl(BaseUrlNow)
    /** 文件上传 Base Url */
    #define UploadBaseUrl @"http://pfile.bjibei.xyz"


//    /** 请求Api Base Url */
//    #define BaseUrlNow @"http://gapi.bjibei.xyz"
//    //预发  papi.bjibei.xyz →  gapi.bjibei.xyz
//    #define BaseHtmlUrl    @"http://gapi.bjibei.xyz"


//H5 测试
//#define BaseHtmlUrl  @"http://47.96.2.80:8080"//
///** Api 服务器 */
//#define BaseUrlNow  @"http://47.96.2.80:8080"//


//H5 测试
#define BaseHtmlUrl  @"http://192.168.1.138:8080"//
//* Api 服务器
#define BaseUrlNow  @"http://192.168.1.138:8080"//


    //   魔蝎 公积金
    #define MoxieSDKKEY @"a07d235739e240ecbd34dad62a5f4ec5"
    //   友盟测试
    #define kUmengKey @"5b98f4bef29d98113f00003c"
    //   小能接待组ID
    #define kXNSettingId @"kf_10361_1536630610870"
    /**
    统计url
    */
    #define k_statisticalURL @"http://gpvuv.bjibei.xyz"
// 预发环境结束--------------

#else

// 测试环境开始--------------

    #define EnvironmentDesc @"测试环境"
    // 域名
    #define k_letto8_Domain @"666pano.com"

    /** 请求证书name */
    #define CertificateName @"server"
    #define BaseUrl BaseLocalUrl(BaseUrlNow)
    //魔蝎 公积金 测试环境
    #define MoxieSDKKEY @"a6df1ad97e9e4905bef96c8593a39aa9"
    //友盟测试
    #define kUmengKey @"5b98f4bef29d98113f00003c"
    //   小能接待组ID
    #define kXNSettingId @"kf_10361_1536630610870"
    /** 请求Api Base Url */
    /** 文件服务器 */
    #define UploadBaseUrl @"http://tfile.666pano.com"//@"http://tfile.bjibei.xyz"
    //////H5 测试
    #define BaseHtmlUrl    @"http://tapi.666pano.com"//@"http://tapi.bjibei.xyz"
    /** Api 服务器 */
    #define BaseUrlNow @"http://tapi.666pano.com"//@"http://tapi.bjibei.xyz"
    /**
     统计url
     */
    #define k_statisticalURL @"http://tpvuv.666pano.com"//@"http://tpvuv.bjibei.xyz"

#endif






#endif /* TargetConfigMacros_h */
