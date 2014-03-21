//
//  UIView+Animation.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView(Animation)
- (void)moveToView:(UIView *)view
{
    [self.superview insertSubview:self belowSubview:view];
    [self moveToCenter:view.center];
}
- (void)moveToCenter:(CGPoint)center
{
//    CGRect displayFrame = [[self.layer presentationLayer] frame];
//    self.frame = CGRectMake(displayFrame.origin.x - (self.frame.size.width - displayFrame.size.width)/2,
//                            displayFrame.origin.y + (self.frame.size.height - displayFrame.size.height)/2,
//                            self.frame.size.width,
//                            self.frame.size.height);
    
//    float s = sqrtf(powf(center.x - self.center.x, 2) + powf(center.y - self.center.y, 2));
//    float v = 400;

    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(moveDidEnd)];
    self.center = center;
    [UIView commitAnimations];
}

- (void)moveDidEnd
{
    
}

- (void)moveToRect:(CGRect)rect{}

- (void)pop
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^(){
                         self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"finish%d,",finished);
                         if (finished)
                         {
                         [UIView animateWithDuration:.1 animations:^{
                             self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                         }];
                         }
                     }];
}

- (void)show
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelay:0.4];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    [UIView commitAnimations];
}

- (void)changeBgColor:(UIColor *)color
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    self.backgroundColor = color;
    [UIView commitAnimations];
}

- (void)moveToCenter:(CGPoint)center withRebound:(CGPoint)offset delay:(float)delay
{
    [UIView animateWithDuration:.25 delay:delay options:UIViewAnimationOptionCurveEaseIn
                     animations:^(){
                         self.center = CGPointMake(center.x+offset.x, center.y+offset.y);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:.2 animations:^(){
                             [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                             self.center = center;
                         }];
                     }];
}

@end
