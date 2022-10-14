//
//  MainTabBarController.m
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//  

#import "MainTabBarController.h"
#import "BaseNavigationViewController.h"
#import "HomeController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

/** 设置主控制器 */
- (void)setupViewController {
    
    self.delegate = self;     //设置代理
    HomeController *homeVC = [[HomeController alloc] init];
    [self addChildViewController:homeVC title:NSLocalizedString(@"首页", nil) image:@"bq_sy1" selectedImage:@"bq_sy2"];
}

- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    childVC.title = title;
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationViewController *navController = [[BaseNavigationViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navController];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
//    if ([viewController.tabBarItem.title isEqualToString:@"运动"]) {
//        if (![SPUtils getUserDefaultsforkey:kToken]) {  //未登录
//             [[AppDelegate sharedDelegate] showLogin];
//            return NO;
//        }else{
//            return YES;
//        }
//    }else{
//        return YES;
//    }
    
    return YES;
}

@end
