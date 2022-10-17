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
    if (@available(iOS 13.0, *)) {
           UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
           [tabBarAppearance configureWithOpaqueBackground];
          // tabBarAppearance.backgroundImage = [UIImage imageNamed:@"MNYHUAYI_home"];
           tabBarAppearance.shadowColor = [UIColor colorWithRed:249/255.0 green:251/255.0 blue:252/255.0 alpha:1.0];
           self.tabBar.standardAppearance = tabBarAppearance;
           if (@available(iOS 15.0, *)) {
               self.tabBar.scrollEdgeAppearance = tabBarAppearance;
           }
        }

    self.tabBar.backgroundColor = kTabBarColor;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : kTabBarTitleColor }forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : kGreenColor }forState:UIControlStateSelected];
}

@end
