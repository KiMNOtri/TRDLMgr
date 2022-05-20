//
//  TRDownloadDialog.m
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/12.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import "TRDownloadDialog.h"

@interface TRDownloadDialog()
@property (weak) IBOutlet NSProgressIndicator *progressBar;
@property (weak) IBOutlet NSTextField *downloadInfo;
@property (weak) IBOutlet NSTableView *downloadInfoList;

@property int downloadCount;

@property NSMutableArray* dl_list;
@property NSMutableArray* finish_list;



@end


@implementation TRDownloadDialog

TRDownloadTable* table_view;

- (void) windowWillLoad {
    _mgr = [[TRDownloadManager alloc]init ];
    _downloadCount = 0;
    table_view = [TRDownloadTable new];
}

- (void) windowDidLoad {
    [self readyDownload];
    
    [_downloadInfoList setDelegate:table_view];
    [_downloadInfoList setDataSource:table_view];
    
}

- (IBAction)clickCancelButton:(id)sender {
    
    //[self.window endSheet:self.window returnCode:0];
    
    
    [self showStopDownloadMessage];
}

- (void) setDownloadListContent :(NSMutableArray*) array {
    [self setDl_list:array];
}

- (void) readyDownload {
    
    if(_dl_list.count <=0){
        [self showErrorMessage1];
    }
    
    [self createSingleDownloadTask:[self.dl_list objectAtIndex:_downloadCount]];
    
}

- (void) showErrorMessage1
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"好"];

    [alert setMessageText:@"下载错误"];
    [alert setInformativeText:@"未能获取到下载信息。"];
    [alert setAlertStyle:NSAlertStyleCritical];

    [alert runModal];
    
    [self close];

}

- (void) onDownloadTaskFinished
{
    _downloadCount ++;
    [self createSingleDownloadTask:[self.dl_list objectAtIndex:_downloadCount]];
}

- (void) showStopDownloadMessage
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"确定"];
    [alert addButtonWithTitle:@"取消"];
    [alert setMessageText:@"确定取消下载？"];
    [alert setInformativeText:@"下载过程将立即终止。"];
    [alert setAlertStyle:NSAlertStyleInformational];

    NSUInteger action = [alert runModal];
    if(action == NSAlertFirstButtonReturn){
        NSLog(@"Close Download Dialog ...");
        
        self.mgr = nil;
        [NSApp stopModalWithCode:0];
        [self close];
    } else {
        NSLog(@"Continue Download ...");
    }
}


- (void) addDownloadListLabel : (NSString*) data {

    [table_view addDataRow:data];
    [_downloadInfoList reloadData];

    
}

- (void) createMultiDownloadTask : (NSMutableArray*) a{
    
    
    
}

- (void) createSingleDownloadTask : (NSMutableDictionary*) f{
    NSString* info = [@"Download File : " stringByAppendingString:[f objectForKey:download_manifest_urladdress]];
    info = [info stringByAppendingString:@", Save Location: "];
    info = [info stringByAppendingString:[f objectForKey:download_manifest_filepath]];
    
    
    [self addDownloadListLabel:info];
    NSLog(@"Add Download Label");
    
    
    self->_progressBar.indeterminate = false;
    void(^dlProcessDisplay)(int) = ^(int value){
        self->_progressBar.doubleValue = (double)value;
    };
    
    void(^finishSingleDownloadTask)(void) = ^(void){
        self.downloadCount ++;
        if(self.downloadCount < [self.dl_list count]){
            
            self.downloadInfo.stringValue = [NSString stringWithFormat:@"正在下载 : 第 %d 个 / 共 %lu 个",self.downloadCount+1,(unsigned long)[self.dl_list count]];
            
            [self createSingleDownloadTask:[self.dl_list objectAtIndex:self.downloadCount]];
            NSLog(@"Start Download Task : %d / %lu",self.downloadCount,(unsigned long)[self.dl_list count]);
        } else {
            NSLog(@"All Download Task Finished.");
            self.downloadInfo.stringValue = @"所有下载已经完成";
        }
        
    };
    
    [_mgr startSingleDownloadTask:f :dlProcessDisplay :finishSingleDownloadTask];
}

@end


