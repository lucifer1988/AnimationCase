//
//  ACMoveAnimationFullEditionViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/16.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACMoveAnimationFullEditionViewController.h"

@interface ACMoveAnimationFullEditionViewController () {
    CALayer *petalLayer;
    BOOL isMoving;
}

@end

@implementation ACMoveAnimationFullEditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isMoving = NO;
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    petalLayer = [[CALayer alloc] init];
    petalLayer.bounds = CGRectMake(0, 0, 10, 20);
    petalLayer.position = CGPointMake(50, 150);
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
    [self animationMoveTo:[touch locationInView:self.view]];
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

- (NSTimeInterval)petalMoveDuring:(CGPoint)destination {
    CGFloat deltaX = destination.x - petalLayer.position.x;
    CGFloat deltaY = destination.y - petalLayer.position.y;
    CGFloat distance = sqrt(deltaX*deltaX + deltaY*deltaY);
    return (NSTimeInterval)distance/50.0;
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
}

@end
