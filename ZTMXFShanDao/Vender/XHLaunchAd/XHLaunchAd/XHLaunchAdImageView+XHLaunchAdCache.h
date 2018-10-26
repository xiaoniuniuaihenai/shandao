//
//  XHLaunchAdImageView+XHLaunchAdCache.h
//  XHLaunchAdExample
//

#import "XHLaunchAdView.h"
#import "XHLaunchAdImageManager.h"

@interface XHLaunchAdImageView (XHLaunchAdCache)

/**
 设置url图片

 @param url 图片url
 */
- (void)xh_setImageWithURL:(nonnull NSURL *)url;

/**
 设置url图片

 @param url 图片url
 @param placeholder 占位图
 */
- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

/**
 设置url图片

 @param url 图片url
 @param placeholder 占位图
 @param options XHLaunchAdImageOptions
 */
- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(XHLaunchAdImageOptions)options;

/**
 设置url图片

 @param url 图片url
 @param placeholder 占位图
 @param completedBlock XHExternalCompletionBlock
 */
- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable XHExternalCompletionBlock)completedBlock;

/**
 设置url图片

 @param url 图片url
 @param completedBlock XHExternalCompletionBlock
 */
- (void)xh_setImageWithURL:(nonnull NSURL *)url completed:(nullable XHExternalCompletionBlock)completedBlock;


/**
 设置url图片

 @param url 图片url
 @param placeholder 占位图
 @param options XHLaunchAdImageOptions
 @param completedBlock XHExternalCompletionBlock
 */
- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(XHLaunchAdImageOptions)options completed:(nullable XHExternalCompletionBlock)completedBlock;

/**
 设置url图片

 @param url 图片url
 @param placeholder 占位图
 @param GIFImageCycleOnce gif是否只循环播放一次
 @param options XHLaunchAdImageOptions
 @param completedBlock XHExternalCompletionBlock
 */
- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder GIFImageCycleOnce:(BOOL)GIFImageCycleOnce options:(XHLaunchAdImageOptions)options completed:(nullable XHExternalCompletionBlock)completedBlock;

@end
