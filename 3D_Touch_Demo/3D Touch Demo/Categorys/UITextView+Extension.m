//
//  UITextView+Extension.m
//  优品聚购
//
//  Created by 王永康 on 15/10/16.
//  Copyright © 2015年 王永康. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

//禁用 全选复制粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end
