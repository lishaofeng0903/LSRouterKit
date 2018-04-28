//
//  ViewController2.m
//  LSRouterDemo
//
//  Created by dev on 2018/4/25.
//  Copyright © 2018年 dev. All rights reserved.
//

#import "ViewController2.h"
#import <LSRouterKit/LSRouterKit.h>
#import "ViewController2Delegate.h"
@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
    [LSRouter routerResultWithController:self delegate:^(id<ViewController2Delegate> delegate) {
        if (delegate && [delegate respondsToSelector:@selector(doSomething)]) {
            [delegate doSomething];
        }
    }];
}


@end
