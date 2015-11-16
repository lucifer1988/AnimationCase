//
//  ACAnimatablePropertiesViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/12.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACAnimatablePropertiesViewController.h"

@interface ACAnimatablePropertiesViewController () {
    CALayer *layer;
}

@end

static CGFloat width = 150.0;

@implementation ACAnimatablePropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.cornerRadius = width/2;
    
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 3);
    layer.shadowOpacity = 0.9;
    
    layer.borderWidth = 2.0;
    layer.borderColor = [UIColor greenColor].CGColor;
    
    [self.view.layer addSublayer:layer];
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
    UITouch *touch = [touches anyObject];
    CGFloat randWidth = arc4random()%200+100;
    layer.bounds = CGRectMake(0, 0, randWidth, randWidth);
    layer.cornerRadius = randWidth/2;
    layer.position = [touch locationInView:self.view];
    layer.backgroundColor = [UIColor colorWithRed:arc4random()%225/225.0 green:arc4random()%225/225.0 blue:arc4random()%225/225.0 alpha:1.0].CGColor;
    layer.borderColor = [UIColor colorWithRed:arc4random()%225/225.0 green:arc4random()%225/225.0 blue:arc4random()%225/225.0 alpha:1.0].CGColor;
}

@end
