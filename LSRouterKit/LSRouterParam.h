//
//  LSRouterParam.h
//
//  Created by dev on 2018/4/8.
//  Copyright © 2018年 dev. All rights reserved.
//
/**
 *  路由跳转传参
 *
 *  @author lsf
 */
#import <Foundation/Foundation.h>

@protocol LSRouterProtocol;

@interface LSRouterParam : NSObject

/**
 路由代理协议
 */
@property (nonatomic, weak) id <LSRouterProtocol> delegate;

/**
 传递的参数
 */
@property (nonatomic, strong) NSDictionary *param;

/**
 上下文context（与传入的url对应）
 */
@property (nonatomic, copy) NSString *url;

@end
