//
//  ACAnchorPointViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/12.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACAnchorPointViewController.h"

@interface ACAnchorPointViewController () <UITextFieldDelegate> {
    CALayer *layer;
}

@property (weak, nonatomic) IBOutlet UITextField *xField;
@property (weak, nonatomic) IBOutlet UITextField *yField;

@end

@implementation ACAnchorPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    layer.position = self.view.center;
    layer.bounds = CGRectMake(0, 0, 150.0, 150.0);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:3.1415926*2];
    [layer addAnimation:rotationAnimation forKey:@"rotationTransform"];
    
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    double value = textField.text.length ? textField.text.doubleValue : 0.5;
    if (value < 0 || value > 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入值必须介于0到1" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    if (textField == self.xField) {
        CGPoint point = layer.anchorPoint;
        point.x = value;
        layer.anchorPoint = point;
    } else {
        CGPoint point = layer.anchorPoint;
        point.y = value;
        layer.anchorPoint = point;
    }
    [textField resignFirstResponder];
    return YES;
}

@end
