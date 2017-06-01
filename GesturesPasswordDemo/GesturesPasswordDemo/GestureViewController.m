//
//  GestureViewController.m
//  GesturesPasswordDemo
//
//  Created by xiangronghua on 2017/6/1.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "GestureViewController.h"
#import "LockViewController.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)setPassword {
    
    NSString * passwordGlock =[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordGlock"];
    if (passwordGlock) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经设置手势密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        
        LockViewController * lock =[LockViewController new];
        [self presentViewController:lock animated:YES completion:nil];
    }
}

- (IBAction)resetPassword {
    
    NSString * passwordGlock =[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordGlock"];
    if (passwordGlock) {
        
        LockViewController * lock =[LockViewController new];
        [self presentViewController:lock animated:YES completion:nil];
        lock.reset=@"请输入原密码";
        lock.resetIs=@"resetIs";
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未设置手势密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}



@end
