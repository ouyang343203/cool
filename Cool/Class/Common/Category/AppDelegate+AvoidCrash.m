//
//  AppDelegate+AvoidCrash.m
//  TTSPORT
//
//  Created by ouyang on 2022/6/27.
//  Copyright © 2022 Malaysia. All rights reserved.
//

#import "AppDelegate+AvoidCrash.h"
#import "LSSafeProtector.h"

@implementation AppDelegate (AvoidCrash)

- (void)avoidCrash {
    
    [LSSafeProtector openSafeProtectorWithIsDebug:NO block:^(NSException *exception, LSSafeProtectorCrashType crashType) {
        
        //[Bugly reportException:exception];
        //此方法相对于上面的方法，好处在于bugly后台查看bug崩溃位置时，不用点击跟踪数据，再点击crash_attach.log，查看里面的额外信息来查看崩溃位置
        //[Bugly reportExceptionWithCategory:3 name:exception.name reason:[NSString stringWithFormat:@"%@  崩溃位置:%@",exception.reason,exception.userInfo[@"location"]] callStack:@[exception.userInfo[@"callStackSymbols"]] extraInfo:exception.userInfo terminateApp:NO];
    }];
    //打开KVO，移除日志信息
    [LSSafeProtector setLogEnable:YES];
}

@end
