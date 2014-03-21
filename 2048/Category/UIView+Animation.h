//
//  UIView+Animation.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Animation)

- (void)moveToView:(UIView *)view;

- (void)moveToCenter:(CGPoint)center;

- (void)moveToRect:(CGRect)rect;

- (void)pop;

- (void)moveDidEnd;

- (void)show;

- (void)changeBgColor:(UIColor *)color;
@end
