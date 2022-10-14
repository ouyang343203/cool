//
//  BaseNavigationViewController.m
//  ergWallet
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//  导航控制器基类

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBarAppearance];
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (void)setupNavigationBarAppearance {
    // 设置导航栏背景图片和文字颜色大小
    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    [navigationBar setBackgroundColor:kWhiteColor];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kNavBarTitleColor , NSFontAttributeName : kBoldFont(18)}];
    navigationBar.shadowImage = [UIImage imageWithColor:kNavBarColor];

    // 设置返回键的颜色和隐藏返回文字
   // [navigationBar setTintColor:kWhiteColor];
}

// PUSH的时候隐藏TabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.viewControllers count] >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
