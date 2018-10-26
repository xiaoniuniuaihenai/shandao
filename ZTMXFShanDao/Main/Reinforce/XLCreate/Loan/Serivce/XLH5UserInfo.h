//
//  XLH5UserInfo.h
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/8/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLH5UserInfo : NSObject

@property (nonatomic, copy)NSDictionary * pointInfo_H5;
+(XLH5UserInfo *)sharedXLH5UserInfo;


@end
