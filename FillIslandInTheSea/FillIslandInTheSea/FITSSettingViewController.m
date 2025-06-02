//
//  FITSSettingViewController.m
//  FillIslandInTheSea
//
//  
//

#import "FITSSettingViewController.h"
#import "FITSFeedbackViewController.h"
@interface FITSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *fits_setting_tableView;
@property (nonatomic, strong) NSArray *fits_setting_dataSource;
@end

@implementation FITSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.fits_setting_tableView];
    self.fits_setting_tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.fits_setting_dataSource = @[@"清除缓存",@"版本更新",@"意见反馈"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fits_setting_dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"FITSSettingViewController-%ld",indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row < self.fits_setting_dataSource.count) {
        NSString *title = self.fits_setting_dataSource[indexPath.row];
        cell.textLabel.text = title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理成功"
                                                                                 message:@""
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (indexPath.row == 1){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前已是最新版本"
                                                                                 message:@""
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (indexPath.row == 2){
        FITSFeedbackViewController *vc = [FITSFeedbackViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Lazy
- (UITableView *)fits_setting_tableView{
    if (!_fits_setting_tableView) {
        _fits_setting_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _fits_setting_tableView.delegate = self;
        _fits_setting_tableView.dataSource = self;
        _fits_setting_tableView.rowHeight = 44;
        _fits_setting_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _fits_setting_tableView;
}

@end
