//
//  LockView.m
//  GesturesPasswordDemo
//
//  Created by xiangronghua on 2017/6/1.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "LockView.h"

#define LINECOLOR [UIColor whiteColor]
#define SWHITH [UIScreen mainScreen].bounds.size.width
#define SHIGHT [UIScreen mainScreen].bounds.size.height
CGPoint Aloc;
CGPoint Bloc;
int markBtn;

@interface LockView ()

@property (strong, nonatomic) NSArray *buttons;//保存所有按钮
@property (strong, nonatomic) NSMutableArray *selectedButtons;//保存所有“碰过”的按钮
@property (strong, nonatomic) UIColor *lineColor;//定义一个线的颜色
@property (assign, nonatomic) CGPoint currentPoint;//记录最后用户触摸的点

@end

@implementation LockView

- (UIColor *)lineColor {
    if (_lineColor == nil) {
        _lineColor = LINECOLOR;
    }
    return _lineColor;
}

- (NSMutableArray *)selectedButtons {
    if (_selectedButtons == nil) {
        _selectedButtons = [[NSMutableArray alloc] init];
    }
    return _selectedButtons;
}

- (NSArray *)buttons {
    if (_buttons == nil) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 9; i++) {
            UIButton *button = [[UIButton alloc] init];
            button.tag = i;
            
            button.userInteractionEnabled = NO;
            
            //设置按钮的背景图片
            [button setBackgroundImage:[UIImage imageNamed:@"patternround_normal.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"patternround_error.png"] forState:UIControlStateDisabled];
            
            [self addSubview:button];
            [arrayM addObject:button];
        }
        _buttons = arrayM;
    }
    return _buttons;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //计算每个按钮的x和y
    //设置每个按钮的frame
    CGFloat w = 45;
    CGFloat h = 45;
    
    // 列（和行）的个数
    int columns = 3;
    //计算水平方向和垂直方向的间距
    CGFloat marginX = (self.frame.size.width - columns * w) / (columns + 1);
    CGFloat marginY = (self.frame.size.height - columns * h) / (columns + 1);
    
    //计算每个按钮的x和y
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = [self.buttons objectAtIndex:i];
        
        //计算当前按钮所在的行号
        int row = i / columns;
        //计算当前按钮所在的列号
        int col = i % columns;
        
        CGFloat x = marginX + col * (w + marginX);
        CGFloat y = marginY + row * (h + marginY);
        
        button.frame = CGRectMake(x, y, w, h);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //1、获取当前触摸的点
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:touch.view];
    
    //不区分方向
    // 2. 循环判断当前触摸的点在哪个按钮的范围之内, 找到对一个的按钮之后, 把这个按钮的selected = YES
    //    for (int i = 0; i < self.buttons.count; i++) {
    //        UIButton* button = self.buttons[i];
    //        if (CGRectContainsPoint(button.frame, loc) && !button.selected) {
    //            button.selected = YES;
    //            [self.selectedButtons addObject:button];
    //            break;
    //        }
    //    }

    //区分方向
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = [self.buttons objectAtIndex:i];
        
        if (CGRectContainsPoint(button.frame, loc) && !button.selected) {
            button.selected = YES;
            Aloc = button.frame.origin;
            
            if (Aloc.x == Bloc.x && Aloc.y>Bloc.y) {
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_down.png"] forState:UIControlStateSelected];
            } else if (Aloc.x==Bloc.x && Aloc.y<Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_up.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.y==Bloc.y && Aloc.x>Bloc.x){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_right.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.y==Bloc.y && Aloc.x<Bloc.x){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_left.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x>Bloc.x && Aloc.y>Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Dright.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x<Bloc.x && Aloc.y<Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Tleft.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x>Bloc.x && Aloc.y<Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Tright.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x<Bloc.x && Aloc.y>Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Dleft.png"] forState:UIControlStateSelected];
            }
            markBtn = i;
            [self.selectedButtons addObject:button];
            break;
        }
    }
    Bloc = Aloc;
    
    //3、重绘
//    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    // 1. 获取当前触摸的点
    UITouch* touch = touches.anyObject;
    CGPoint loc = [touch locationInView:touch.view];
    
    self.currentPoint = loc;
    
    // 2. 循环判断当前触摸的点在哪个按钮的范围之内, 找到对一个的按钮之后, 把这个按钮的selected = YES
    //不区分方向
    //    for (int i = 0; i < self.buttons.count; i++) {
    //        UIButton* button = self.buttons[i];
    //        if (CGRectContainsPoint(button.frame, loc) && !button.selected) {
    //            button.selected = YES;
    //            [self.selectedButtons addObject:button];
    //            break;
    //        }
    //    }
    
    //区分方向
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton* button = self.buttons[i];
        if (CGRectContainsPoint(button.frame, loc) && !button.selected) {
            button.selected = YES;
            Aloc=button.frame.origin;
            
            if (Aloc.x==Bloc.x && Aloc.y>Bloc.y) {
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_down.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x==Bloc.x && Aloc.y<Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_up.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.y==Bloc.y && Aloc.x>Bloc.x){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_right.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.y==Bloc.y && Aloc.x<Bloc.x){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_left.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x>Bloc.x && Aloc.y>Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Dright.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x<Bloc.x && Aloc.y<Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Tleft.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x>Bloc.x && Aloc.y<Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Tright.png"] forState:UIControlStateSelected];
                
            }else if (Aloc.x<Bloc.x && Aloc.y>Bloc.y){
                [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
                [self.buttons[markBtn] setBackgroundImage:[UIImage imageNamed:@"patternround_clicked_Dleft.png"] forState:UIControlStateSelected];
                
            }
            markBtn =i;
            
            [self.selectedButtons addObject:button];
            
            break;
        }
    }
    
    Bloc =Aloc;
    
    // 3. 重绘
    [self setNeedsDisplay];
}


//手指抬起事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //1、获取用户绘制的密码
    NSMutableString *password = [[NSMutableString alloc] init];
    
    for (UIButton *button in self.selectedButtons) {
        [password appendFormat:@"%@",@(button.tag)];
    }
    
    NSString *passwordOne = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwordOne"];
    NSString *passwordGlock = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwordGlock"];
    
    if (!passwordGlock) {
        if (!passwordOne && password.length >= 4) {
            
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"passwordOne"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //保存第一次设置的手势密码
            
            if ([self.delegate respondsToSelector:@selector(setPassWordNotice:)]) {
                [self.delegate  setPassWordNotice:@"请再次输入新密码"];
            }
            [self clear];
            
        } else if (!passwordOne && password.length < 4) {
            
            if ([self.delegate respondsToSelector:@selector(setPassWordNotice:)]) {
                [self.delegate setPassWordNotice:@"最少设置四位手势密码"];
            }
            [self clear];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"passwordTwo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //保存第二次设置的手势密码
//            [self clear];
            [self comparePassword:password];
         }
    } else {
        [self comparePassword:password];
    }
    
    // 3. 根据控制器返回的密码判断结果, 执行不同的重绘操作
    //--------------------- 重绘 ---------------------------------

}

- (void)comparePassword:(NSString *)password {
    
    NSString * passwordOne =[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordOne"];
    NSString * passwordTwo =[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordTwo"];
    NSString * passwordGlock =[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordGlock"];
    if ([self.delegate respondsToSelector:@selector(setPassWordNotice:)]) {
        
        if (!passwordGlock) {
            if ([passwordTwo isEqualToString:passwordOne]) {
                
                [self.delegate setPassWordNotice:@"密码设置成功"];
                [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"passwordGlock"];
                
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordOne"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordTwo"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                //设置成功 去除设置记录
                [self clear];
                
            } else {
                
                [self.delegate setPassWordNotice:@"两次密码设置不一致，请您重新设置密码"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordOne"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordTwo"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                //设置成功 去除设置记录 重新设置
                for (UIButton *button in self.selectedButtons) {
                    button.selected = NO;
                    button.enabled = NO;
                }
                
                self.lineColor = [UIColor redColor];
                [self setNeedsDisplay];
                self.userInteractionEnabled = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self clear];
                    self.userInteractionEnabled = YES;
                });
            }
        } else {
            if ([password isEqualToString:passwordGlock]) {
                [self.delegate setPassWordNotice:@"解锁成功"];
                [self clear];
            } else {
                [self.delegate setPassWordNotice:@"解锁失败"];
                for (UIButton *button in self.selectedButtons) {
                    button.selected = NO;
                    button.enabled = NO;
                }
                self.lineColor = [UIColor redColor];
                [self setNeedsDisplay];
                self.userInteractionEnabled = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self clear];
                    self.userInteractionEnabled = YES;
                });
            }
        }
    }
}

- (void)clear {
    
    //先将所有selectedButtons中的按钮selected 设置为NO
    for (UIButton *button in self.selectedButtons) {
        button.selected = NO;
        button.enabled  = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"patternround_clicked.png"] forState:UIControlStateSelected];
    }
    self.lineColor = LINECOLOR;
    
    //移除所有的按钮
    [self.selectedButtons removeAllObjects];
    
    //重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //    if (self.selectedButtons.count > 0) {
    //        // 需要绘图
    //    }
    
    if (self.selectedButtons.count == 0) return;
        
    UIBezierPath *path = [[UIBezierPath alloc] init];
        
    [path setLineWidth:5.0];
        
    //循环获取每个按钮的中心点，然后连线
    for (int i = 0; i < self.selectedButtons.count; i++) {
        UIButton *button = [self.selectedButtons objectAtIndex:i];
        if (i == 0 && self.selectedButtons.count != 1) {
                
            //如果是第一个按钮，那么久把这个按钮的中心点作为起点
            [path moveToPoint:button.center];
        } else if (self.selectedButtons.count == 1) {
            path = nil;
        }
        else {
            [path addLineToPoint:button.center];
        }
    }
    //把最后手指的位置和最后一个按钮的中心点连起来
    [path addLineToPoint:self.currentPoint];
    // 设置线条颜色
    [self.lineColor set];
    // 渲染
    [path stroke];
}

@end
