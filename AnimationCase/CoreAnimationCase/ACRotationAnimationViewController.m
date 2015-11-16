//
//  ACRotationAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/16.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACRotationAnimationViewController.h"

@interface ACRotationAnimationViewController () {
    CALayer *petalLayer;
    BOOL isMoving;
}

@end

@implementation ACRotationAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isMoving = NO;
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    petalLayer = [[CALayer alloc] init];
    petalLayer.bounds = CGRectMake(0, 0, 10, 20);
    petalLayer.position = CGPointMake(50, 150);
    petalLayer.anchorPoint = CGPointMake(0.5, 0.6);
    petalLayer.contents = (id)[UIImage imageNamed:@"petal.png"].CGImage;
    
    [self.view.layer addSublayer:petalLayer];
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
    if (isMoving) {
        return;
    }
    
    UITouch *touch = touches.anyObject;
    CGPoint destination = [touch locationInView:self.view];
    
    CAAnimation *animation = [petalLayer animationForKey:@"petalLayer_rotationAnimation"];
    if (animation) {
        if (petalLayer.speed == 0) {
            [self animationMoveTo:destination];
            [self animationResume];
        } else {
            [self animationPause];
        }
    } else {
        //创建并开始动画
        [self animationMoveTo:destination];
        [self animationRotate];
    }
}

#pragma mark - Animation

- (void)animationMoveTo:(CGPoint)location {
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.toValue = [NSValue valueWithCGPoint:location];
    moveAnimation.duration = [self petalMoveDuring:location];
    moveAnimation.repeatCount = 0;
    moveAnimation.removedOnCompletion = YES;
    
    moveAnimation.delegate = self;
    [moveAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"petalLayer_moveAnimation_destination"];
    
    [petalLayer addAnimation:moveAnimation forKey:@"petalLayer_moveAnimation"];
}

- (void)animationRotate {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.duration = 6;
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.autoreverses = YES;
//    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    [petalLayer addAnimation:rotateAnimation forKey:@"petalLayer_rotationAnimation"];
}

- (NSTimeInterval)petalMoveDuring:(CGPoint)destination {
    CGFloat deltaX = destination.x - petalLayer.position.x;
    CGFloat deltaY = destination.y - petalLayer.position.y;
    CGFloat distance = sqrt(deltaX*deltaX + deltaY*deltaY);
    return (NSTimeInterval)distance/50.0;
}

- (void)animationPause {
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval = [petalLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [petalLayer setTimeOffset:interval];
    //速度设置为0，暂停动画
    petalLayer.speed = 0;
}

- (void)animationResume {
    //获得暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - petalLayer.timeOffset;
    //设置偏移量
    petalLayer.timeOffset = 0;
    //设置开始时间
    petalLayer.beginTime = beginTime;
    //设置动画速度，开始运动
    petalLayer.speed = 1.0;
}

#pragma mark - Animation Delegate

- (void)animationDidStart:(CAAnimation *)anim {
    isMoving = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    petalLayer.position=[[anim valueForKey:@"petalLayer_moveAnimation_destination"] CGPointValue];
    [CATransaction commit];
    isMoving = NO;
    [self animationPause];
}

@end
