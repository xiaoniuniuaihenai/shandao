//
//  LSGetResourceApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSGetResourceApi.h"

@implementation LSGetResourceApi

-(NSString*)requestUrl{
    return @"/hidden/getResourceByType";
}



-(id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:@"white_pending_review" forKey:@"type"];
    
    return paramDict;
}

@end
