//
//  AppConstants.h
//  ergWallet
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//  APP常量值

#import <Foundation/Foundation.h>

#ifndef AppConstants_h
#define AppConstants_h

// 默认币种
static NSString *const kDefaultSymbol = @"ETH";
static NSString *const kServerPublicKey = @"-----BEGIN PUBLIC KEY----- MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqpshXs5E1yRdbo0MdmUZ9M/UdrUE9cesvp8+mPPHdNMGEsZ37oSKww01nOr4Q58yFAEVNrFlSoQ7SZBLD10GWW0bWEl0h1AJDafGapbhDawJ4rSdw6KME4xw+Ao2YPS5GOfSUNId66Dl8KS53eUGPi3HNu4B+NzardqjKnrf1xGI8+zJ03Q0fuwfsnmo1YsBV9UCL4bdkmLbsOvRzP0Uvx4+PlUgFhUnT+yg3DAzb0zJt4AKpGXe3St1Q6NXv4K6dFNdcJi7ULXUhhHJ3LhGEq52Ot74+TuZOKDtx1jQOuQZDXtvs1RWyDF7tIGYiD4qMfomSRGKT2VBAq9M4jF+iwIDAQAB -----END PUBLIC KEY-----";

// 通知字符串常量
static NSString *const kNotificationSetPayPasswrodCompletion = @"kNotificationSetPayPasswrodCompletion";
static NSString *const kNotificationRefreshHomeData = @"kNotificationRefreshHomeData";
static NSString *const kNotificationPopToManagerWalletVC = @"kNotificationPopToManagerWalletVC";
static NSString *const kNotificationImportMnemonicScanResult = @"kNotificationImportMnemonicScanResult";
static NSString *const kNotificationImportKeystoreScanResult = @"kNotificationImportKeystoreScanResult";
static NSString *const kNotificationImportPrivateKeyScanResult = @"kNotificationImportPrivateKeyScanResult";
static NSString *const kNotificationModifyNickname = @"kNotificationModifyNickname";
static NSString *const kNotificationModifyGender = @"kNotificationModifyGender";
static NSString *const kNotificationModifyAvatar = @"kNotificationModifyAvatar";
static NSString *const kNotificationUpdateGroupList = @"kNotificationUpdateGroupList";

// 常量字符串
static NSString *const kUser = @"userinfo";
static NSString *const kToken = @"accesstoken";
static NSString *const kLocale = @"locale";
static NSString *const kAccount = @"account";
static NSString *const kLaunchingEnd = @"kLaunchingEnd";
static NSString *const kStartGetVerifyCode = @"startGetVerifyCode"; 
static NSString *const kHasCreatedWallet = @"kHasCreatedWallet";
static NSString *const kBlockDetailUrl = @"https://etherscan.io/tx/"; // 查询区块详情

// 用于存储用户的拥有的资产

static NSString *const Kusdt = @"usdt"; // 存储/获取时用
static NSString *const usdt = @"USDT-ERC"; //仅用于使用的是否是USDT
static NSString *const Keth = @"ETH";
static NSString *const Kbocc = @"合约通证"; //即BOCC
static NSString *const Kping = @"平台币";  //既通用积分
static NSString *const Kbai = @"白条通证";
static NSString *const Kgame = @"game";

//// 其他
static int kCountdownSecond = 60;

#define kCoinPlaceholderImage [UIImage imageNamed:@"btb_eth"]
#define kEmptyViewBounds CGRectMake(0, 135, 195, 155)
#define kEmptyViewImageName @"personal_btn_development"

#endif /* AppConstants_h */
