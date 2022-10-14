//
//  UITextField+Category.h
//  iShop
//
//  Created by JY on 2018/6/13.
//  Copyright © 2018年 良乐科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

/** 创建一个UITextField(有leftView和rightView) */
+ (UITextField *)textFieldWithText:(NSString *)text textColor:(UIColor *)textColor placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor font:(UIFont *)font leftView:(UIView *)leftView  rightView:(UIView *)rightView;

@end
