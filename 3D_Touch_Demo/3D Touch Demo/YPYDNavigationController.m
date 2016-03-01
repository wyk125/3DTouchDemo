//
//  YPYDNavigationController.m
//  优品悦动
//
//  Created by 王永康 on 15/7/16.
//  Copyright (c) 2015年 王永康. All rights reserved.
//

#import "YPYDNavigationController.h"
//#import "YPYDTitleButton.h"

@interface YPYDNavigationController ()

@end

@implementation YPYDNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
/**
 *  当第一次使用这个类 的时候调用
 */
+ (void)initialize
{
    //设置UIBarButtonItemTheme 的  主题
    [self setupNavigationItemTheme];
    //设置UINavigationBarTheme 的  主题
    [self setupNavigationBarTheme];
    
    //设置UIBarButtonItemTheme 的  主题
    [self setupBarButtonItemTheme];
}
//过期： 并不代表不可以用，高版本可以兼容低版本的 属性 和方法

+ (void)setupNavigationItemTheme
{
    // 通过 appearance对象 修改整个项目中所有的uIBarButtonItem 的样式
    UINavigationBar * appearance = [UINavigationBar appearance];
    /** 设置文字属性  **/
    // 设置普通状态的的文字属性
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    textAttrs[NSForegroundColorAttributeName] =[UIColor orangeColor];
    [appearance setTitleTextAttributes:textAttrs];

}

/**
 *  设置UINavigationBarTheme 的  主题
 */
+ (void)setupNavigationBarTheme
{
    // 通过 appearance对象 修改整个项目中所有的uIBarButtonItem 的样式
    UIBarButtonItem * appearance = [UIBarButtonItem appearance];
    // 设置普通状态的的文字属性
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    
    //设置文字属性
    [appearance  setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

/**
 *  设置UIBarButtonItemTheme 的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过 appearance对象 修改整个项目中所有的uIBarButtonItem 的样式
    UIBarButtonItem * appearance = [UIBarButtonItem appearance];
    
    /** 设置文字属性  **/
    // 设置普通状态的的文字属性
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的的文字属性
    NSMutableDictionary * highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    // 设置不可用状态的的文字属性
    NSMutableDictionary * disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}
/**
 *  能拦截所有的push进来的子控制器
 *
 *  @param viewController push进来的控制器
 *  @param animated
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel * navTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    navTitleLab.text =  self.navigationItem.title;
    navTitleLab.textColor = [UIColor orangeColor];
    navTitleLab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navTitleLab;
    [self.navigationBar setTintColor:[UIColor orangeColor]];
   
    //    WYKLog(@"%@  %ld",viewController,self.viewControllers.count);
    //非栈底控制器
    if (self.viewControllers.count > 0)
    {
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

//回到根控制器
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//// 导航控制器消失
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    [self navigationController:self.navigationController willShowViewController:self animated:NO];
//}
////// 导航控制器出现
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:YES];
//    [self navigationController:self.navigationController willShowViewController:self animated:YES];
//}
//
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if(viewController == self)
//    {
//        [self.navigationController setNavigationBarHidden:YES animated:animated];
//    }
//    else
//    {
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    }
//}


@end