//
//  BaseTabBarController.m
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//  TabBar控制器基类

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTabBarAppearance];
}

- (void)setupTabBarAppearance {
    
    self.tabBar.backgroundColor = kTabBarColor;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:10],NSForegroundColorAttributeName : kTabBarTitleColor }forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:10],NSForegroundColorAttributeName : kGreenColor }forState:UIControlStateSelected];
}

@end
