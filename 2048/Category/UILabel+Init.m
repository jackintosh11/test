//
//  UILabel+Init.m
//  2048
//
//  Created by Joe on 14-3-31.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "UILabel+Init.h"

@implementation UILabel (Init)
- (id)initClearWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
//    self.textColor = [UIColor blackColor];
    return  self;
}

@end
