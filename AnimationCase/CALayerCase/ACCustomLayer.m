//
//  ACCustomLayer.m
//  AnimationCase
//
//  Created by liuyi on 15/11/12.
//  Copyright © 2015年 Lucifer. All rights reserved.
//

#import "ACCustomLayer.h"

@implementation ACCustomLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGPoint center = CGPointMake(width/2, width/2);
    CGContextMoveToPoint(ctx, center.x, center.y - 60.0);
    for(int i = 1; i < 5; ++i) {
        CGFloat x = 60.0 * sinf(i * 4.0 * M_PI / 5.0);
        CGFloat y = 60.0 * cosf(i * 4.0 * M_PI / 5.0);
        CGContextAddLineToPoint(ctx, center.x - x, center.y - y);
        NSLog(@"x:%f, y:%f", center.x - x, center.y - y);
    }
    
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
