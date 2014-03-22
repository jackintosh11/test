//
//  CountView.m
//  2048
//
//  Created by Jason.Zhang on 3/22/14.
//  Copyright (c) 2014 Joe. All rights reserved.
//

#import "CountView.h"

@implementation CountView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BackgroundColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
