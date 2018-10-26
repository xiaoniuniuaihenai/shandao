//
//  UploadImagesService.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/29.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface UploadImagesService : BaseRequestSerivce

- (instancetype)initWithImageDatas:(NSArray *)imageDatas;

@end
