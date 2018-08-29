//
//  YPYDPOPTestViewController1.m
//  3D Touch Demo
//
//  Created by 王永康 on 16/1/27.
//  Copyright © 2016年 王永康. All rights reserved.
//

#import "YPYDPOPTestViewController1.h"
#import "YPYDPOPTestViewController2.h"

@interface YPYDPOPTestViewController1 ()<UIViewControllerPreviewingDelegate>

@end

@implementation YPYDPOPTestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YPYDColor(120, 200, 150, 1);
    // Do any additional setup after loading the view.
}
//预览页面 底部Action Items
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *p1 =[UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {        NSLog(@"点击了分享");    }];
    UIPreviewAction *p2 =[UIPreviewAction actionWithTitle:@"收藏" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {        NSLog(@"点击了收藏");    }];
    NSArray *actions = @[p1,p2];
    
    return actions;
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0)
{
    YPYDPOPTestViewController2 * vc = [[YPYDPOPTestViewController2 alloc] init];
    return vc;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0)
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
