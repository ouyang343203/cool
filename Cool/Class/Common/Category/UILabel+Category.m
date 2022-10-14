//
//  UILabel+Category.m
//  iShop
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 良乐科技. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

- (void)setParagraphSpacing:(CGFloat)paragraphSpacing lineSpacing:(CGFloat)lineSpacing {
    NSString *text = self.text;
    if (text == nil || !text.length) {
        return;
    }

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    ;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setParagraphSpacing:paragraphSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
}
@end
