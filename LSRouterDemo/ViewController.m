//
//  ViewController.m
//  LSRouterDemo
//
//  Created by dev on 2018/4/25.
//  Copyright © 2018年 dev. All rights reserved.
//

#import "ViewController.h"

#import <LSRouterKit/LSRouterKit.h>
#import "ViewController2Delegate.h"
@interface ViewController ()<ViewController2Delegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn1:(id)sender {
    UIViewController *vc = [LSRouter makeRouter:^(LSRouterMaker *maker) {
        maker.url(@"ViewController1");
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)btn2:(id)sender {
    UIViewController *vc = [LSRouter makeRouter:^(LSRouterMaker *maker) {
        maker.url(@"ViewController2").delegate(self);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)doSomething{
    NSLog(@"aaaaaaaaaa");
}

@end
