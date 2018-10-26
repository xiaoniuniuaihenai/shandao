//
//  XLSize.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#ifndef XLSize_h
#define XLSize_h



#define KH  [UIScreen mainScreen].bounds.size.height
#define KW  [UIScreen mainScreen].bounds.size.width

#define PX KW / 375.0

#define PY KH / 667.0

#define X(a) a * PX

#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]


#endif /* XLSize_h */
