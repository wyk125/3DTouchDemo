//
//  UIBarButtonItem+Extension.m
//  优品悦动
//
//  Created by 王永康 on 15/7/16.
//  Copyright (c) 2015年 王永康. All rights reserved.
//
//类扩展
#import "UITabBar+badge.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    if (![imageName isEqualToString:@""]) {
        [button setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    }
    
    if (![highImageName isEqualToString:@""]) {
         [button setBackgroundImage:[UIImage imageWithName:highImageName] forState:UIControlStateHighlighted];
    }
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
