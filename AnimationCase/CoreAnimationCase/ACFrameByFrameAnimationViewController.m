//
//  ACFrameByFrameAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/17.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACFrameByFrameAnimationViewController.h"

@interface ACFrameByFrameAnimationViewController () {
    UIImageView *imageView;
    CALayer *layer;
    NSMutableArray *imageArray;
}

@end

static int frameIndex = 0;

@implementation ACFrameByFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background1.png"];
    self.view.layer.contents = (id)backgroundImage.CGImage;
    
    imageArray = [@[] mutableCopy];
    for (int i=0; i<10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fish%d.png", i]];
        [imageArray addObject:image];
    }
    
    //PlanA use UIImageView's AnimationImages
//    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 87, 32)];
//    imageView.center = self.view.center;
//    imageView.animationDuration = imageArray.count/30;
//    [imageView setAnimationImages:imageArray];
//    [self.view addSubview:imageView];
//    [imageView startAnimating];
    
    //PlanB use CADisplayLink
    layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 87, 32);
    layer.position = self.view.center;
    [self.view.layer addSublayer:layer];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(nextFrame)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
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

//60fps
- (void)nextFrame {
    static int i = 0;
    //30fps
    if (++i%2 == 0) {
        UIImage *image = imageArray[frameIndex];
        layer.contents = (id)image.CGImage;
        frameIndex = (frameIndex+1)%10;
    }
}

@end
