//
//  UIView+UIView_Controller.m
//  2048
//
//  Created by Joe on 14-3-20.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)
- (UIViewController *)viewController {
    if ([self.nextResponder isKindOfClass:UIViewController.class])
    return (UIViewController *)self.nextResponder;
    else
    return nil;
}
@end
