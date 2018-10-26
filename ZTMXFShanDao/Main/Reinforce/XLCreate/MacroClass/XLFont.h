//
//  XLFont.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#ifndef XLFont_h
#define XLFont_h


#define FONT_SYSTEM(A) [UIFont systemFontOfSize:A]


#define FONT_FINE(A) [UIFont fontWithName:@"PingFangSC-light" size:A]?[UIFont fontWithName:@"PingFangSC-light" size:A]:[UIFont systemFontOfSize:A]

#define FONT_LIGHT(A)  [UIFont fontWithName:@"PingFangSC-light" size:A]?[UIFont fontWithName:@"PingFangSC-light" size:A]:[UIFont systemFontOfSize:A]

#define FONT_Regular(A) [UIFont fontWithName:@"PingFangSC-Regular" size:A]?[UIFont fontWithName:@"PingFangSC-Regular" size:A]:[UIFont systemFontOfSize:A]

#define FONT_Medium(A) [UIFont fontWithName:@"PingFangSC-Medium" size:A]?[UIFont fontWithName:@"PingFangSC-Medium" size:A]:[UIFont systemFontOfSize:A]


#endif /* XLFont_h */
