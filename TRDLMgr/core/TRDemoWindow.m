//
//  TRDemoWindow.m
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/12.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import "TRDemoWindow.h"
#import "TRJavaCheck.h"

@interface TRDemoWindow()
@property TRDownloadDialog* trDownloadDialog;
@property TRJavaCheck* trJavaCheck;
@end

@implementation TRDemoWindow


- (IBAction)clickDownloadButton:(id)sender {

    //[[NSBundle mainBundle] loadNibNamed:@"TRDownloadDialog" owner:nil topLevelObjects:nil];
    self.trDownloadDialog = [[TRDownloadDialog alloc] initWithWindowNibName:@"TRDownloadDialog"];
    
    NSMutableArray* arr = [NSMutableArray new];

    
    NSMutableDictionary* dic1 = [NSMutableDictionary new];
    NSString* filereadyPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/Downloads"];
    [dic1 setObject:filereadyPath forKey:download_manifest_filepath];
    [dic1 setObject:@"https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png" forKey:download_manifest_urladdress];
    [arr addObject:dic1];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary new];
    [dic2 setObject:filereadyPath forKey:download_manifest_filepath];
    [dic2 setObject:@"https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png" forKey:download_manifest_urladdress];
    [arr addObject:dic2];
    
    NSMutableDictionary* dic3 = [NSMutableDictionary new];
    [dic3 setObject:filereadyPath forKey:download_manifest_filepath];
    [dic3 setObject:@"https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png" forKey:download_manifest_urladdress];
    [arr addObject:dic3];
    
    NSMutableDictionary* dic4 = [NSMutableDictionary new];
    [dic4 setObject:filereadyPath forKey:download_manifest_filepath];
    [dic4 setObject:@"https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png" forKey:download_manifest_urladdress];
    [arr addObject:dic4];
    
    
    
    [self.trDownloadDialog setDownloadListContent:arr];
    [self.window beginSheet:self.trDownloadDialog.window completionHandler:nil];
    NSModalResponse returnCodeValue = [NSApp runModalForWindow:self.trDownloadDialog.window];
    NSLog(@"Delete Download Window ...");
    self.trDownloadDialog = nil;
    
}

- (IBAction)clickCreateFolder:(id)sender {
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString* path = NSHomeDirectory();
    path = [path stringByAppendingString:@"/Documents/Downloads"];
    BOOL a = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSLog(@"Create Folder : %@ , status : %d",path,a);
    
    self.trJavaCheck = [TRJavaCheck new];
    NSString* reply = [_trJavaCheck detectJavaLocation];
    NSLog(reply);
}



@end
