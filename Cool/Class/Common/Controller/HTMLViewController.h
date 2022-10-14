//
//  HTMLViewController.h
//  ergWallet
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//  

#import "BaseViewController.h"

@interface HTMLViewController : BaseViewController

@property (nonatomic, copy) NSString *url;

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)url;

@end
