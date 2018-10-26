//
//  LSZhiMaAuthApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSZhiMaAuthApi.h"

@implementation LSZhiMaAuthApi



/**  之前  */
//-(NSString*)requestUrl{
//    return @"/auth/getZhiMaUrl";
//}

-(id)requestArgument{
    return @{};
}


-(NSString*)requestUrl{
    return @"/auth/getAuthZmUrl";
}
@end
