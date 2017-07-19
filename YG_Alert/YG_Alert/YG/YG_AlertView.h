//
//  YG_AlertView.h
//  YG_Alert
//
//  Created by yhj on 2017/7/19.
//  Copyright © 2017年 VG. All rights reserved.
//

#import <UIKit/UIKit.h>

// 弹框类型
typedef NS_ENUM(NSInteger,AlertViewStyle)
{
    SimpleAlertStyle,           //  最简单  无按钮
    ConfirmAlertStyle,          //  只有一个确定按钮
    CancelAndConfirmAlertStyle  //  有两个按钮
};


@interface YG_AlertView : UIView

- (instancetype)initWithAlertStyle:(AlertViewStyle)alertViewStyle;

- (instancetype)initWithAlertStyle:(AlertViewStyle)alertViewStyle width:(CGFloat)width;

- (void)exit ;

@property (nonatomic,copy) void(^confirm)();

@property (nonatomic,copy) void(^cancel)();

@property (nonatomic,assign) UIColor *themeColor;

@property (nonatomic,strong) UIView *mainView;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *headerTitleLabel;

@property (nonatomic,strong) UILabel *contentTextLabel;

@property (nonatomic,strong) UIButton *closeBtn;

@property (nonatomic,strong) UIButton *confirmBtn;

@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,assign) BOOL isClickBgExit;

@end
