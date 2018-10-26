//
//  LSAuthSupplyApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  补充认证 获取补充认证  id 

#import "BaseRequestSerivce.h"
@interface LSAuthSupplyApi : BaseRequestSerivce
-(instancetype )initWithSupplyType:(AuthSupplyType)supplyType;
@end
