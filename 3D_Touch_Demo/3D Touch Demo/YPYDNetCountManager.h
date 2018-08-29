//
//  YPYDNetCountManager.h
//  3D Touch Demo
//
//  Created by 王永康 on 15/10/28.
//  Copyright © 2015年 王永康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPYDNetCountManager : NSObject

@property(nonatomic,assign) NSInteger netWorkingCount;
@property(nonatomic,assign) NSInteger netGoodsListCount;
@property(nonatomic,assign) NSInteger tokenLostedAlratCount;
@property(nonatomic,assign) BOOL hadAutoLogin;
@property(nonatomic,assign) NSInteger noNetAlratCount;
@property(nonatomic,strong) NSString *  applicationShortcutItemTitle;

+(YPYDNetCountManager *)sharedNetCountManager;
@end
