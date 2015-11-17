//
//  ACTransitionAnimationViewController.m
//  AnimationCase
//
//  Created by liuyi on 15/11/17.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACTransitionAnimationViewController.h"

@interface ACTransitionAnimationViewController () {
    UIImageView *imageView;
    NSArray *transitionTypes;
}

@end

static int transitionTypeIndex;

@implementation ACTransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    transitionTypes = @[@"fade", @"moveIn", @"push", @"reveal", @"cube", @"oglFlip", @"suckEffect", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"cameraIrisHollowOpen", @"cameraIrisHollowClose"];
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
    if (transitionTypeIndex > 11) {
        transitionTypeIndex = 0;
    }
    CATransition *transition = [[CATransition alloc] init];
    transition.type = transitionTypes[transitionTypeIndex];
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.0;
    [imageView.layer addAnimation:transition forKey:@"imageView_transition"];
    
    transitionTypeIndex++;
}

@end
