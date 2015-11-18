//
//  ACViewMoveAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/17.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACViewMoveAnimationViewController.h"

@interface ACViewMoveAnimationViewController () {
    UIImageView *petalView;
}

@end

@implementation ACViewMoveAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    petalView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"petal.png"]];
    petalView.center = CGPointMake(50, 150);
    [self.view addSubview:petalView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    //方法1：block方式
    /*开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
     duration:执行时间
     delay:延迟时间
     options:动画设置，例如自动恢复、匀速运动等
     completion:动画完成回调方法
     */
    [UIView animateWithDuration:[self petalMoveDuring:[touch locationInView:self.view]] delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        petalView.center = location;
    } completion:nil];
    //方法2：静态方法
    //开始动画
    //[UIView beginAnimations:@"KCBasicAnimation" context:nil];
    //[UIView setAnimationDuration:5.0];
    //[UIView setAnimationDelay:1.0];//设置延迟
    //[UIView setAnimationRepeatAutoreverses:NO];//是否回复
    //[UIView setAnimationRepeatCount:10];//重复次数
    //[UIView setAnimationStartDate:(NSDate *)];//设置动画开始运行的时间
    //[UIView setAnimationDelegate:self];//设置代理
    //[UIView setAnimationWillStartSelector:(SEL)];//设置动画开始运动的执行方法
    //[UIView setAnimationDidStopSelector:(SEL)];//设置动画运行结束后的执行方法
    //petalView.center = location;
    //开始动画
    //[UIView commitAnimations];
}

- (NSTimeInterval)petalMoveDuring:(CGPoint)destination {
    CGFloat deltaX = destination.x - petalView.center.x;
    CGFloat deltaY = destination.y - petalView.center.y;
    CGFloat distance = sqrt(deltaX*deltaX + deltaY*deltaY);
    NSLog(@"%f", distance);
    return (NSTimeInterval)distance/50.0;
}

@end
