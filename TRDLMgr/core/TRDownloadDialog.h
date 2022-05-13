//
//  TRDownloadDialog.h
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/12.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "TRDownloadManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TRDownloadDialog : NSWindowController

@property(nonatomic) TRDownloadManager* mgr;

- (void) setDownloadListContent :(NSMutableArray*) array;

@end

NS_ASSUME_NONNULL_END
