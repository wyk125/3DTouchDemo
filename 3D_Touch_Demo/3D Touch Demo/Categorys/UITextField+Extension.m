//
//  UITextField+Extension.m
//  优品聚购
//
//  Created by 王永康 on 15/10/16.
//  Copyright © 2015年 王永康. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end
