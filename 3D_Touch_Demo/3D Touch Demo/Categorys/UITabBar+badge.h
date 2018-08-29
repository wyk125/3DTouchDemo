//
//  UITabBar+badge.h
//  3D Touch Demo
//
//  Created by 王永康 on 15/8/13.
//  Copyright (c) 2015年 王永康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)


- (void)showBadgeOnItemIndex:(int)index andString:(NSString *)number;

- (void)hideBadgeOnItemIndex:(int)index;

- (void)removeBadgeOnItemIndex:(int)index;

@end
