//
//  TRDownloadTable.m
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/20.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import "TRDownloadTable.h"

@implementation TRDownloadTable

NSMutableArray* messageList;

- (void) addDataRow: (NSString*) data
{
    [messageList addObject:data];
    
}

- (instancetype) init {
    self = [super init];
    messageList = [NSMutableArray new];
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [messageList count];
}
 
- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [messageList objectAtIndex:row];
    
}


@end
