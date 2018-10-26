//
//  LSMineOtherInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/10.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMineOtherInfoModel : NSObject

/** 理财url */
@property (nonatomic, copy) NSString *myFinancing;
/** 是否显示理财 1显示, 0不显示 */
@property (nonatomic, assign) NSInteger financSwitch;
/** 服务中心url */
@property (nonatomic, copy) NSString *serviceCentre;

@end
