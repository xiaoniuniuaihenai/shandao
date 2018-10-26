//
//  LSUploadIdfImgeResultApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSUploadIdfImgeResultApi.h"
@interface LSUploadIdfImgeResultApi ()
@property (nonatomic,copy) NSString * uploadType;
@property (nonatomic,copy) NSString * uploadResult;

@end

@implementation LSUploadIdfImgeResultApi
-(instancetype)initUploadWithType:(NSString*)type andResult:(NSString*)result{
    if (self = [super init]) {
        _uploadType = type;
        _uploadResult = result;
    }
    return self;
}



-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    [dicRq setValue:_uploadType forKey:@"type"];
    [dicRq setValue:_uploadResult forKey:@"result"];
    return dicRq;
}

-(NSString*)requestUrl{
    return @"/auth/uploadIdNumberResult";
}
@end
