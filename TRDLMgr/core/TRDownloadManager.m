//
//  TRDownloadManager.m
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/12.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import "TRDownloadManager.h"

@interface TRDownloadManager()

@property(nonatomic) AFURLSessionManager *manager;


@end


@implementation TRDownloadManager

- (instancetype) init {
    self = [super init];
    
    _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"[TRDownloadManager] Init AFNetworking Finished.");
    return self;
}

- (void) startSingleDownloadTask :(NSMutableDictionary*) data :(void(^)(int)) dlProcessFun : (void(^)(void)) completeHandler {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@", [data objectForKey: download_manifest_urladdress]];

    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSString *path = [data objectForKey:download_manifest_filepath];
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    NSLog(@"Ready to download : fileName:%@ filePath:%@",[data objectForKey:download_manifest_urladdress],[data objectForKey:download_manifest_filepath]);

    NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"Download Process : %.0f％", downloadProgress.fractionCompleted * 100);
        dispatch_async(dispatch_get_main_queue(), ^{
            dlProcessFun(downloadProgress.fractionCompleted * 100);
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            //NSLog(@"%@",fullPath);
            return [NSURL fileURLWithPath:filePath];

                
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"Download Finished.");
        NSLog(@"File Save Path : %@",filePath);
         //[self extract];
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler();
        });
        
    }];
     [downloadTask resume];
}

@end
