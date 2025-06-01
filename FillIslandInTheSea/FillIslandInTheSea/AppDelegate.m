//
//  AppDelegate.m
//  FillIslandInTheSea
//
//  Created by runingfish on 2025/6/1.
//

#import "AppDelegate.h"
#import "FITSSlpashViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[FITSSlpashViewController new]];
    self.window.rootViewController = nav;
    return YES;
}

@end
