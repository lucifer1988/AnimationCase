//
//  ACViewTransitionAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/18.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACViewTransitionAnimationViewController.h"

@interface ACViewTransitionAnimationViewController () {
    UIImageView *imageView;
    NSArray *transitionTypes;
}

@end

static int transitionTypeIndex;

@implementation ACViewTransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    transitionTypes = @[[NSNumber numberWithUnsignedInteger:UIViewAnimationOptionTransitionFlipFromRight], [NSNumber numberWithUnsignedInteger:UIViewAnimationOptionTransitionCurlUp], [NSNumber numberWithUnsignedInteger:UIViewAnimationOptionTransitionCrossDissolve], [NSNumber numberWithUnsignedInteger:UIViewAnimationOptionTransitionFlipFromBottom]];
    transitionTypeIndex = 0;
    
    imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [imageView setImage:[UIImage imageNamed:@"background.jpg"]];
    [self.view addSubview:imageView];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
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

- (void)swipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    if (transitionTypeIndex > 3) {
        transitionTypeIndex = 0;
    }
    
    UIViewAnimationOptions option;
    option = [transitionTypes[transitionTypeIndex] unsignedIntegerValue];
    option = option|UIViewAnimationOptionCurveLinear;
    [UIView transitionWithView:imageView duration:1.0 options:option animations:^{
        [imageView setImage:[UIImage imageNamed:@"background.jpg"]];
    } completion:nil];
    
    transitionTypeIndex++;
}

@end
