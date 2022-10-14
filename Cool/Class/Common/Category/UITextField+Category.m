//
//  UITextField+Category.m
//  iShop
//
//  Created by JY on 2018/6/13.
//  Copyright © 2018年 良乐科技. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)

/** 创建一个UITextField(有leftView和rightView) */
+ (UITextField *)textFieldWithText:(NSString *)text textColor:(UIColor *)textColor placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor font:(UIFont *)font leftView:(UIView *)leftView  rightView:(UIView *)rightView
{
    UITextField *textField = [self textFieldWithText:text textColor:textColor placeHolder:placeHolder placeHolderColor:placeHolderColor font:font];
    if (leftView != nil) {
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (rightView != nil) {
        textField.rightView = rightView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    return textField;
}

@end
