//
//  ACViewKeyframeAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/18.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACViewKeyframeAnimationViewController.h"

@interface ACViewKeyframeAnimationViewController () {
    UIImageView *petalView;
}

@end

@implementation ACViewKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"background.jpg"].CGImage;
    
    petalView = [[UIImageView alloc] init];
    petalView.frame = CGRectMake(50, 150, 0, 0);
    petalView.image = [UIImage imageNamed:@"petal"];
    [petalView sizeToFit];
    [self.view addSubview:petalView];
    
    [self addKeyframeAnimation];
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

- (void)addKeyframeAnimation {
    [UIView animateKeyframesWithDuration:5.0 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            petalView.center = CGPointMake(80.0, 220.0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            petalView.center = CGPointMake(45.0, 300.0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            petalView.center = CGPointMake(55.0, 400.0);
        }];
    } completion:nil];
}

@end
