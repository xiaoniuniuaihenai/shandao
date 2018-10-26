//
//  LSAuthMaidianApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthMaidianApi.h"
@interface LSAuthMaidianApi()
@property (nonatomic,assign) AuthMaidianType authType;
@end
@implementation LSAuthMaidianApi
-(instancetype)initWithType:(AuthMaidianType)authType{
    if (self = [super init]) {
        _authType = authType;
    }
    return self;
}

-(id)requestArgument{
    NSMutableDictionary * dicRq = [[NSMutableDictionary alloc]init];
    switch (_authType) {
        case AuthMaidianTypeBeforeSubmitIdInfo:
        {
            [dicRq setValue:@"beforeSubmitIdInfo" forKey:@"maidianEvent"];
        }
            break;
        case AuthMaidianTypeIdFrontScan:
        {
            [dicRq setValue:@"idFrontScan" forKey:@"maidianEvent"];
        }
            break;
        case AuthMaidianTypeIdBackScan:
        {
            [dicRq setValue:@"idBackScan" forKey:@"maidianEvent"];
        }
            break;
        case AuthMaidianTypeFaceRecognition:
        {
            [dicRq setValue:@"faceRecognition" forKey:@"maidianEvent"];
        }
            break;
        case AuthMaidianTypeBindBankCard:
        {
            [dicRq setValue:@"bindBankCard" forKey:@"maidianEvent"];
        }
            break;
        case AuthMaidianTypeFaceIdFrontScan:
        {
            [dicRq setValue:@"idFacePlusFrontScan" forKey:@"maidianEvent"];
        }
            break;
        case AuthMaidianTypeFaceIdBackScan:
        {
            [dicRq setValue:@"idFacePlusBackScan" forKey:@"maidianEvent"];
        }
            break;
        case AuthMaidianTypeFaceFaceRecognition:
        {
            [dicRq setValue:@"facePlusRecognition" forKey:@"maidianEvent"];
        }
            break;
        default:
            break;
    }
    return dicRq;
}

-(NSString*)requestUrl{
    return @"/auth/maidian";
}
@end
