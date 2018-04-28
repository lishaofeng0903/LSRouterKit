//
//  UIViewController+LSRouter.h
//
//  Created by dev on 2018/4/8.
//  Copyright © 2018年 dev. All rights reserved.
//
/**
 *  路由分类
 *
 *  @author lsf
 */
#import <UIKit/UIKit.h>
#import "LSRouterParam.h"

@protocol LSKeyValue <NSObject>

@optional
/**
 传参数映射表
 
 @return 字典
 */
-(NSDictionary *)ls_KeyValueMapping;

@end



@interface UIViewController (LSRouter)<LSKeyValue>

@end

/**
 路由参数分类
 */
@interface UIViewController (LSRouterParam)<LSKeyValue>

/**
 路由参数
 */
@property (nonatomic, strong) LSRouterParam *routerParam;



@end
