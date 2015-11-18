//
//  ACViewSpringAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/18.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACViewSpringAnimationViewController.h"

@interface ACViewSpringAnimationViewController () {
    UIImageView *ballView;
}

@end

@implementation ACViewSpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball"]];
    ballView.center = self.view.center;
    [self.view addSubview:ballView];
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
    /*创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     */
    [UIView animateWithDuration:[self petalMoveDuring:location] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        ballView.center = location;
    } completion:nil];
}

- (NSTimeInterval)petalMoveDuring:(CGPoint)destination {
    CGFloat deltaX = destination.x - ballView.center.x;
    CGFloat deltaY = destination.y - ballView.center.y;
    CGFloat distance = sqrt(deltaX*deltaX + deltaY*deltaY);
    NSLog(@"%f", distance);
    return (NSTimeInterval)distance/150.0;
}

@end
