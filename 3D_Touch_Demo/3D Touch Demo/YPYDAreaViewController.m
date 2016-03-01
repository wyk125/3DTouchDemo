//
//  YPYDAreaViewController.m
//  3D Touch Demo
//
//  Created by 王永康 on 16/1/27.
//  Copyright © 2016年 北京优品悦动科贸有限公司. All rights reserved.
//

#import "YPYDAreaViewController.h"

@interface YPYDAreaViewController ()
@property (nonatomic,strong)UILabel * lab;
@property (nonatomic,strong)UILabel * forceLab;
@end

@implementation YPYDAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _lab = [[UILabel alloc] initWithFrame:self.view.frame];
    _lab.font = [UIFont systemFontOfSize:10];
    _lab.text = @"用\n力\n按";
    _lab.textAlignment = NSTextAlignmentCenter;
    _lab.numberOfLines = 3;
    [self.view addSubview: _lab];
    _forceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 80)];
    _forceLab.font = [UIFont systemFontOfSize:20];
    _forceLab.text = @"当前压力值为：0.000";
    _forceLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: _forceLab];
}
#pragma mark 获取压力的大小非常简单，我们可以通过UITouch类中的一些属性来完成。我们只需要在ToucheMoved的事件中捕获这些信息，请注意，不用判断 x,y 值变化
//我这里 只做了一个简单的  压力感应示例，如需更复杂的效果，可以自行编制。
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    UITouch *touch = [[event allTouches] anyObject];
    _forceLab.text = [NSString stringWithFormat:@"当前压力值为: %f",touch.force];
    //   YPYDLog(@"最大压力值  %f",touch.maximumPossibleForce);最大压力值  6.666667
    if (touch.force>0.2)
    {
        _lab.font = [UIFont systemFontOfSize:20*touch.force];
        _lab.textColor = YPYDColor(255*touch.force/6.5, 0, 0, 1);
    }
}

//
///*! To be overridden as needed to provide custom behavior when the environment's traits change. */
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection NS_AVAILABLE_IOS(8_0);
////
//+ (UITraitCollection *)traitCollectionWithForceTouchCapability:(UIForceTouchCapability)capability NS_AVAILABLE_IOS(9_0);
//@property (nonatomic, readonly) UIForceTouchCapability forceTouchCapability NS_AVAILABLE_IOS(9_0); // unspecified: UIForceTouchCapabilityUnknown

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
