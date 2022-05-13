//
//  AppDelegate.m
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/12.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    [[NSBundle mainBundle] loadNibNamed:@"TRDemoWindow" owner:nil topLevelObjects:nil];
    
    
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
