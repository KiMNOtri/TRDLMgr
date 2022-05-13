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
@property (unsafe_unretained) IBOutlet NSTextView *downloadListTextView;
@property int downloadCount;


@property NSMutableArray* dl_list;

@end


@implementation TRDownloadDialog


- (void) windowWillLoad {
    _mgr = [[TRDownloadManager alloc]init ];
    _downloadCount = 0;
}

- (void) windowDidLoad {
    [self readyDownload];
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

    [alert setMessageText:@"下载错误 1"];
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
        

        [NSApp stopModalWithCode:0];
        [self close];
    } else {
        NSLog(@"Continue Download ...");
    }
}


- (void) addDownloadListLabel : (NSString*) data {
    /*NSTextField *testLabel = [[NSTextField alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [testLabel setDrawsBackground: false];
    [testLabel setEditable: false];
    [testLabel setStringValue:data];*/
    [self.downloadListTextView setEditable:true];
    [self.downloadListTextView insertText:data];
    [self.downloadListTextView insertText:@"\n"];
    [self.downloadListTextView setEditable:false];
}

- (void) createSingleDownloadTask : (NSMutableDictionary*) f{
    NSString* info = [@"下载文件 : " stringByAppendingString:[f objectForKey:download_manifest_urladdress]];
    info = [info stringByAppendingString:@", 保存路径: "];
    info = [info stringByAppendingString:[f objectForKey:@"filePath"]];
    [self addDownloadListLabel:info];
    self->_progressBar.indeterminate = false;
    void(^dlProcessDisplay)(int) = ^(int value){
        self->_progressBar.doubleValue = (double)value;
    };
    
    void(^finishSingleDownloadTask)(void) = ^(void){
        self.downloadCount ++;
        if(self.downloadCount < [self.dl_list count]){
            [self createSingleDownloadTask:[self.dl_list objectAtIndex:self.downloadCount]];
            NSLog(@"Start Download Task : %d / %lu",self.downloadCount,(unsigned long)[self.dl_list count]);
            self.downloadInfo.stringValue = [NSString stringWithFormat:@"正在下载 : 第 %d 个 / 共 %lu 个",self.downloadCount+1,(unsigned long)[self.dl_list count]];
        } else {
            NSLog(@"All Download Task Finished.");
            self.downloadInfo.stringValue = @"所有下载已经完成";
        }
        
    };
    
    [_mgr startSingleDownloadTask:f :dlProcessDisplay :finishSingleDownloadTask];
}

@end
