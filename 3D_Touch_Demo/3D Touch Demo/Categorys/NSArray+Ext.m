//
//  NSArray+Ext.m
// 
//
//  Created by xiaozhe on 15/4/9.
//  Copyright (c) 2015年 王永康. All rights reserved.
//

#import "NSArray+Ext.h"

@implementation NSArray (Ext)

//数组没有对打印本地化中文做处理
//重写数组本地化打印方法即可
- (NSString *)descriptionWithLocale:(id)locale
{
    
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"(\n"];
    
    for (id obj in self) {//self 就是数组本身
        
        [str appendFormat:@"\t%@,\n", obj];//\t是缩进 \n是换行
    }
    
    [str appendString:@")"];
    
    return str;
}

@end
