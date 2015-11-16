//
//  ACDrawLayerCustomViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/12.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACDrawLayerCustomViewController.h"
#import "ACCustomLayer.h"

@interface ACDrawLayerCustomViewController ()

@end

@implementation ACDrawLayerCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ACCustomLayer *layer = [[ACCustomLayer alloc] init];
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
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

@end
