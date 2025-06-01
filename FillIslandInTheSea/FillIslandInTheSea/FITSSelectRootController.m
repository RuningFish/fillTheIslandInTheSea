//
//  FITSSelectRootController.m
//  FillIslandInTheSea
//
//  Created by runingfish on 2025/6/1.
//

#import "FITSSelectRootController.h"
#import "FITSOneViewController.h"
#import "FITSTwoViewController.h"
#import "FITSThreeViewController.h"
#import "FITSSettingViewController.h"
@implementation FITSSelectRootController
+ (void)fits_sleectRootViewController {
    UITabBarController *tabVC = [UITabBarController new];
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    FITSOneViewController *vc_1 = [FITSOneViewController new];
    vc_1.title = @"首页";
    UINavigationController *nav_1 = [[UINavigationController alloc] initWithRootViewController:vc_1];
    
    FITSTwoViewController *vc_2 = [FITSTwoViewController new];
    vc_2.title = @"我的花园";
    UINavigationController *nav_2 = [[UINavigationController alloc] initWithRootViewController:vc_2];
    
    FITSThreeViewController *vc_3 = [FITSThreeViewController new];
    vc_3.title = @"设置";
    UINavigationController *nav_3 = [[UINavigationController alloc] initWithRootViewController:vc_3];
    
    FITSSettingViewController *vc_4 = [FITSSettingViewController new];
    vc_4.title = @"设置";
    UINavigationController *nav_4 = [[UINavigationController alloc] initWithRootViewController:vc_4];
    
    [viewControllers addObject:nav_1];
    [viewControllers addObject:nav_2];
    [viewControllers addObject:nav_3];
    [viewControllers addObject:nav_4];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    tabVC.viewControllers = viewControllers;
    keyWindow.rootViewController = tabVC;
}

@end
