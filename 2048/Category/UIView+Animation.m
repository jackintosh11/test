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
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:.15];
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
    [UIView animateWithDuration:0.1
                     animations:^(){
                         self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:.1 animations:^{
                             self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                         }];
                     }];
}

- (void)show
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
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
    [self moveToCenter:center withRebound:offset delay:delay completion:NULL];
}

- (void)moveToCenter:(CGPoint)center withRebound:(CGPoint)offset delay:(float)delay completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:.25 delay:delay options:UIViewAnimationOptionCurveEaseIn
                     animations:^(){
                         self.center = CGPointMake(center.x+offset.x, center.y+offset.y);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:.2 animations:^(){
                             [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                             self.center = center;
                         }
                          completion:completion];
                     }];
}

- (void)bounce:(float)scale delay:(float)delay completion:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:.14 animations:^{
        [UIView setAnimationDelay:delay];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08 animations:^{
            self.transform = CGAffineTransformIdentity;
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        } completion:completion];
    }];
}

@end
