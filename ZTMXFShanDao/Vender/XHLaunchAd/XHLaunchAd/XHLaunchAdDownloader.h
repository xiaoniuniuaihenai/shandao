//
//  XHLaunchAdDownloaderManager.h
//  XHLaunchAdExample
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - XHLaunchAdDownload

typedef void(^XHLaunchAdDownloadProgressBlock)(unsigned long long total, unsigned long long current);
typedef void(^XHLaunchAdDownloadImageCompletedBlock)(UIImage *_Nullable image, NSData * _Nullable data, NSError * _Nullable error);
typedef void(^XHLaunchAdDownloadVideoCompletedBlock)(NSURL * _Nullable location, NSError * _Nullable error);
typedef void(^XHLaunchAdBatchDownLoadAndCacheCompletedBlock) (NSArray * _Nonnull completedArray);

@protocol XHLaunchAdDownloadDelegate <NSObject>

- (void)downloadFinishWithURL:(nonnull NSURL *)url;

@end

@interface XHLaunchAdDownload : NSObject
@property (assign, nonatomic ,nonnull)id<XHLaunchAdDownloadDelegate> delegate;
@end

@interface XHLaunchAdImageDownload : XHLaunchAdDownload

@end

@interface XHLaunchAdVideoDownload : XHLaunchAdDownload

@end

#pragma mark - XHLaunchAdDownloader
@interface XHLaunchAdDownloader : NSObject

+(nonnull instancetype )sharedDownloader;

- (void)downloadImageWithURL:(nonnull NSURL *)url progress:(nullable XHLaunchAdDownloadProgressBlock)progressBlock completed:(nullable XHLaunchAdDownloadImageCompletedBlock)completedBlock;

- (void)downLoadImageAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray;
- (void)downLoadImageAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray completed:(nullable XHLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;

- (void)downloadVideoWithURL:(nonnull NSURL *)url progress:(nullable XHLaunchAdDownloadProgressBlock)progressBlock completed:(nullable XHLaunchAdDownloadVideoCompletedBlock)completedBlock;

- (void)downLoadVideoAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray;
- (void)downLoadVideoAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray completed:(nullable XHLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;

@end

