//
//  YPYDNetCountManager.m
//  3D Touch Demo
//
//  Created by 王永康 on 15/10/28.
//  Copyright © 2015年 王永康. All rights reserved.
//

#import "YPYDNetCountManager.h"

@implementation YPYDNetCountManager

+ (YPYDNetCountManager *)sharedNetCountManager
{
    static YPYDNetCountManager * sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[YPYDNetCountManager alloc] init];
        sharedAccountManagerInstance.netWorkingCount = 0;
        sharedAccountManagerInstance.applicationShortcutItemTitle = @"YPYD";
        sharedAccountManagerInstance.hadAutoLogin = NO;
        sharedAccountManagerInstance.tokenLostedAlratCount = 0;
        });
    return sharedAccountManagerInstance;
}
@end
