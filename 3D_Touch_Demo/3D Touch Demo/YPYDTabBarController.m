//
//  YPYDTabBarController.m
//  3D Touch Demo
//
//  Created by 王永康 on 15/7/16.
//  Copyright (c) 2015年 王永康. All rights reserved.
//

//主控制器
#import "YPYDTabBarController.h"
//导航控制器
#import "YPYDNavigationController.h"
//首页控制器
#import "YPYDHomeViewController.h"
//专区控制器
#import "YPYDAreaViewController.h"

//购物车
#import "YPYDShoppingCartController.h"
//我的U

#import "YPYDMineUViewController.h"

#import "YPYDSearchController.h"

@interface YPYDTabBarController ()<UITabBarControllerDelegate>

@end

@implementation YPYDTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    //添加子控制器
    [self addAllChildVcs];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationShortcutItemResponse) name:@"YPYD.UITouchText.home" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationShortcutItemResponse) name:@"YPYD.UITouchText.search" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationShortcutItemResponse) name:@"YPYD.UITouchText.cart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationShortcutItemResponse) name:@"YPYD.UITouchText.myU" object:nil];
    
}

/**
 * 添加子控制器
 */
- (void)addAllChildVcs
{
    //添加首页控制器
    YPYDHomeViewController * home = [[YPYDHomeViewController alloc] init];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    //添加我的专区控制器   目前不跳转
    YPYDAreaViewController * areaController = [[YPYDAreaViewController alloc] init];
    [self addOneChildVc:areaController title:@"我的专区" imageName:@"tabbar_area" selectedImageName:@"tabbar_area_selected"];
    
    YPYDShoppingCartController * shoppingCart = [[YPYDShoppingCartController alloc] init];
    [self addOneChildVc:shoppingCart title:@"购物车" imageName:@"tabbar_shoppingcart" selectedImageName:@"tabbar_shoppingcart_selected"];
    
    //添加我的U 控制器
    YPYDMineUViewController * mineU = [[YPYDMineUViewController alloc] init];
    [self addOneChildVc:mineU title:@"我的U" imageName:@"tabbar_mine" selectedImageName:@"tabbar_mine_selected"];
}

/*
 *  添加一个子控制器
 *  @param childVc              子控制器对象
 *  @param title                标题
 *  @param imageName            常态图片
 *  @param selectedIamgeName    选中状态图片
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    if ([title isEqualToString:@""])
    {
        childVc.view.backgroundColor = [UIColor orangeColor];
        
    }
    //同时   设置 tabBarItem  和 navigationItem 标题
    childVc.title = title;
    
    //设置常态的图片
    if (![imageName isEqualToString:@""])
    {
        childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    }
    //设置常态的字体字号 、颜色
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置选中的字体颜色
    NSMutableDictionary * SelectTextAttrs = [NSMutableDictionary dictionary];
    SelectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:SelectTextAttrs forState:UIControlStateSelected];
    
    //设置选中状态的图片
    UIImage * selectedImage;
    if (![selectedImageName isEqualToString:@""])
    {
        selectedImage =  [UIImage imageWithName:selectedImageName];
    }
    //在选中时，要想显示原图，就必须得告诉电脑，不要渲染
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.tintColor = [UIColor colorWithRed:255/255 green:138/255 blue:0/255 alpha:1];
    YPYDNavigationController * nav = [[YPYDNavigationController alloc] initWithRootViewController:childVc];
    
    //添加控制器到TabBar控制器
    [self addChildViewController:nav];
}

// 3DTouch
- (void)applicationShortcutItemResponse
{
    YPYDNetCountManager * sharedNetCountManager = [YPYDNetCountManager sharedNetCountManager];
    // 配合系统  判断是否已经完成登录方法
    //    YPYDLog(@"netGoodsListCount  %d", sharedNetCountManager.hadAutoLogin);
    //    if (!sharedNetCountManager.hadAutoLogin)
    //    {
    //        return;
    //    }
    
    //首页
    if([ sharedNetCountManager.applicationShortcutItemTitle isEqualToString:@"YPYD.UITouchText.home"])
    {
        self.selectedIndex = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UITouchText.home" object:nil userInfo:nil];
    }
    //搜索商品
    if([ sharedNetCountManager.applicationShortcutItemTitle isEqualToString:@"YPYD.UITouchText.search"])
    {
        self.selectedIndex = 0;
        
        YPYDSearchController * searchController = [[YPYDSearchController alloc] init];
        searchController.navigationItem.title = @"搜索";
        YPYDLog(@"self.selectedViewController  %@", self.selectedViewController.childViewControllers[0]);
        [self.selectedViewController.childViewControllers[0].navigationController pushViewController:searchController animated:YES];
    }
    //购物车
    if([ sharedNetCountManager.applicationShortcutItemTitle isEqualToString:@"YPYD.UITouchText.cart"])
    {
        self.selectedIndex = 2;
    }
    //我的 U
    if([ sharedNetCountManager.applicationShortcutItemTitle isEqualToString:@"YPYD.UITouchText.myU"])
    {
        self.selectedIndex = 3;
    }
}



@end
