//
//  LSRouterMaker.h
//
//  Created by dev on 2018/4/3.
//  Copyright © 2018年 dev. All rights reserved.
//
/**
 *  路由生产类
 *
 *  @author lsf
 */
#import <UIKit/UIKit.h>
#import "LSRouterProtocol.h"

@interface LSRouterMaker : NSObject

@property (nonatomic, strong, readonly)UIViewController *viewController;

/**
 控制器Url
 */
- (LSRouterMaker *(^)(NSString *))url;

/**
 跳转控制器需要携带的参数
 */
- (LSRouterMaker *(^)(NSDictionary *))param;

/**
 代理
 */
- (LSRouterMaker *(^)(id <LSRouterProtocol>))delegate;

/**
 无参 类方法构造控制器，传入无参类方法名
 */
- (LSRouterMaker *(^)(NSString *))class_sel_construct;

#pragma mark - 介词
/**
 with
 */
- (LSRouterMaker *)with;

/**
 and
 */
- (LSRouterMaker *)and;

#pragma mark - 内部调用
/**
 生成控制器，内部会调用
 */
- (LSRouterMaker *(^)(void))install;

@end
