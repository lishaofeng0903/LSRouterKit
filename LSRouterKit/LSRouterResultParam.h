//
//  LSRouterResultParam.h
//
//  Created by dev on 2018/4/8.
//  Copyright © 2018年 dev. All rights reserved.
//
/**
 *  路由回传参数
 *
 *  @author lsf
 */
#import <Foundation/Foundation.h>

@interface LSRouterResultParam : NSObject

/**
 上下文context（与传入的url对应）
 */
@property (nonatomic, copy) NSString *url;

/**
 操作
 */
@property (nonatomic, copy) NSString *action;

/**
 返回值（对象形式）
 */
@property (nonatomic, strong) id object;

/**
 返回值（多返回值形式）
 */
@property (nonatomic, strong) NSDictionary *userInfo;

@end
