//
//  ACGroupAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/17.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACGroupAnimationViewController.h"

@interface ACGroupAnimationViewController () {
    CALayer *petalLayer;
}

@end

@implementation ACGroupAnimationViewController

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
    
    [self addAnimationGroup];
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

- (void)addAnimationGroup {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CABasicAnimation *rotateAnimation = [self rotateAnimation];
    CAKeyframeAnimation *keyframeMoveAnimation = [self keyframeMoveAnimation];
    animationGroup.animations = @[rotateAnimation, keyframeMoveAnimation];
    
    animationGroup.delegate = self;
    animationGroup.duration = 8.0;
    animationGroup.beginTime = CACurrentMediaTime()+2;
    
    [petalLayer addAnimation:animationGroup forKey:nil];
}

- (CAKeyframeAnimation *)keyframeMoveAnimation {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, petalLayer.position.x, petalLayer.position.y);
    CGPathAddCurveToPoint(path, NULL, 300, 250, -100, 450, 100, 550);
    
    keyframeAnimation.path = path;
    CGPathRelease(path);
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(100, 550)] forKey:@"petalLayer_keyframeAnimation_destination"];
    return keyframeAnimation;
}

- (CABasicAnimation *)rotateAnimation {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.autoreverses = YES;
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    [rotateAnimation setValue:[NSNumber numberWithFloat:M_PI_2*3] forKey:@"rotateAnimation_toValue"];
    
    return rotateAnimation;
}

#pragma mark - animation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAAnimationGroup *animationGroup = (CAAnimationGroup *)anim;
    CABasicAnimation *rotateAnimation = (CABasicAnimation *)animationGroup.animations[0];
    CAKeyframeAnimation *keyframeMoveAnimation = (CAKeyframeAnimation *)animationGroup.animations[1];
    CGFloat toValue = [[rotateAnimation valueForKey:@"rotateAnimation_toValue"] floatValue];
    CGPoint toPoint = [[keyframeMoveAnimation valueForKey:@"petalLayer_keyframeAnimation_destination"] CGPointValue];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    petalLayer.position = toPoint;
    petalLayer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1);
    [CATransaction commit];
}

@end
