//
//  BaseViewController.m
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//  控制器基类

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupBaseViewController];
}
- (void)setupBaseViewController {
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    if ([self.navigationController.viewControllers count] > 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem arrowBtnWithTarget:self selector:@selector(popViewController)];
    }
    [self setupSubViews];
}

- (void)setupSubViews {
    
}

- (void)popViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    kDeallocLogger
}

- (void)pushvcWithController:(NSString*)controller {
    
    Class class = NSClassFromString(controller);
    if (class) {
        UIViewController *ctrl = class.new;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

@end
