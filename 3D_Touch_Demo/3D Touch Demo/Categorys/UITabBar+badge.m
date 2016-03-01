//
//  UITabBar+badge.m
//  优品悦动
//
//  Created by 王永康 on 15/8/13.
//  Copyright (c) 2015年 王永康. All rights reserved.
//

#import "UITabBar+badge.h"

#define TabbarItemNums 5.0    //tabbar的数量


@implementation UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index andString:(NSString *)number
{
    
    [self removeBadgeOnItemIndex:index];
    
    UILabel *badgeView = [[UILabel alloc]init];
    
    badgeView.tag = 888 + index;
    
    badgeView.layer.cornerRadius = 5;
    
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.text = number;
    badgeView.textColor = [UIColor whiteColor];
    badgeView.font = [UIFont systemFontOfSize:13];
    badgeView.textAlignment = NSTextAlignmentCenter;
    CGRect tabFrame = self.frame;
    
    float percentX = (index +0.6) / TabbarItemNums;
    
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    
    badgeView.frame = CGRectMake(x, y, 20, 20);
    
    //告诉layer将位于它之下的layer都覆盖住
    badgeView.layer.masksToBounds = YES;
    //设置layer的圆角 ,刚好是自身宽度的一半，这样就形成一个圆形
    badgeView.layer.cornerRadius = badgeView.bounds.size.width * 0.5;
    // 设置圆形的边界宽度为1.0
    badgeView.layer.borderWidth = 1.0;
    // 设置边界的颜色
    badgeView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index
{
    
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
        }
    }
}

@end