//
//  UIButton+delay.h
//  iShop
//
//  Created by 欧阳文 on 2019/6/30.
//  Copyright © 2019 良乐科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define defaultInterval 0.5//默认间隔时间
@interface UIButton (delay)

@property (nonatomic, assign) NSTimeInterval timeInterval;   // 可以用这个给重复点击加间隔
@property (nonatomic, assign) BOOL isIgnoreEvent;//是否允许点击

@end

NS_ASSUME_NONNULL_END
