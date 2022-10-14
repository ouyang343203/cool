//
//  GlobalConstants.h
//  ergWallet
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//  全局常量值

#ifndef GlobalConstants_h
#define GlobalConstants_h

/** =========================================== 自定义Logger ============================================ */

#ifdef DEBUG
#define Logger(format, ...) printf("%s\n", [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])
#else
#define Logger(...)
#endif

#define kMethodLogger  Logger(@"##### %s\n", __FUNCTION__);
#define kDeallocLogger Logger(@"##### %@ dealloc\n", [self class]);

/** =========================================== 判断系统版本 ============================================ */
#define kAPP_VERSION             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] // 表示app版本号
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/** =========================================== 判断机型 ============================================ */

#define iPhone4s (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < DBL_EPSILON)
#define iPhone5s (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define iPhone6s (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < DBL_EPSILON)
#define iPhone6sp (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)960) < DBL_EPSILON)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_X ((kScreenHeight >= 812.0) ? YES : NO) // iphoneX以上手机
/** =========================================== 屏幕宽高 ============================================ */

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kMainBundle [NSBundle mainBundle]
#define kUIWindow [[[UIApplication sharedApplication] delegate] window]
#define kAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate
#define kStatusBarHeight (iPhoneX ? 44 : 20)
#define kNavBarHeight (iPhoneX ? 88 : 64)
#define kTabBarHeight (iPhoneX ? 83 : 49)
#define kSafeAreaBottomHeight (iPhoneX ? 34 : 0)
#define kScreenRate (kScreenWidth / 375)

/** =========================================== 颜色 ============================================ */

#define kRGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define kRGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define kHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define kHexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:(a)]
#define kRU(r) (r)*(kScreenWidth)/375.0
// 随机颜色
#define kRandomColor kRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// APP颜色

// APP颜色
#define kBlackTextColor kHexRGB(0x0E1D46)     // 全局黑色
#define kBlueTextColor kHexRGB(0x0184F2)      // 全局蓝色
#define kGreyTextColor kHexRGB(0x7D8496)      // 全局灰色
#define kLightGreyTextColor kHexRGB(0xF5F7FF) // 全局淡灰色 (使用)
#define kRedTextColor kHexRGB(0xEE3901)       // 全局红色
#define kTiffanyTextColor kHexRGB(0x05D9E1)   // Tiffany蓝


#define kLightBlueColor kHexRGB(0x255BFC)     // 全局淡蓝色（使用）
#define kDeepBlueColor kHexRGB(0x1f3f58)      // 全局深蓝色（使用）

#define kGreyTextColor kHexRGB(0x7D8496)      // 全局灰色
#define kGreenTextColor kHexRGB(0x51A880)      // 全局灰色
#define klightGreyTextColor kHexRGB(0x8AA0AD) // 全局淡灰色 (使用)


#define kTiffanyTextColor kHexRGB(0x05D9E1)   // Tiffany蓝
#define kOrangeTextColor kHexRGB(0xf6b416)    // 全局橘黄色 (使用)
#define kInputbackgroundColor kHexRGB(0xFBFBFB)// 输入框的背景颜色
#define kPlaceholderTextColor kHexRGB(0x999999)// 输入框提示颜色
#define klayerboderColor kHexRGB(0xD3D3D3)     // 边框颜色


// 系统颜色
#define kBlackColor [UIColor blackColor]
#define kRedColor [UIColor redColor]
#define kYellowColor [UIColor yellowColor]
#define kGreenColor [UIColor greenColor]
#define kWhiteColor [UIColor whiteColor]
#define kClearColor [UIColor clearColor]
#define kOrangeColor [UIColor orangeColor]
#define kBlueColor [UIColor blueColor]
#define kClearColor [UIColor clearColor]
#define kGrayColor [UIColor grayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kDarkGrayColor [UIColor darkGrayColor]

// 定制颜色
#define kNavBarColor kHexRGB(0x3C7FFF)         // 导航栏背景颜色
#define kTabBarColor kWhiteColor               // TabBar背景颜色
#define kTabBarTitleColor kBlackTextColor      // TabBar文字默认颜色
#define kTabBarSelectedTitleColor kNavBarColor // TabBar文字选中颜色
#define kNavBarTitleColor kBlackTextColor      // 导航栏标题颜色
#define kBackgroundColor kHexRGB(0xF0F0F0)          // 全局页面背景颜色
#define kCellBackgroundColor kWhiteColor       // Cell的背景颜色
#define kSeparateLineColor kHexRGB(0xD0D3D8)   // 分割线颜色
#define kPlaceholderColor kHexRGB(0xA5AFC7)    // PlaceHolder字体颜色
#define kSectionHeaderColor kHexRGB(0xF2F8FA)  // 组头空隙的颜色

/** =========================================== 字体 ============================================ */

#define kFont(kSize) [UIFont systemFontOfSize:kSize]
#define kFontName(name, kSize) [UIFont fontWithName:name size:kSize]
#define kBoldFont(kSize) [UIFont boldSystemFontOfSize:kSize]

#define kFont10 kFont(10)
#define kFont11 kFont(11)
#define kFont12 kFont(12)
#define kFont13 kFont(13)
#define kFont14 kFont(14)
#define kFont15 kFont(15)
#define kFont16 kFont(16)
#define kFont17 kFont(17)
#define kFont18 kFont(18)
#define kFont19 kFont(19)
#define kFont20 kFont(20)
#define kFont21 kFont(21)
#define kFont22 kFont(22)
#define kFont23 kFont(23)
#define kFont24 kFont(24)
#define kFont25 kFont(25)
#define kBoldFont10 kBoldFont(10)
#define kBoldFont11 kBoldFont(11)
#define kBoldFont12 kBoldFont(12)
#define kBoldFont13 kBoldFont(13)
#define kBoldFont14 kBoldFont(14)
#define kBoldFont15 kBoldFont(15)
#define kBoldFont16 kBoldFont(16)
#define kBoldFont17 kBoldFont(17)
#define kBoldFont18 kBoldFont(18)
#define kBoldFont19 kBoldFont(19)
#define kBoldFont20 kBoldFont(20)
#define kBoldFont21 kBoldFont(22)
#define kBoldFont22 kBoldFont(22)
#define kBoldFont23 kBoldFont(23)
#define kBoldFont24 kBoldFont(24)
#define kBoldFont25 kBoldFont(25)
#define kBoldFont26 kBoldFont(26)
#define kBoldFont27 kBoldFont(27)
#define kBoldFont28 kBoldFont(28)
#define kBoldFont29 kBoldFont(29)
#define kBoldFont30 kBoldFont(30)
#define kBoldFont31 kBoldFont(31)
#define kBoldFont32 kBoldFont(32)
#define kBoldFont33 kBoldFont(33)
#define kBoldFont34 kBoldFont(34)
#define kBoldFont35 kBoldFont(35)
#define kBoldFont36 kBoldFont(36)
/** =========================================== 其他 ============================================ */

#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define KErrorMessage @"网络请求异常"
#define SuppressPerformSelectorLeakWarning(Stuff)  do { \
  _Pragma("clang diagnostic push") \
  _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
   Stuff; \
  _Pragma("clang diagnostic pop") \
} while (0)

#endif /* GlobalConstants_h */
