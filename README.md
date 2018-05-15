# LSRouterKit
[![Version](https://img.shields.io/cocoapods/v/LSRouterKit.svg?style=flat)](https://cocoapods.org/pods/LSRouterKit)
[![License](https://img.shields.io/cocoapods/l/LSRouterKit.svg?style=flat)](https://cocoapods.org/pods/LSRouterKit)
[![Platform](https://img.shields.io/cocoapods/p/LSRouterKit.svg?style=flat)](https://cocoapods.org/pods/LSRouterKit)
- 一款本地端路由框架，统一控制器的创建方式和参数传递。控制器与控制器解耦，减少头文件的引用，加快编译速度。
## 安装
### 【使用CocoaPods】
```ruby
pod 'LSRouterKit'
```
### 【手动导入】
- 将`LSRouterKit`文件夹中的所有源代码拽入项目中
```objc
LSRouterKit.h
LSRouterProtocol.h
LSRouter.h                      LSRouter.m
LSRouterMaker.h                 LSRouterMaker.m
LSRouterParam.h                 LSRouterParam.m
LSRouterResultParam.h           LSRouterResultParam.m
UIViewController+LSRouter.h     UIViewController+LSRouter.m
```

## 使用方式
- 导入头文件
```objc
#import "LSRouter.h"
```

- 控制器的创建方式（url为必传）


```objc
//控制器maker的url block中，传入对应控制器的名字，如"ViewController"或者"Modular(自定义)/.../ViewController"。用“/”分割
UIViewController *vc = [LSRouter makeRouter:^(LSRouterMaker *maker) {
    maker.url(@"ViewController");
}];
[self.navigationController pushViewController:vc animated:YES];
```

- 携带参数创建控制器
```objc
//控制器maker的param block中,传入字典对象(控制器创建需要携带的参数)
UIViewController *vc = [LSRouter makeRouter:^(LSRouterMaker *maker) {
    NSDictionary *param = @{
                              @"name":@"lsf",
                              @"age":@(25)
                            };
    maker.url(@"ViewController").param(param);
}];
[self.navigationController pushViewController:vc animated:YES];
```

- 监听代理回调（self必须实现LSRouterProtocol协议来监听回调信息）
```objc
/*
 AController <LSRouterProtocol> 
*/
//控制器maker的delegate block中,传入代理对象
UIViewController *vc = [LSRouter makeRouter:^(LSRouterMaker *maker) {
    maker.url(@"BController").delegate(self);
}];
[self.navigationController pushViewController:vc animated:YES];

/*
 BController 触发了一个action，需要传递数据到代理对象
*/
- (void)submitButtonDidClick:(UIButton *)button{
    /*
     self为当前控制器对象，
     action为触发的操作字符串，
     object为单对象返回值，
     userInfo为多对象返回值
    */
    //1.无返回值action
    [LSRouter routerResultWithController:self action:@"submitButtonDidClick"];
    //2.单对象返回值action
    [LSRouter routerResultWithController:self action:@"submitButtonDidClick" object:nil];
    //3.单对象和多对象返回值action
    [LSRouter routerResultWithController:self action:@"submitButtonDidClick" object:nil userInfo:nil];
}

/*
 AController <LSRouterProtocol> 
 代理回调
*/
- (void)routerOnControllerResult:(LSRouterResultParam *)result{
    if ([result.url isEqualToString:@"BController"]) {
        if ([result.action isEqualToString:@"submitButtonDidClick"]) {
            id obj = result.object;
            NSDictionary *userInfo = result.userInfo;
            
            [self doSomethingWithObj:obj userInfo:userInfo];
        }
    }
}
```

