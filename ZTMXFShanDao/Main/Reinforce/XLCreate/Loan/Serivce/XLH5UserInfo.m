//
//  XLH5UserInfo.m
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/8/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLH5UserInfo.h"

@implementation XLH5UserInfo

static XLH5UserInfo * userInfo;
+(XLH5UserInfo *)sharedXLH5UserInfo
{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        userInfo = [[XLH5UserInfo alloc]init];
    });
    
    return userInfo;
}




@end
