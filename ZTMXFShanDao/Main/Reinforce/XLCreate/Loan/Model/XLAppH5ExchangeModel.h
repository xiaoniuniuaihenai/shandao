//
//  XLAppH5ExchangeModel.h
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/7/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
//150新增
@interface XLAppH5ExchangeModel : NSObject
/**
当前激活的渠道   APP H5
 */
@property (nonatomic, copy)NSString * activeChannel;
/**
 当前app版本
 */
@property (nonatomic, copy)NSString * appVersion;
/**
 h5页面URL
 */
@property (nonatomic, copy)NSString * h5Url;


@end
