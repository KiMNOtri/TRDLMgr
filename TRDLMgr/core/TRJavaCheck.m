//
//  TRJavaCheck.m
//  TRDLMgr
//
//  Created by Ki MNO on 2022/5/13.
//  Copyright © 2022 TRIStudio. All rights reserved.
//

#import "TRJavaCheck.h"

@implementation TRJavaCheck


- (NSString*) detectJavaLocation
{
        NSTask *shellTask = [[NSTask alloc]init];
        [shellTask setLaunchPath:@"/bin/sh"];
        NSString *shellStr = @"java -verbose";
       

    //-c 表示将后面的内容当成shellcode来执行

        [shellTask setArguments:[NSArray arrayWithObjects:@"-c",shellStr, nil]];
         
        NSPipe *pipe = [[NSPipe alloc]init];
        [shellTask setStandardOutput:pipe];
         
        [shellTask launch];
         
        NSFileHandle *file = [pipe fileHandleForReading];
        NSData *data =[file readDataToEndOfFile];
        NSString *strReturnFromShell = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"The return content from shell script is: %@",strReturnFromShell);
    
     NSRange range = [self extractTitleRangeWithString:strReturnFromShell];
       //获取第一次以换行结束的字符串
       NSString *resultString = [strReturnFromShell substringWithRange:range];
       //去除字符串首尾的空格和换行符
       NSString *title = [resultString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
       return title;
    
}

- (NSRange)extractTitleRangeWithString:(NSString *)containerString{
    /**
     \s 匹配任意的空白符
     *  重复零次或更多次
     .  匹配除换行符以外的任意字符
     组合起来就是，拿到空白字符，任意字符，空白字符的组合了。
     
     这和iphone中备忘录的处理方式相同
     */
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s*.*\\s*"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSTextCheckingResult *result = [regex firstMatchInString:containerString options:NSMatchingReportCompletion range:NSMakeRange(0, containerString.length)];
    
    return result.range;
}

@end



