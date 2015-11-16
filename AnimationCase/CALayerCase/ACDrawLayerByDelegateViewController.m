//
//  ACDrawLayerByDelegateViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/12.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACDrawLayerByDelegateViewController.h"

@interface ACDrawLayerByDelegateViewController () {
    CALayer *layer;
}

@end

static CGFloat width = 150.0;

@implementation ACDrawLayerByDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.cornerRadius = width/2;
    layer.masksToBounds = YES;
    
    layer.borderWidth = 2.0;
    layer.borderColor = [UIColor grayColor].CGColor;
    
    layer.delegate = self;
    
    [self.view.layer addSublayer:layer];
    
    [layer setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
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
    CGContextSaveGState(ctx);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -width);
    
    UIImage *image = [UIImage imageNamed:@"avatar.png"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, width, width), image.CGImage);
    
    CGContextRestoreGState(ctx);
}

@end
