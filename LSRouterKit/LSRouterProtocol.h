//
//  LSRouterProtocol.h
//
//  Created by dev on 2018/4/8.
//  Copyright © 2018年 dev. All rights reserved.
//
/**
 *  通用路由协议（自定义协议必须继承该协议）
 *
 *  @author lsf
 */
#import <Foundation/Foundation.h>

@class LSRouterResultParam;

@protocol LSRouterProtocol <NSObject>

@optional
/**
 路由回传参数
 */
- (void)routerOnControllerResult:(LSRouterResultParam *)result;

@end
