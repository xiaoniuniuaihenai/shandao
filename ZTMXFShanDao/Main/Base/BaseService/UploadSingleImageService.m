//
//  UploadSingleImageService.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/29.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "UploadSingleImageService.h"

@interface UploadSingleImageService ()

@property (nonatomic, strong) NSArray *imageDatas;
@property (nonatomic, assign) UploadSingleType uploadType;
@property (nonatomic, strong  ) NSArray * arrFileName;
@end

@implementation UploadSingleImageService

- (instancetype)initWithImageDatas:(NSArray *)imageDatas andUploadType:(UploadSingleType)uploadType andFileName:(NSArray * )arrFileName
{
    self = [super init];
    if (self) {
        _uploadType = uploadType;
        _arrFileName = arrFileName;
        if (imageDatas && imageDatas.count > 0) {
            _imageDatas = imageDatas;
        }
    }
    return self;
}

- (NSString *)requestUrl{
    switch (_uploadType) {
        case UploadSingleTypeAvata:{
           return @"/file/uploadAvataImage.htm";
        }
            break;
        case UploadSingleTypeYiTuIdCard:{
            return @"/file/uploadIdNumberCard.htm";
        }
            break;
        case UploadSingleTypeFile:{
            return @"/file/uploadFile.htm";
        }
            break;
        case UploadSingleTypeFaceIdCard:{
            return @"/file/uploadIdNumberCardForFacePlus.htm";
        };
        default:
            break;
    }
    
//    return @"/file/uploadAvataImage.htm";
}

- (NSString *)baseUrl{
    return UploadBaseUrl;
}
//超时时间
-(NSTimeInterval)requestTimeoutInterval{
    return 300.;
}
- (AFConstructingBlock)constructingBodyBlock{
    
    AFConstructingBlock constructingBodyBlock = ^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < _imageDatas.count; i ++) {
            //  这个name需要和后台定义好, 不然上传会报错
            NSString *name = [NSString stringWithFormat:@"file"];
            //  fileName这个是设置上传的是图片
            
            NSString *fileName = @"lsFenxin.png";
            if (_arrFileName.count>i) {
                fileName = _arrFileName[i];
            }
            NSData *fileData = _imageDatas[i];
            
            if (fileData && [fileData isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            }
        }
    };
    return constructingBodyBlock;
}

@end
