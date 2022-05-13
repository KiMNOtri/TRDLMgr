//
//  TRDownloadManager.h
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/12.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <AFNetworking/AFNetworking.h>



static NSString* _Nullable download_manifest_urladdress = @"urlAddress";
static NSString* _Nullable download_manifest_filepath = @"filePath";
static NSString* _Nullable download_manifest_filesha = @"fileSHA";

NS_ASSUME_NONNULL_BEGIN



@interface TRDownloadManager : NSObject

- (void) startSingleDownloadTask :(NSMutableDictionary*) data :(void(^)(int)) dlProcessFun : (void(^)(void)) completeHandler;

@end

NS_ASSUME_NONNULL_END
