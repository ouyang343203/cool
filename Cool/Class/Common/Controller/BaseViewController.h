//
//  BaseViewController.h
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//  

#import <UIKit/UIKit.h>

@class EmptyView;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) EmptyView *emptyView;

/* 子类重写该方法绘制UI */
- (void)setupSubViews;

/* 子类重写该方法POP页面 */
- (void)popViewController;

//- (void)LoginAction;

- (void)pushvcWithController:(NSString*)controller;


// 页面排版规范
#pragma mark - HTTP Method -- 网络请求

// 方法和方法之间空一行
#pragma mark - Delegate Method -- 代理方法


#pragma mark - Private Method -- 私有方法


#pragma mark - Public Method -- 公开方法


#pragma mark - Setter/Getter -- Getter尽量写出懒加载形式


@end
