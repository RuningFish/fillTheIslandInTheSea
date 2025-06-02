//
//  FITSFeedbackViewController.m
//  FillIslandInTheSea
//
//  Created by runingfish on 2025/6/1.
//

#import "FITSFeedbackViewController.h"
@implementation FITSFeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    UILabel *fits_feedback_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 40)];
    [self.view addSubview:fits_feedback_title_label];
    fits_feedback_title_label.text = @"请填写您的意见或建议";
    fits_feedback_title_label.textColor = [UIColor blackColor];
    fits_feedback_title_label.textAlignment = NSTextAlignmentLeft;
    fits_feedback_title_label.font = [UIFont systemFontOfSize:16];
    
    UITextView *fits_feedback_textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(fits_feedback_title_label.frame) + 10, self.view.frame.size.width-20, 180)];
    [self.view addSubview:fits_feedback_textView];
    fits_feedback_textView.layer.borderWidth = 1;
    fits_feedback_textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    fits_feedback_textView.layer.cornerRadius = 5;
    fits_feedback_textView.layer.masksToBounds = YES;
    
    UIButton *fits_feedback_confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:fits_feedback_confirmButton];
    fits_feedback_confirmButton.frame = CGRectMake(10, CGRectGetMaxY(fits_feedback_textView.frame)+37, [UIScreen mainScreen].bounds.size.width-20, 44);
    [fits_feedback_confirmButton setTitle:@"提交反馈" forState:UIControlStateNormal];
    [fits_feedback_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fits_feedback_confirmButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [fits_feedback_confirmButton addTarget:self action:@selector(fits_feedback_confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    fits_feedback_confirmButton.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];;
    fits_feedback_confirmButton.layer.cornerRadius = 10;
    fits_feedback_confirmButton.layer.masksToBounds = YES;
    
    
    NSLog(@"234");
}

- (void)fits_feedback_confirmButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
