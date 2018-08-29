//
//  AppDelegate.m
//  3D Touch Demo
//
//  Created by 王永康 on 16/1/27.
//  Copyright © 2016年 王永康. All rights reserved.

//整体tabbar控制器
#import "YPYDTabBarController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
/*
 当程序启动时
 
 1、判断launchOptions字典内的UIApplicationLaunchOptionsShortcutItemKey是否为空
 2、当不为空时,application:didFinishLaunchWithOptions方法返回NO，否则返回YES
 3、在application:performActionForShortcutItem:completionHandler方法内处理点击事件
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YPYDTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    [self configShortCutItems];
    return YES;
}
/** 创建shortcutItems */
- (void)configShortCutItems
{
    NSMutableArray *shortcutItems = [NSMutableArray array];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"YPYD.UITouchText.home" localizedTitle:@"测试1" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"YPYD.UITouchText.search" localizedTitle:@"测试2" localizedSubtitle:@"测试2副标题" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    [shortcutItems addObject:item2];
    [shortcutItems addObject:item1];
    [[UIApplication sharedApplication] setShortcutItems:shortcutItems];
}

// iOS9 的 3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 &&self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        NSLog(@"你的手机支持3D Touch!");
        YPYDNetCountManager * sharedNetCountManager = [YPYDNetCountManager sharedNetCountManager];
        sharedNetCountManager.applicationShortcutItemTitle = shortcutItem.type;
        
        
        //首页
        if([shortcutItem.type isEqualToString:@"YPYD.UITouchText.home"])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YPYD.UITouchText.home" object:nil userInfo:nil];
        }
        //搜索商品
        if([shortcutItem.type isEqualToString:@"YPYD.UITouchText.search"])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YPYD.UITouchText.search" object:nil userInfo:nil];
        }
        //购物车
        if([shortcutItem.type isEqualToString:@"YPYD.UITouchText.cart"])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YPYD.UITouchText.cart" object:nil userInfo:nil];
        }
        //我的U
        if([shortcutItem.type isEqualToString:@"YPYD.UITouchText.myU"])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YPYD.UITouchText.home" object:nil userInfo:nil];
        }
    }
    else
    {
        NSLog(@"你的手机暂不支持3D Touch!");
    }
}


#pragma mark - Core Data stack
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.upfood.www._D_Touch_Demo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"_D_Touch_Demo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_D_Touch_Demo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support
- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
