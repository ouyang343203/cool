//
//  UIBarButtonItem+Category.m
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//

#import "UIBarButtonItem+Category.h"

@implementation UIBarButtonItem (Category)

/** 创建一个UIBarButtonItem: 返回箭头 */
+ (UIBarButtonItem *)arrowBtnWithTarget:(id)target selector:(SEL)selector {
    
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithImageName:@"arrow_back_black" target:target selector:selector];
    return item;
}

/** 创建一个白色UIBarButtonItem: 返回箭头 */
+ (UIBarButtonItem *)whiteArrowBtnWithTarget:(id)target selector:(SEL)selector {
    
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithImageName:@"arrow_back_white" target:target selector:selector];
    return item;
}

@end
