//
//  UploadImagesService.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/29.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "UploadImagesService.h"

@interface UploadImagesService ()

@property (nonatomic, strong) NSArray *imageDatas;

@end

@implementation UploadImagesService

- (instancetype)initWithImageDatas:(NSArray *)imageDatas{
    self = [super init];
    if (self) {
        if (imageDatas && imageDatas.count > 0) {
            _imageDatas = imageDatas;
        }
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/file/uploadImageCutAndCompress.htm";
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
            //  这个name需要和后天定义好, 不然上传会报错
            NSString *name = [NSString stringWithFormat:@"file"];
            NSString *fileName = [NSString stringWithFormat:@"fenXinXinyong.png"];
            NSData *fileData = _imageDatas[i];
            if (fileData && [fileData isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            }
        }
    };
    return constructingBodyBlock;
}

@end
