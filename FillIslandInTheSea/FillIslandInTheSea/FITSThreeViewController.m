//
//  FITSThreeViewController.m
//  FillIslandInTheSea
//
//  Created by runingfish on 2025/6/1.
//

#import "FITSThreeViewController.h"

@interface FITSThreeViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *fits_threee_itemList;
@property (nonatomic, strong) NSMutableArray *fits_threee_item_value_list;
@end

@implementation FITSThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    UIScrollView *fits_threee_scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:fits_threee_scrollView];
    fits_threee_scrollView.backgroundColor = [UIColor clearColor];
    
    UILabel *fits_threee_title_label = [[UILabel alloc] initWithFrame:CGRectMake(20,10, [UIScreen mainScreen].bounds.size.width-40, 60)];
    [fits_threee_scrollView addSubview:fits_threee_title_label];
    fits_threee_title_label.text = @"围堤在自重和外荷载作用下会产生沉降。请根据实际情况输入相关参数，然后点击“开始计算”按钮获取结果。";
    fits_threee_title_label.textColor = [UIColor blackColor];
    fits_threee_title_label.textAlignment = NSTextAlignmentLeft;
    fits_threee_title_label.font = [UIFont systemFontOfSize:15];
    fits_threee_title_label.numberOfLines = 0;
    [fits_threee_title_label sizeToFit];
    
    self.fits_threee_itemList = @[
        @{
            @"title":@"沉降系数（C）",
            @"type":@"input",
            @"value":@""
        },
        @{
            @"title":@"土层厚度（H，m）",
            @"type":@"input",
            @"value":@""
        },
        @{
            @"title":@"附加应力（kpa）",
            @"type":@"input",
            @"value":@""
        },
        @{
            @"title":@"土的压缩模量（Es，kpa）",
            @"type":@"input",
            @"value":@""
        },
        @{
            @"title":@"地下水位深度（m）",
            @"type":@"input",
            @"value":@""
        },
        @{
            @"title":@"孔隙比（e）",
            @"type":@"input",
            @"value":@""
        },
    ];
    self.fits_threee_item_value_list = [NSMutableArray arrayWithCapacity:self.fits_threee_itemList.count];
    
    CGFloat max_y = CGRectGetMaxY(fits_threee_title_label.frame) + 20;
    for (int i = 0; i < self.fits_threee_itemList.count; i++) {
        NSDictionary *item = self.fits_threee_itemList[i];
        [self.fits_threee_item_value_list addObject:item[@"value"]];
        UIView *item_view = [self itemViewWithFrame:CGRectMake(0, max_y, self.view.frame.size
                                                               .width, 110) item:item tag:i];
        [fits_threee_scrollView addSubview:item_view];
        max_y = CGRectGetMaxY(item_view.frame);
    }
    
    UIButton *fits_threee_calculate_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [fits_threee_scrollView addSubview:fits_threee_calculate_button];
    fits_threee_calculate_button.frame = CGRectMake(10 , max_y + 20, [UIScreen mainScreen].bounds.size.width - 20, 44);
    [fits_threee_calculate_button setTitle:@"开始计算" forState:UIControlStateNormal];
    [fits_threee_calculate_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fits_threee_calculate_button.titleLabel.font = [UIFont systemFontOfSize:18];
    fits_threee_calculate_button.layer.cornerRadius = 8;
    fits_threee_calculate_button.layer.masksToBounds = YES;
    fits_threee_calculate_button.backgroundColor = [UIColor systemPinkColor];
    [fits_threee_calculate_button addTarget:self action:@selector(fits_threee_calculate_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    fits_threee_scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(fits_threee_calculate_button.frame) + 30);
    
}

- (void)fits_threee_calculate_buttonClick:(UIButton *)button{
    [self.view endEditing:YES];
    NSInteger index = -1;
    for (int i = 0; i < self.fits_threee_item_value_list.count; i ++) {
        NSString *obj = self.fits_threee_item_value_list[i];
        if ([obj isEqualToString:@""] || obj.length == 0) {
            index = i;
            break;
        }
    }
    
    NSString *title = @"提示";
    NSString *message = @"";
    if (index >= 0) {
        NSDictionary *obj = self.fits_threee_itemList[index];
        message = [NSString stringWithFormat:@"%@%@",[obj[@"type"] isEqualToString:@"slider"] ? @"请选择" :@"请输入",obj[@"title"]];
    } else {
        title = @"计算结果";
        CGFloat result = 1.0f;
        
        for (int i = 0; i < self.fits_threee_item_value_list.count; i ++) {
            CGFloat value = [self.fits_threee_item_value_list[i] floatValue];
            result = result * value;
        }
        
        message = [NSString stringWithFormat:@"围堤沉降量: %.2lf m",result / 770000];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)item_slider_value_change:(UISlider *)slider{
    UIView *superView = slider.superview;
    UILabel *label = [superView viewWithTag:1001];
    label.text = [NSString stringWithFormat:@"%.2lf",slider.value];
    [self.fits_threee_item_value_list replaceObjectAtIndex:slider.tag withObject:[NSString stringWithFormat:@"%.2lf",slider.value]];
}

- (UIView *)itemViewWithFrame:(CGRect)frame item:(NSDictionary *)item tag:(int)tag {
    UIView *item_view = [[UIView alloc] initWithFrame:frame];
    
    UILabel *item_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, frame.size.width, 30)];
    [item_view addSubview:item_title_label];
    item_title_label.text = [item objectForKey:@"title"] ? : @"";
    item_title_label.textColor = [UIColor blackColor];
    item_title_label.textAlignment = NSTextAlignmentLeft;
    item_title_label.font = [UIFont boldSystemFontOfSize:16];
    
    NSString *type = [item objectForKey:@"type"];
    if ([type isEqualToString:@"slider"]) {
        UISlider *item_slider = [[UISlider alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(item_title_label.frame), item_view.frame.size.width - 20, 40)];
        [item_view addSubview:item_slider];
        item_slider.minimumValue = 0;
        item_slider.maximumValue = 10.0f;
        item_slider.thumbTintColor = [UIColor systemBlueColor];
        item_slider.minimumTrackTintColor = [UIColor systemBlueColor];
        [item_slider addTarget:self action:@selector(item_slider_value_change:) forControlEvents:UIControlEventValueChanged];
        item_slider.tag = tag;
        
        UILabel *item_min_label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(item_slider.frame), 70, 30)];
        [item_view addSubview:item_min_label];
        item_min_label.text = @"0";
        item_min_label.textColor = [UIColor blackColor];
        item_min_label.textAlignment = NSTextAlignmentLeft;
        item_min_label.font = [UIFont systemFontOfSize:13];
        item_min_label.tag = 1000;
        
        UILabel *item_max_label = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 10 - item_min_label.frame.size.width, item_min_label.frame.origin.y, item_min_label.frame.size.width, item_min_label.frame.size.height)];
        [item_view addSubview:item_max_label];
        item_max_label.text = @"10";
        item_max_label.textColor = [UIColor blackColor];
        item_max_label.textAlignment = NSTextAlignmentRight;
        item_max_label.font = [UIFont systemFontOfSize:13];
        item_max_label.tag = 1001;
        
        item_view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CGRectGetMaxY(item_max_label.frame) + 5);
    } else {
        UITextField *item_input_textField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(item_title_label.frame) + 10, item_view.frame.size.width - 20, 40)];
        [item_view addSubview:item_input_textField];
        item_input_textField.placeholder = @"请输入";
        item_input_textField.layer.borderColor = [UIColor whiteColor].CGColor;
        item_input_textField.layer.borderWidth = 1;
        item_input_textField.layer.cornerRadius = 5;
        item_input_textField.font = [UIFont systemFontOfSize:15];
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        item_input_textField.leftView = leftview;
        item_input_textField.leftViewMode = UITextFieldViewModeAlways;
        item_input_textField.keyboardType = UIKeyboardTypeNumberPad;
        item_input_textField.tag = tag;
        item_input_textField.delegate = self;
        
        item_view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CGRectGetMaxY(item_input_textField.frame) + 5);
    }
    
    item_view.layer.cornerRadius = 8;
    item_view.layer.masksToBounds = YES;

    return item_view;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.fits_threee_item_value_list replaceObjectAtIndex:textField.tag withObject:textField.text];
}
@end
