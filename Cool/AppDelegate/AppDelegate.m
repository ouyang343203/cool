//
//  AppDelegate.m
//  Cool
//
//  Created by ouyang on 2022/9/25.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "AppDelegate+AvoidCrash.h"
#import "LSSafeProtector.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self avoidCrash];
    MainTabBarController *tabBarVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = tabBarVC;
    return YES;
}

@end
