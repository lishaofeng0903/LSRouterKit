//
//  LSRouterMaker.m
//
//  Created by dev on 2018/4/3.
//  Copyright © 2018年 dev. All rights reserved.
//

#import "LSRouterMaker.h"
#import "UIViewController+LSRouter.h"

@interface LSRouterMaker()

/**
 保存url
 */
@property (nonatomic, copy)NSString *maker_url;

/**
 保存参数
 */
@property (nonatomic, strong)NSDictionary *maker_param;

/**
 保存代理
 */
@property (nonatomic, weak) id <LSRouterProtocol> maker_delegate;

/**
 保存类方法创建控制器的方法名
 */
@property (nonatomic, copy)NSString *make_class_sel_construct;

@end

@implementation LSRouterMaker

/**
 控制器Url
 */
- (LSRouterMaker *(^)(NSString *))url{
    return ^(NSString *url){
        self.maker_url = url;
        return self;
    };
}

/**
 跳转控制器需要携带的参数
 */
- (LSRouterMaker *(^)(NSDictionary *))param{
    return ^(NSDictionary *param){
        self.maker_param = param;
        return self;
    };
}

/**
 代理
 */
- (LSRouterMaker *(^)(id <LSRouterProtocol>))delegate{
    return ^(id<LSRouterProtocol> delegate){
        self.maker_delegate = delegate;
        return self;
    };
}


/**
 无参 类方法构造控制器，传入类方法名
 */
- (LSRouterMaker *(^)(NSString *))class_sel_construct{
    return ^(NSString *class_sel_construct){
        self.make_class_sel_construct = class_sel_construct;
        return self;
    };
}

#pragma mark - 介词
- (LSRouterMaker *)with{
    return self;
}

- (LSRouterMaker *)and{
    return self;
}


#pragma mark - 内部调用
/**
 生成控制器，内部会调用
 */
- (LSRouterMaker *(^)(void))install{
    return ^(void){
        //1.创建控制器
        if (self.maker_url) {
            NSString *vc_name = [self getControllerNameWithUrlStr:self.maker_url];
            Class vc_class = NSClassFromString(vc_name);
            
            UIViewController *vc = nil;
            @try{
                if (self.make_class_sel_construct) {
                    //类方法创建控制器
                    SEL sel = NSSelectorFromString(self.make_class_sel_construct);
                    if ([vc_class respondsToSelector:sel]) {
                        
                        //去除警告
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                        vc = [vc_class performSelector:sel];
    #pragma clang diagnostic pop
                    }else{
                        NSLog(@"*****Router类方法创建控制器失败-->%@，SEL-->%@",vc_name,self.make_class_sel_construct);
                    }
                    
                }else{
                    //正常创建控制器
                    vc = [[vc_class alloc] init];
                }
            }@catch(NSException *e){
                NSLog(@"*****Router创建控制器发生异常%@",e);
            }
            
            _viewController = vc;
            if (vc == nil) {
                NSLog(@"*****Router创建控制器失败-->%@",vc_name);
            }
        }
        
        //2传参
        //2.1传递参数
        LSRouterParam *param = [LSRouterParam new];
        if (self.maker_param) {
            param.param = self.maker_param;
        }
        //2.2传递代理
        if (self.maker_delegate) {
            param.delegate = self.maker_delegate;
        }
        //2.3根据url构建上下文
        param.url = self.maker_url;
        
        //2.4设置参数
        _viewController.routerParam = param;
        
        return self;
    };
}


#pragma mark - 私有方法
/**
 获取控制器名称

 @param urlStr model/VCName
 */
- (NSString *)getControllerNameWithUrlStr:(NSString *)urlStr{
    if (urlStr != nil && ![urlStr isEqualToString:@""]) {
        NSArray *arr = [urlStr componentsSeparatedByString:@"/"];
        return [arr lastObject];
    }else{
        return nil;
    }
}

@end
