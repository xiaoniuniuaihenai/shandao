//
//  LSGetFaceType.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSGetFaceType.h"

@implementation LSGetFaceType

-(id)requestArgument{
    return @{};
}



-(NSString*)requestUrl{
    return @"/auth/getFaceType";
}
@end
