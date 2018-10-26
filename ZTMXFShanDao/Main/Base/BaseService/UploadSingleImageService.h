//
//  UploadSingleImageService.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/29.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//
typedef NS_ENUM(NSInteger,UploadSingleType){
    UploadSingleTypeAvata = 0,
    UploadSingleTypeYiTuIdCard,
    UploadSingleTypeFile,
    UploadSingleTypeFaceIdCard,
};
#import "BaseRequestSerivce.h"
@interface UploadSingleImageService : BaseRequestSerivce

- (instancetype)initWithImageDatas:(NSArray *)imageDatas andUploadType:(UploadSingleType)uploadType andFileName:(NSArray * )arrFileName;

@end
