//
//  YPYDHomeViewController.m
//  3D Touch Demo
//
//  Created by 王永康 on 16/1/27.
//  Copyright © 2016年 北京优品悦动科贸有限公司. All rights reserved.
//

#import "YPYDHomeViewController.h"
#import "YPYDSearchController.h"

#import "YPYDPOPTestViewController1.h"
#import "YPYDPOPTestViewController2.h"

@interface YPYDHomeViewController ()
<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
// tableView 相关
@property (strong, nonatomic) UITableView *homeTableView;
@property (nonatomic, copy) NSArray *items;
// peek && pop 相关
@property (nonatomic, assign) CGRect sourceRect;       // 用户手势点 对应需要突出显示的rect
@property (nonatomic, strong) NSIndexPath *indexPath;  // 用户手势点 对应的indexPath
@end

/*
 实现peek和pop手势：
 1、遵守协议 UIViewControllerPreviewingDelegate
 2、注册    [self registerForPreviewingWithDelegate:self sourceView:self.view];
 3、实现代理方法
 */


@implementation YPYDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor yellowColor];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索 " style:UIBarButtonItemStylePlain target:self action:@selector(gobackToHome)];
    //处理通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchSearchBarBtnTouch) name:@"UITouchText.search" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToRoot) name:@"UITouchText.home" object:nil];
    
    [self configTableView];
    // 注册Peek和Pop方法
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}
- (void)configTableView
{
    //实例化 tableView商品列表
    _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_homeTableView];
    _homeTableView.backgroundColor = [UIColor whiteColor];
    //设置tableView的 代理方法和数据代理方法
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    self.homeTableView.showsVerticalScrollIndicator = NO;
    self.homeTableView.pagingEnabled = NO;
    self.items = @[@"第一条信息",@"第二条信息",@"第三条信息",@"第四条信息",@"第五条信息",@"第六条信息",@"第七条信息",@"第八条信息",@"第九条信息",@"第十条信息",@"第十一条信息",@"第十二条信息"];
    self.homeTableView.rowHeight = 70;
}

- (void)backToRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
// 搜索结果
- (void)touchSearchBarBtnTouch
{
    YPYDSearchController * searchController = [[YPYDSearchController alloc] init];
    [self.navigationController pushViewController:searchController animated:YES];
}
- (void)gobackToHome
{
    YPYDSearchController * search = [[YPYDSearchController alloc] init];
    search.navigationItem.title = @"搜索";
    [self.navigationController pushViewController:search animated:YES];
}


#pragma mark tableView相关

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.items[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark 通知相关

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark peek && pop 代理方法 轻按进入浮动预览页面

/** peek手势  */
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    YPYDPOPTestViewController1 *childVC = [[YPYDPOPTestViewController1 alloc] init];
    // 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。
    if (![self getShouldShowRectAndIndexPathWithLocation:location])
        return nil;
    previewingContext.sourceRect = self.sourceRect;
   
    // 加个白色背景
    UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(20, 10, ScreenWidth - 40, ScreenHeight - 20 - 64 * 2)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    bgView.clipsToBounds = YES;
    [childVC.view addSubview:bgView];
    
    // 加个lable
    UILabel *lable = [[UILabel alloc] initWithFrame:bgView.bounds];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.numberOfLines = 3;
    lable.text =[NSString stringWithFormat:@"按着的是 %@\n用力，再按重一点...",self.items[self.indexPath.row]];
    [bgView addSubview:lable];
    
    return childVC;
}
#pragma mark  比较巧妙 准确的 获取高亮区域的方法
/** 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。*/
- (BOOL)getShouldShowRectAndIndexPathWithLocation:(CGPoint)location
{
    YPYDLog(@"%f",location.y);
    // 根据手指按压的区域，结合 tableView 的 Y 偏移量（上下）
    location.y = self.homeTableView.contentOffset.y+location.y;
    //定位到当前，按压的区域处于哪个 cell  获得 cell 的indexPath
    self.indexPath = [self.homeTableView indexPathForRowAtPoint:location];
    // 根据cell 的indexPath 取出 cell
    UITableViewCell * cell = [self.homeTableView cellForRowAtIndexPath:self.indexPath];
//    cell.backgroundColor = [UIColor redColor];
    // 根据 获得cell ，确定高亮的区域，记得 高亮区域是相对于屏幕  位置来算，记得减去 tableView 的 Y偏移量
    self.sourceRect = CGRectMake(cell.frame.origin.x, cell.frame.origin.y-self.homeTableView.contentOffset.y, cell.frame.size.width,cell.frame.size.height);
    // 如果row越界了，返回NO 不处理peek手势
    return (self.indexPath.row >= self.items.count &&self.indexPath.row<0) ? NO : YES;
}


/** pop手势  */
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self tableView:self.homeTableView didSelectRowAtIndexPath:self.indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YPYDPOPTestViewController1 * testVC = [[YPYDPOPTestViewController1 alloc] init];
    testVC.navigationItem.title = self.items[indexPath.row];
    [self.navigationController pushViewController:testVC animated:YES];
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
