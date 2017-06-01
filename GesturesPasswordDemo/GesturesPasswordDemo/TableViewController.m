//
//  TableViewController.m
//  GesturesPasswordDemo
//
//  Created by xiangronghua on 2017/6/1.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "TableViewController.h"
#import "XDGestureLoginVC.h"
#import "XDGestureConfigVC.h"
#import "GestureViewController.h"

@interface TableViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = @[@"创建手势密码", @"验证手势密码",@"仿QQ手势"];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        XDGestureConfigVC *vc1 = [[XDGestureConfigVC alloc] init];
        [self.navigationController pushViewController:vc1 animated:YES];
    }
    if (indexPath.row == 1) {
        XDGestureLoginVC *vc2 = [[XDGestureLoginVC alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    if (indexPath.row == 2) {
        GestureViewController *vc3 = [[GestureViewController alloc] init];
        [self.navigationController pushViewController:vc3 animated:YES];
    }
}



@end
