//
//  LockViewController.m
//  GesturesPasswordDemo
//
//  Created by xiangronghua on 2017/6/1.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "LockViewController.h"
#import "LockView.h"
#define SWHITH [UIScreen mainScreen].bounds.size.width
#define SHIGHT [UIScreen mainScreen].bounds.size.height

static int countMark;
@interface LockViewController ()<LockViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIButton *overlookBtn;
@property (strong, nonatomic) UILabel *promptBoardLabel;

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios_pattern_bg"]];
    
    LockView *lockview = [[LockView alloc]init];
    lockview.backgroundColor = [UIColor clearColor];
    lockview.delegate = self;
    lockview.frame=CGRectMake((SWHITH- 590*SWHITH/750)/2, 480*SHIGHT/1350, 590*SWHITH/750, 590*SWHITH/750);

    [self.view addSubview:lockview];
    
    countMark=0;
    
    [self logoSet];
    [self overlook];
    [self userName];
    [self promptBoard];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //避免因程序意外退出时保存上次结果
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordOne"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordTwo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _promptBoardLabel.text = _reset;
    if ([_resetIs isEqualToString:@"resetIs"]) {
        _overlookBtn.hidden = YES;
    }
}

//logo
- (void)logoSet {
    UIImageView * logoImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    logoImage.frame =CGRectMake(280*SWHITH/750, 140*SHIGHT/1350, 200*SWHITH/750, 185*SHIGHT/1350);
    [self.view addSubview: logoImage];
}

//跳过按钮
- (void)overlook {
    _overlookBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_overlookBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [_overlookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _overlookBtn.frame =CGRectMake(SWHITH*2/3, 1150*SHIGHT/1350, SWHITH*1/3, 120);
    _overlookBtn.titleLabel.textAlignment =NSTextAlignmentCenter;
    [_overlookBtn addTarget:self action:@selector(overlookjump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _overlookBtn];
}

-(void)overlookjump{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//用户名称
- (void)userName {
    UILabel * userName =[[UILabel alloc]initWithFrame:CGRectMake(230*SWHITH/750, 280*SHIGHT/1350, 280*SWHITH/750, 55*SHIGHT/1350)];
    userName.textColor =[UIColor colorWithRed:25/255.0 green:173/255.0 blue:255/255.0 alpha:1.0];
    userName.text =@"vicool";
    userName.adjustsFontSizeToFitWidth =YES;
    userName.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:userName];
}

//警告提示栏
-(void)promptBoard {
    _promptBoardLabel =[[UILabel alloc]initWithFrame:CGRectMake((SWHITH- 570*SWHITH/750)/2, 340*SHIGHT/1350, 570*SWHITH/750, 120*SHIGHT/1350)];
    _promptBoardLabel.textColor =[UIColor colorWithRed:25/255.0 green:173/255.0 blue:255/255.0 alpha:1.0];
    
    _promptBoardLabel.adjustsFontSizeToFitWidth =YES;
    _promptBoardLabel.numberOfLines =0;
    _promptBoardLabel.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:_promptBoardLabel];
}

//设置成功
- (void)setPassWordNotice:(NSString *)notice {
    
    _promptBoardLabel.text = notice;
    _promptBoardLabel.textColor =[UIColor colorWithRed:25/255.0 green:173/255.0 blue:255/255.0 alpha:1.0];
    if ([notice isEqualToString:@"密码设置成功"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([notice isEqualToString:@"解锁成功"]) {
        if ([_resetIs isEqualToString:@"resetIs"]) {
            _promptBoardLabel.text = @"验证成功";
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordGlock"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else if ([notice isEqualToString:@"两次密码设置不一致，请您重新设置密码"]||[notice isEqualToString:@"解锁失败"]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationRepeatCount:5];
        [UIView animateWithDuration:0.01 animations:^{
            
            _promptBoardLabel.frame =CGRectMake((SWHITH- 575*SWHITH/750)/2, 335*SHIGHT/1350, 570*SWHITH/750, 120*SHIGHT/1350);
            
        }completion:^(BOOL finished) {
            
            _promptBoardLabel.frame =CGRectMake((SWHITH- 570*SWHITH/750)/2, 340*SHIGHT/1350, 570*SWHITH/750, 120*SHIGHT/1350);
            [UIView commitAnimations];
        }];
        _promptBoardLabel.textColor =[UIColor redColor];
        
        if ([notice isEqualToString:@"解锁失败"]) {
            countMark++;
            if(countMark ==1){
                
                _promptBoardLabel.text =@"您的解锁密码输入有误";
                
            }else if(countMark ==5){
                
                _promptBoardLabel.text =[NSString stringWithFormat:@"您的解锁密码输入错误，累计已到%d次",countMark];
                
                [UIView commitAnimations];
                //                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"手势密码已失效" message:@"请您重新登录！" preferredStyle:UIAlertControllerStyleAlert];
                //                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleCancel handler:nil];
                //                [alertController addAction:cancelAction];
                //                [self presentViewController:alertController animated:YES completion:nil];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"手势密码已失效" message:@"请您重新登录！" delegate:self cancelButtonTitle:@"重新登录" otherButtonTitles:nil];
                [alert show];
                
            }else{
                
                _promptBoardLabel.text =[NSString stringWithFormat:@"您的解锁密码输入错误，累计已到%d次",countMark];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //进行重新登录跳转
}
//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

@end
