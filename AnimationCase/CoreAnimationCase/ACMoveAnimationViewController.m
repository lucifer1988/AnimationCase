//
//  ACMoveAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/16.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACMoveAnimationViewController.h"

@interface ACMoveAnimationViewController () {
    CALayer *petalLayer;
}

@end

@implementation ACMoveAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
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
    [petalLayer addAnimation:moveAnimation forKey:@"petalLayer_moveAnimation"];
}

- (NSTimeInterval)petalMoveDuring:(CGPoint)destination {
    CGFloat deltaX = destination.x - petalLayer.position.x;
    CGFloat deltaY = destination.y - petalLayer.position.y;
    CGFloat distance = sqrt(deltaX*deltaX + deltaY*deltaY);
    NSLog(@"%f", distance);
    return (NSTimeInterval)distance/50.0;
}

@end
