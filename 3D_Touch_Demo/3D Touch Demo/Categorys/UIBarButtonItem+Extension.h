//
//  UIBarButtonItem+Extension.h
//  优品悦动
//
//  Created by 王永康 on 15/7/16.
//  Copyright (c) 2015年 王永康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
