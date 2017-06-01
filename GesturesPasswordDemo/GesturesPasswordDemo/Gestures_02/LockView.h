//
//  LockView.h
//  GesturesPasswordDemo
//
//  Created by xiangronghua on 2017/6/1.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LockViewDelegate <NSObject>

- (void)setPassWordNotice:(NSString *)notice;

@end

@interface LockView : UIView

@property (weak, nonatomic) id <LockViewDelegate> delegate;

@end
