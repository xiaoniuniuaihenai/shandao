//
//  UploadFileService.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "UploadFileService.h"

@interface UploadFileService ()

@property (nonatomic, strong) NSArray *fileDatas;
@property (nonatomic, assign) UploadFileType fileType;
@property (nonatomic, strong) NSDictionary * rqParameter;
@end

@implementation UploadFileService

- (instancetype)initWithFileData:(NSArray *)fileDatas andType:(UploadFileType)type andParameter:(NSDictionary*)rqParameter{
    self = [super init];
    if (self) {
        _fileType = type;
        _rqParameter = rqParameter;
        if (fileDatas && fileDatas.count > 0) {
            _fileDatas = fileDatas;
        }
    }
    return self;
}

- (NSString *)requestUrl{

    switch (_fileType) {
        case UploadFileTypeDef:{
            return @"/file/uploadFile.htm";
        }break;
        case UploadFileTypeYiTuFace:{
            return @"/file/uploadFace.htm";
        }
            break;
        case UploadFileTypeFaceForFace:{
            return @"/file/uploadFaceForFacePlus.htm";
            }break;
        default:
            break;
    }
}

- (NSString *)baseUrl{
    return UploadBaseUrl;
}
//超时时间
-(NSTimeInterval)requestTimeoutInterval{
    return 300.;
}
-(id)requestArgument{
    return _rqParameter;
}
- (AFConstructingBlock)constructingBodyBlock{

    AFConstructingBlock constructingBodyBlock = ^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSArray * imageNames = @[@"image_best.png",@"image_env.png",@"image_action1.png",@"image_action2.png",@"image_action3.png"];
        for (int i = 0; i < _fileDatas.count; i ++) {
            //  这个name需要和后天定义好, 不然上传会报错
            NSString *name = [NSString stringWithFormat:@"file"];
            //
            NSString *fileName = [NSString stringWithFormat:@"lsFenxin.png"];
            
//            fileName = imageNames[i];
            
            NSData *fileData = _fileDatas[i];
            if (fileData && [fileData isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            }
        }
    };
    return constructingBodyBlock;
}

@end
