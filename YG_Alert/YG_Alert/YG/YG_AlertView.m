//
//  YG_AlertView.m
//  YG_Alert
//
//  Created by yhj on 2017/7/19.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "YG_AlertView.h"
#import <Masonry.h>
#import <RRGB.h>

@interface YG_AlertView ()

@property (nonatomic,strong) NSArray *themeArr;

@end

@implementation YG_AlertView

- (instancetype)initWithAlertStyle:(AlertViewStyle)alertViewStyle
{
    self = [super init];
    if (self) {
        [self initWindow:alertViewStyle];
    }
    return self;
}

- (instancetype)initWithAlertStyle:(AlertViewStyle)alertViewStyle width:(CGFloat)width
{
    self = [super init];
    if (self) {
        [self initWindow:alertViewStyle];
        [self setAlertViewWidth:width];
    }
    return self;
}


/**
  设置弹框宽度
 @param width 宽度值范围 0-1 百分比
 */
-(void)setAlertViewWidth:(CGFloat)width
{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (width > 1) {
            make.width.mas_equalTo(width);
        }
        else if (width > 0 && width <= 1)
        {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width*width);
        }
        else
        {
             make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width*.8);
        }
    }];
}


- (void)initWindow:(AlertViewStyle)alertViewStyle
{
    [self viewConfigUI];
    
    switch (alertViewStyle) {
        case SimpleAlertStyle:
            [self simpleAlertViewConfigUI];
            break;
            
            case ConfirmAlertStyle:
            [self confirmAlertViewConfigUI];
            break;
            
            case CancelAndConfirmAlertStyle:
            [self cancelAndConfirmAlertViewConfigUI];
            break;
            
        default:
            break;
    }
    
    [self TweeningAnimation];
    
    [self initData];
}

- (void)initData
{
    self.themeArr = @[RGB16(0X1abc9c),RGB16(0X27ae60),RGB16(0X2980b9),RGB16(0X2c3e50),RGB16(0Xf39c12),RGB16(0Xc0392b),RGB16(0X7f8c8d),RGB16(0X8e44ad)];
    self.confirmBtn.backgroundColor=self.themeArr[(arc4random()%8)];
    [self.confirmBtn setTitleColor:WhiteColor forState:0];
}

- (void)TweeningAnimation
{
    self.mainView.transform = CGAffineTransformMakeTranslation(0,100);

    [UIView animateWithDuration:.1 delay:0 usingSpringWithDamping:.3 initialSpringVelocity:.5 options:UIViewAnimationOptionTransitionNone animations:^{
        self.mainView.transform = CGAffineTransformMakeTranslation(0,0);
    } completion:^(BOOL finished) {
        
    }];
    
}


/**
 设置背景颜色
 */
- (void)setThemeColor:(UIColor *)themeColor
{
    self.confirmBtn.backgroundColor=themeColor;
    [self.confirmBtn setTitleColor:WhiteColor forState:0];
}


/**
  点击是否关闭弹框
 */
- (void)setIsClickBgExit:(BOOL)isClickBgExit
{
    if (isClickBgExit) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exit)];
        [self addGestureRecognizer:tap];
    }
}


/**
 关闭弹框
 */
-(void)exit
{
    [self removeFromSuperview];
}


- (void)simpleAlertViewConfigUI
{
    self.contentTextLabel.font = Font_Number(16);
    [self.contentView addSubview:self.contentTextLabel];
    [self.contentTextLabel sizeToFit];
    
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)confirmAlertViewConfigUI
{
    [self.mainView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.contentTextLabel];
    
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTextLabel.mas_bottom).offset(10);
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)cancelAndConfirmAlertViewConfigUI
{
    [self.mainView addSubview:self.cancelBtn];
    [self.mainView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.contentTextLabel];
    
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    NSMutableArray *arr = @[].mutableCopy;
    [arr addObject:self.cancelBtn];
    [arr addObject:self.confirmBtn];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.contentTextLabel.mas_bottom).offset(15);
    }];
}

- (void)viewConfigUI
{
    UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
    [window addSubview:self];
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
    [self addSubview:self.mainView];
    [self.mainView insertSubview:self.closeBtn atIndex:999];
    [self.mainView addSubview:self.headerTitleLabel];
    [self.mainView insertSubview:self.contentView atIndex:0];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    self.mainView.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(APPW*.8);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.width.height.mas_equalTo(35);
    }];
    
    [self.headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-30);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.headerTitleLabel.mas_left);
        make.right.bottom.mas_equalTo(-10);
    }];
}

#pragma mark 懒加载
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = WhiteColor;
        ViewBorderRadius(_mainView,5, 1, ClearColor);
    }
    return _mainView;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton new];
        [_closeBtn setImage:[UIImage imageNamed:@"closed"] forState:0];
        [_closeBtn addTarget:self action:@selector(closeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)closeBtnEvent:(UIButton *)sender
{
    [self exit];
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton new];
        _confirmBtn.backgroundColor = RGB16(0Xfddb43);
        [_confirmBtn setTitle:@"确定" forState:0];
        [_confirmBtn setTitleColor:RGB16(0X3d3d3d) forState:0];
        _confirmBtn.titleLabel.font = Font_Number(16);
        [_confirmBtn addTarget:self action:@selector(confirmBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)confirmBtnEvent:(UIButton *)sender
{
    if (self.confirm) {
        self.confirm();
    }
    [self exit];
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        _cancelBtn.backgroundColor = RGB16(0Xfddb43);
        [_cancelBtn setTitle:@"取消" forState:0];
        [_cancelBtn setTitleColor:RGB16(0X3d3d3d) forState:0];
        _cancelBtn.titleLabel.font = Font_Number(16);
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)cancelBtnEvent:(UIButton *)sender
{
    if (self.cancel) {
        self.cancel();
    }
    [self exit];
}


- (UILabel *)headerTitleLabel
{
    if (!_headerTitleLabel) {
        _headerTitleLabel = [UILabel new];
        _headerTitleLabel.font = Font_Number(16);
        _headerTitleLabel.textAlignment = NSTextAlignmentCenter;
        _headerTitleLabel.textColor = RGB16(0X3d3d3d);
    }
    return _headerTitleLabel;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = WhiteColor;
    }
    return _contentView;
}

- (UILabel *)contentTextLabel
{
    if (!_contentTextLabel) {
        _contentTextLabel = [UILabel new];
        _contentTextLabel.font = Font_Number(13);
        _contentTextLabel.textAlignment = NSTextAlignmentCenter;
        _contentTextLabel.textColor = RGB16(0X898989);
        _contentTextLabel.numberOfLines=0;
    }
    return _contentTextLabel;
}

@end
