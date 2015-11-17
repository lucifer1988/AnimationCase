//
//  ACKeyFrameAnimationByPathViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/17.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACKeyFrameAnimationByPathViewController.h"

@interface ACKeyFrameAnimationByPathViewController () {
    CALayer *petalLayer;
}

@end

@implementation ACKeyFrameAnimationByPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    petalLayer = [[CALayer alloc] init];
    petalLayer.bounds = CGRectMake(0, 0, 10, 20);
    petalLayer.position = CGPointMake(100, 150);
    petalLayer.contents = (id)[UIImage imageNamed:@"petal.png"].CGImage;
    
    [self.view.layer addSublayer:petalLayer];
    
    [self addKeyframeMoveAnimation];
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

#pragma mark - animation

- (void)addKeyframeMoveAnimation {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, petalLayer.position.x, petalLayer.position.y);
    CGPathAddCurveToPoint(path, NULL, 300, 250, -100, 450, 100, 550);
//    CGPathAddCurveToPoint(path, NULL, 150, 150, 250, 350, 250, 550);
    
    
    keyframeAnimation.path = path;
    CGPathRelease(path);
    keyframeAnimation.duration = 8.0;
    keyframeAnimation.beginTime = CACurrentMediaTime()+2;
    keyframeAnimation.delegate = self;
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(100, 550)] forKey:@"petalLayer_keyframeAnimation_destination"];
//    [keyframeAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(250, 550)] forKey:@"petalLayer_keyframeAnimation_destination"];
    
    [petalLayer addAnimation:keyframeAnimation forKey:@"petalLayer_keyframeAnimation_position"];
}

#pragma mark - animation delegate

- (void)animationDidStart:(CAAnimation *)anim {
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    petalLayer.position = [[anim valueForKey:@"petalLayer_keyframeAnimation_destination"] CGPointValue];
    [CATransaction commit];
}

@end