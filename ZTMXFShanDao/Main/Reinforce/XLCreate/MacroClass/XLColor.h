//
//  XLColor.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#ifndef XLColor_h
#define XLColor_h


#define COLOR_SRT(STR) [UIColor colorWithHexString:STR]

#define K_BackgroundColor  [UIColor colorWithHexString:@"#F2F2F2"]

#define K_NavColor  [UIColor whiteColor]




#define K_MainColor  [UIColor colorWithHexString:@"#FCDF23"] // FDDB00 FC514E

#define K_GoldenColor  [UIColor colorWithHexString:@"#F5A623"]

#define K_BtnTitleColor  [UIColor colorWithHexString:@"#31372B"]

#define K_EC5346Color  [UIColor colorWithHexString:@"#EC5346"]
//f2f4f5
#define K_LineColor  [UIColor colorWithHexString:@"#f2f4f5"]
//666666
#define K_666666  [UIColor colorWithHexString:@"#666666"]
//333333
#define K_333333  [UIColor colorWithHexString:@"#333333"]
//#888888
#define K_888888  [UIColor colorWithHexString:@"#888888"]
//#B8B8B8
#define K_B8B8B8 [UIColor colorWithHexString:@"#B8B8B8"]
// #31372B
#define K_31372B [UIColor colorWithHexString:@"#31372B"]
//333333
#define K_CCCCCC  [UIColor colorWithHexString:@"#CCCCCC"]
//FFA531   2B91F0 蓝色
#define K_2B91F0  [UIColor colorWithHexString:@"#2B91F0"]

//FFFFFF
#define K_FFFFFF  [UIColor colorWithHexString:@"#FFFFFF"]



#define RGB_COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0  blue:B/255.0  alpha:A]

#if 1 //条件编译  if  else   endif   语法当if条件为1的时候,表示可以执行if里内容,当为0的时候,执行else   endif表示结束

#define DEBUG_COLOR [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]
#else

#define DEBUG_COLOR  [UIColor clearColor]

#endif



#endif /* XLColor_h */
