//
//  UIViewController+LSRouter.m
//
//  Created by dev on 2018/4/8.
//  Copyright © 2018年 dev. All rights reserved.
//

#import "UIViewController+LSRouter.h"
#import <objc/runtime.h>

@implementation UIViewController (LSRouter)

@end


/**
 路由参数分类
 */
@implementation UIViewController (LSRouterParam)

/**
 获取路由参数
 */
- (LSRouterParam *)routerParam{
    return objc_getAssociatedObject(self, @selector(routerParam));
}

/**
 设置路由参数
 */
-(void)setRouterParam:(LSRouterParam *)routerParam{
    objc_setAssociatedObject(self, @selector(routerParam), routerParam, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (routerParam != nil) {
        NSDictionary *param = routerParam.param;
        NSArray *allKeys = [param allKeys];
        
        NSMutableArray *errorKeys = [[NSMutableArray alloc] init];
        
        for (NSString *key in allKeys) {
            @try{
                //获取设置到控制器的key
                NSString *setKey = [self getPropertyKey:key];
                
                [self setValue:param[key] forKey:setKey];
            }@catch(NSException *e){
                [errorKeys addObject:key];
            }
        }
        if (errorKeys.count > 0) {
            NSString *notFountKey = [errorKeys componentsJoinedByString:@","];
            NSLog(@"*****Router跳转到VC:%@，设置参数时，VC缺少属性：%@",[self class], notFountKey);
        }
    }
}


/**
 根据传入key值寻找真实key值
 */
- (NSString *)getPropertyKey:(NSString *)key{
    if ([self conformsToProtocol:@protocol(LSKeyValue)] && [self respondsToSelector:@selector(ls_KeyValueMapping)]) {
        NSDictionary *privateKeysValue = [self ls_KeyValueMapping];
        NSString *nkey = [privateKeysValue valueForKey:key];
        NSString *setKey = nkey? :key;
        return setKey;
    }else{
        return key;
    }
}

@end
