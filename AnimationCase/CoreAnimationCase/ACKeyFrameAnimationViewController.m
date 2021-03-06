//
//  ACKeyFrameAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/16.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACKeyFrameAnimationViewController.h"

@interface ACKeyFrameAnimationViewController () {
    CALayer *petalLayer;
}

@end

@implementation ACKeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    petalLayer = [[CALayer alloc] init];
    petalLayer.bounds = CGRectMake(0, 0, 10, 20);
    petalLayer.position = CGPointMake(50, 150);
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
    //关键帧动画的初始值不能省略
    NSValue *key1 = [NSValue valueWithCGPoint:petalLayer.position];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 320)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45, 400)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(55, 500)];
    NSArray *values = @[key1, key2, key3, key4];
    
    keyframeAnimation.values = values;
    [keyframeAnimation setKeyTimes:@[@0.0, @0.5, @0.75, @1.0]];
    keyframeAnimation.duration = 8.0;
    keyframeAnimation.beginTime = CACurrentMediaTime()+2;
    keyframeAnimation.delegate = self;
    [keyframeAnimation setValue:key4 forKey:@"petalLayer_keyframeAnimation_destination"];
    
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
