//
//  UIImage+addition.h
//  iOS Demo
//
//  Created by yangpenghua on 2017/10/31.
//

#import <UIKit/UIKit.h>
typedef void (^GIFimageBlock)(UIImage *GIFImage);

@interface UIImage (addition)

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;

@end
