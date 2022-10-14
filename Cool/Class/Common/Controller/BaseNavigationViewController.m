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
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:17]
                           };
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc]init];
        //添加背景色
        //appperance.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"MNYHUAYI_home"]];//用图片做导航背景
        appperance.backgroundColor = [UIColor redColor];
        appperance.shadowImage = [[UIImage alloc]init];
        appperance.shadowColor = nil;
        [appperance setTitleTextAttributes:dict]; //设置字体颜色大小
        [appperance setShadowImage:[UIImage new]];//去除底部黑线
        self.navigationBar.standardAppearance = appperance;
        self.navigationBar.scrollEdgeAppearance = appperance;

    }else{
        UINavigationBar *navigationBar = [UINavigationBar appearance];
        //[navigationBar setBackgroundImage:[UIImage imageNamed:@"MNYHUAYI_home"] forBarMetrics:UIBarMetricsDefault];/用图片做导航背景
        [navigationBar setBackgroundColor:[UIColor redColor]];
//        [navigationBar setTintColor:kRGBAlpha(184, 184, 184, 1)];
//        [navigationBar setBarTintColor:[UIColor redColor]];
        [navigationBar setShadowImage:[UIImage new]]; //去除底部黑线
        navigationBar.translucent = NO;
        [navigationBar setTitleTextAttributes:dict];
    }
    
}

// PUSH的时候隐藏TabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.viewControllers count] >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
