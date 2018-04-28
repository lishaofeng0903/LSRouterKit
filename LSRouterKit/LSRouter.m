//
//  LSRouter.m
//
//  Created by dev on 2018/4/3.
//  Copyright © 2018年 dev. All rights reserved.
//

#import "LSRouter.h"
#import "UIViewController+LSRouter.h"

@implementation LSRouter

/**
 构造路由控制器

 @param router 路由maker
 @return 控制器
 */
+ (UIViewController *)makeRouter:(void (^)(LSRouterMaker *maker))router{
    LSRouterMaker *maker = [[LSRouterMaker alloc] init];
    if (router) {
        router(maker);
    }
    maker.install();
    return maker.viewController;
}


#pragma mark - 数据回传
/**
 构造代理回调

 @param vc 当前控制器
 @param action 操作
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action{
    [self routerResultWithController:vc action:action object:nil userInfo:nil];
}

/**
 构造代理回调
 
 @param vc 当前控制器
 @param action 操作
 @param object 回传的数据
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action object:(id)object{
    [self routerResultWithController:vc action:action object:object userInfo:nil];
}

/**
 回传数据

 @param vc 当前控制器
 @param action 操作
 @param userInfo 回传的数据，字典模式
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action userInfo:(NSDictionary *)userInfo{
    [self routerResultWithController:vc action:action object:nil userInfo:userInfo];
}

/**
 回传数据
 
 @param vc 当前控制器
 @param action 操作
 @param object 回传的数据
 @param userInfo 回传的数据，字典模式
 */
+ (void)routerResultWithController:(UIViewController *)vc action:(NSString *)action object:(id)object userInfo:(NSDictionary *)userInfo{
    @try{
        id<LSRouterProtocol> delegate = vc.routerParam.delegate;
        if (delegate && [delegate conformsToProtocol:@protocol(LSRouterProtocol)] && [delegate respondsToSelector:@selector(routerOnControllerResult:)]){
            LSRouterResultParam *resultParam = [LSRouterResultParam new];
            resultParam.url = vc.routerParam.url;
            resultParam.action = action;
            resultParam.object = object;
            resultParam.userInfo = userInfo;
            [delegate routerOnControllerResult:resultParam];
        }
    }@catch(NSException *e){
        NSLog(@"*****Router回传数据发生了错误，%@",e);
    }
    
}

#pragma mark - 自定义代理回调
/**
 自定义代理回调：必须继承LSRouterProtocol
 
 @param vc 当前控制器
 @param delegateBlock block返回当前代理
 */
+ (void)routerResultWithController:(UIViewController *)vc delegate:(void(^)(id<LSRouterProtocol> delegate))delegateBlock{
    id<LSRouterProtocol> delegate = vc.routerParam.delegate;
    if(delegateBlock != nil){
        delegateBlock(delegate);
    }
}

@end
