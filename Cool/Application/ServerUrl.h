//
//  ServerUrl.h
//  ergWallet
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//  服务器地址

#ifndef ServerUrl_h
#define ServerUrl_h

/** =========================================== 服务器配置 ============================================ */

/*
 0: 测试环境
 1: 正式环境
 */
#define RELEASE_MODEL 0

#if !RELEASE_MODEL

// 测试环境
#define SERVER_URL            @"http://121.41.38.102:9000"     //测试环境
#define HTMLSERVER_URL        @"http://www.idra.top"           //HTML地址

#else

// 正式环境
#define SERVER_URL            @"http://121.196.242.24:9000"      //正式环境
#define HTMLSERVER_URL        @"http://www.idra.top"             //公链地址

#endif

/** =========================================== 登录注册接口 =========================================== */

#define USER_REGISTER @"/uac/tUser/register"                     // 用户注册
#define USER_REGISTER_VERIFYCODE @"/uac/tUser/send/sms"          // 注册验证码
#define USER_LOGIN @"/uac/login"                                 // 登录接口
#define USER_FORGET_PASSWORD @"/uac/retrieve/login/password"     // 登录密码找回

#define USER_BIND @"/user/bind"                                  // 用户绑定
#define ACCOUNT_AGREEMENT   [HTMLSERVER_URL stringByAppendingString:@"/bocc/xy.html"]     // 开户协议
#define PRIVACY_POLICY      [HTMLSERVER_URL stringByAppendingString:@"/bocc/ys.html"]     // 隐私政策

/** =========================================== 首页接口 =========================================== */
#define HOME_PRIVACY_POLICY @"/system/getAnnouncement"           // 获取系统公告
#define HOME_NEWGUID  [HTMLSERVER_URL stringByAppendingString:@"/bocc/xs.html"]           // 新手指南
#define HOME_APP_VERSION @"/system/checkVersion"                 // 获取版本信息
#define HOME_TRADE_ORDER @"/trade/orderRecord/latestrecords"     // 获取最新交易广告
#define HOME_CROW @"/crowdfund/Fund/getfundinfo"                 // 获取众筹列表

/** =========================================== 合约接口 =========================================== */

#define CONTRACYT_PROCEEING @"/crowdfund/Fund/getproceedfundinfo"// 获取进行中众筹
#define CONTRACYT_PREPARE_PROCEE @"/crowdfund/Fund/getpreheatfundinfo"// 获取预热中众筹
#define CONTRACYT_OVER_PROCEE @"/crowdfund/Fund/getendfundinfo"  // 获取预热中众筹
#define CONTRACYT_BUYCROW @"/crowdfund/FundUser/buyfund"         // 众筹认购购买
#define CONTRACYT_CROWD_RECORD @"/crowdfund/FundUser/getmyfund"  // 众筹认购记录
/** =========================================== 资产接口 =========================================== */

#define BALANCE_COUNT @"/wallet/Account/gettotals"               // 获取用户资产
#define BALANCE_RECHANG @"/wallet/Wallet/recharge"               // 获取充币页面数据
#define BALANCE_RECHANGRECORD @"/wallet/Order/rechargerecord"    // 获取充币记录
#define BALANCE_DRAWR @"/wallet/Order/withdraw"                  // 提币充币
#define BALANCE_DRAWR_COMMISSION @"/wallet/Order/withdrawfee"    // 获取提币手续费费率
#define BALANCE_DRAWR_RECORD @"/wallet/Order/withdrawrecord"     // 获取提币手续费费率
#define BALANCE_FASTSWAP @"/wallet/Order/exchange"               // 闪兑

/** =========================================== 个人中心接口 =========================================== */
#define MINE_PARPWD @"/uac/reset/capital/password"               // 修改支付密码
#define MINE_CHANGR_NICKNAMR @"/uac/tUser/resetNickName"         // 修改用户昵称
#define MINE_TEANICOM @"/team/UserTeam/myTeamEarning"            // 团队收益COUNT
#define MINE_TEAMELEMENTICOM @"/team/UserTeam/myTeamList"        // 个人团队成员收益
#define MINE_TEAMDETILEICOMICOM @"/earning/Earning/myEarningList"// 团队收益详情

#endif /* ServerUrl_h */


