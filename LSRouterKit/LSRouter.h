//
//  LSRouter.h
//
//  Created by dev on 2018/4/3.
//  Copyright © 2018年 dev. All rights reserved.
//
/**
 *  路由
 *
 *  @author lsf
 */
#import <Foundation/Foundation.h>
#import "LSRouterMaker.h"
#import "LSRouterResultParam.h"
#import "UIViewController+LSRouter.h"

@interface LSRouter : NSObject

#pragma mark - 创建控制器
/**
 构造路由控制器
 
 @param router 路由maker
 @return 控制器
 */
+ (UIViewController *)makeRouter:(void (^)(LSRouterMaker *maker))router;


#pragma mark - 数据回传
/**
 代理回调 -触发（routerOnControllerResult:）
 
 @param vc 当前控制器
 @param action 操作
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action;

/**
 代理回调 -触发（routerOnControllerResult:）
 
 @param vc 当前控制器
 @param action 操作
 @param object 回传的数据
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action object:(id)object;

/**
 代理回调 -触发（routerOnControllerResult:）
 
 @param vc 当前控制器
 @param action 操作
 @param userInfo 回传的数据，字典模式
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action userInfo:(NSDictionary *)userInfo;

/**
 代理回调 -触发（routerOnControllerResult:）
 
 @param vc 当前控制器
 @param action 操作
 @param object 回传的数据
 @param userInfo 回传的数据，字典模式
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action object:(id)object userInfo:(NSDictionary *)userInfo;


#pragma mark - 自定义代理回调
/**
 自定义代理回调：必须继承LSRouterProtocol

 @param vc 当前控制器
 @param delegateBlock block返回当前代理
 */
+ (void)routerResultWithController:(UIViewController *)vc delegate:(void(^)(id<LSRouterProtocol> delegate))delegateBlock;

@end

