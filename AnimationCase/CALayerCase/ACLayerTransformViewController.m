//
//  ACLayerTransformViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/16.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACLayerTransformViewController.h"

@interface ACLayerTransformViewController () {
    CALayer *layer;
}

@end

static CGFloat width = 150.0;

@implementation ACLayerTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGPoint center = self.view.center;
    
    //Plan A
    layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, width, width);
    center.y = center.y-width;
    layer.position = center;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.cornerRadius = width/2;
    layer.masksToBounds = YES;
    
    layer.borderWidth = 2.0;
    layer.borderColor = [UIColor grayColor].CGColor;
    [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
//    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    
    layer.delegate = self;
    
    [self.view.layer addSublayer:layer];
    
    [layer setNeedsDisplay];
    
    
    //Plan B
    CALayer *anotherlayer = [[CALayer alloc] init];
    anotherlayer.bounds = CGRectMake(0, 0, width, width);
    center = self.view.center;
    center.y += width;
    anotherlayer.position = center;
    anotherlayer.backgroundColor = [UIColor blueColor].CGColor;
    anotherlayer.cornerRadius = width/2;
    anotherlayer.masksToBounds = YES;
    anotherlayer.borderColor = [UIColor grayColor].CGColor;
    anotherlayer.borderWidth = 2.0;
    //设置内容（注意这里一定要转换为CGImage）
    UIImage *image=[UIImage imageNamed:@"avatar.png"];
    [anotherlayer setContents:(id)image.CGImage];
    
    //添加图层到根图层
    [self.view.layer addSublayer:anotherlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    layer.delegate = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - layer delegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    CGContextSaveGState(ctx);
//    
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -width);
    
    UIImage *image = [UIImage imageNamed:@"avatar.png"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, width, width), image.CGImage);
    
//    CGContextRestoreGState(ctx);
}

@end
