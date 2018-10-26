//
//  XLText.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#ifndef XLText_h
#define XLText_h

#define MJEndText @""

#define k_NSBundle [[NSBundle mainBundle] infoDictionary]

#define k_BundleData(name) [k_NSBundle objectForKey:name]

// app名称
#define k_APP_Name k_BundleData(@"CFBundleDisplayName")
// app版本
#define k_App_Version k_BundleData(@"CFBundleShortVersionString")

#endif /* XLText_h */
