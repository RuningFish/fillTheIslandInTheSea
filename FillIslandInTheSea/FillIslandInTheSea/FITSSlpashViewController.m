//
//  FITSSlpashViewController.m
//  FillIslandInTheSea
//
//  Created by runingfish on 2025/6/1.
//

#import "FITSSlpashViewController.h"
#import "AFHTTPSessionManager.h"
#import "FITSSelectRootController.h"

@implementation FITSSlpashViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initwindowLoading];
    
}

- (void)initwindowLoading{
    
    UIButton *btnLoading = [[UIButton alloc] initWithFrame:CGRectMake(50,[[UIScreen mainScreen] bounds].size.height/2  - 20, [[UIScreen mainScreen] bounds].size.width - 100, 40)];
    [btnLoading setTitle:@"正在加载数据,请稍后" forState:UIControlStateNormal];
    btnLoading.titleLabel.font = [UIFont fontWithName:@"helvetica" size:12];
    [self.view addSubview:btnLoading];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if(status == AFNetworkReachabilityStatusNotReachable){
                [self removeAllSubviews];
                self.view.backgroundColor = [UIColor whiteColor];
                
                UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, [[UIScreen mainScreen] bounds].size.height/2 - 50, [[UIScreen mainScreen] bounds].size.width - 100, 40)];
                [btn1 setTitle:@"网络出现问题,点击重新加载" forState:UIControlStateNormal];
                [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn1 setBackgroundColor:[UIColor clearColor]];
                [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.view addSubview:btn1];
            }else{
                [FITSSelectRootController fits_sleectRootViewController];
            }
        }];
    
}

- (void)click:(UIButton *)btn{
    [self initwindowLoading];
    [self removeAllSubviews];
}

- (void)removeAllSubviews {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    return;
}

@end
