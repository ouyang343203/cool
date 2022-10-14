//
//  UIBarButtonItem+Category.h
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)

/** 创建一个UIBarButtonItem: 返回箭头 */
+ (UIBarButtonItem *)arrowBtnWithTarget:(id)target selector:(SEL)selector;

/** 创建一个白色的UIBarButtonItem: 返回箭头 */
+ (UIBarButtonItem *)whiteArrowBtnWithTarget:(id)target selector:(SEL)selector;

@end
