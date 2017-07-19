//
//  ViewController.m
//  YG_Alert
//
//  Created by yhj on 2017/7/19.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"弹框样式";
    
    [self configUI];
}


- (void)configUI
{
    self.arr= @[@"SimpleAlert",@"ConfirmAlert",@"CancelAndConfirmAlert"];
    for (int i = 0; i < self.arr.count; i++)
    {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = RGB16(0xf8f8f8);
        btn.alpha = .6;
        [btn setTitle:self.arr[i] forState:0];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        ViewBorderRadius(btn, 1, 1, [UIColor orangeColor]);
        btn.tag = i;
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(230+i*50);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(230);
        }];
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnEvent:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        YG_AlertView *alertView = [[YG_AlertView alloc]initWithAlertStyle:SimpleAlertStyle width:.6];
        alertView.isClickBgExit = YES;
        alertView.contentTextLabel.text = @"SimpleAlertStyle";
    }
    else if (sender.tag == 1)
    {
        YG_AlertView *alertView = [[YG_AlertView alloc]initWithAlertStyle:ConfirmAlertStyle];
        alertView.headerTitleLabel.text = @"ConfirmAlert";
        alertView.contentTextLabel.attributedText = [YG_TextHelper attributedString:@"ConfirmAlertConfirmAlertConfirmAlertConfirmAlertConfirmAlert" lineSpacing:5];
        [alertView.confirmBtn setTitle:@"确定" forState:0];
        alertView.confirm = ^{
            NSLog(@"点击确定操作呢");
        };
    }
    else
    {
        YG_AlertView *alertView = [[YG_AlertView alloc]initWithAlertStyle:CancelAndConfirmAlertStyle];
        alertView.headerTitleLabel.text = @"CancelAndConfirmAlert";
        alertView.contentTextLabel.attributedText = [YG_TextHelper attributedString:@"CancelAndConfirmAlertCancelAndConfirmAlertCancelAndConfirmAlertCancelAndConfirmAlertCancelAndConfirmAlertCancelAndConfirmAlert" lineSpacing:5];
        [alertView.confirmBtn setTitle:@"确定" forState:0];
        [alertView.cancelBtn setTitle:@"取消" forState:0];
        alertView.themeColor = [UIColor redColor];
        alertView.confirm = ^{
            NSLog(@"点击确定操作呢");
        };
        alertView.cancel = ^{
             NSLog(@"点击取消操作呢");
        };
    }
}


@end
