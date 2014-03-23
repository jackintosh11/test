//
//  CellView.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "GameBlock.h"
#import "UIView+Animation.h"
//#import "UILabel+Change.h"
@implementation GameBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = Q(5);
        self.backgroundColor = [UIColor whiteColor];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                          0,
                                                          frame.size.width,
                                                          frame.size.height)];
        _label.font = [UIFont fontWithName:@"GillSans-Bold" size:Q(30)];
        _label.textAlignment = NSTextAlignmentCenter;
        [_label setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_label];
        self.hitable = YES;
        
        _number = -1;

    }
    return self;
}

- (void)setNumber:(int)number
{
    if (number != _number) {
        _number = number;
        [self checkBackgroundColor:YES];
    }
}
- (void)refresh
{
    if (_label.text.length && [_label.text intValue] != _number)
    {
        [self pop];
    }
    [_label setText:[NSString stringWithFormat:@"%d",_number]];
//    [_label changeText:[NSString stringWithFormat:@"%d",_number]];

}
- (void)setBox:(GameBox *)box
{
    _box.currentBlock = nil;
    _box = box;
}

- (void)disappear
{
    _number = 0;
    _disappear = YES;
    _box.currentBlock = nil;
    _box = nil;
}


- (void)moveDidEnd
{
    if (_disappear)
    {
        [self removeFromSuperview];
    }
    _isMoving = NO;
    if (_moveEnd)
    {
        _moveEnd(self);
    }
}
- (void)moveToCenter:(CGPoint)center
{
    _isMoving = YES;
    [super moveToCenter:center];
}

- (void)moveToView:(UIView *)view
{
    if (_isMoving)
    {
    }
    [super moveToView:view];
    _isMoving = YES;
}

- (void)setNumberDirectly:(int)number
{
    if (_number != number) {
        _number = number;
        [self checkBackgroundColor:NO];
    }
}

- (void)checkBackgroundColor:(BOOL)animated
{
    int number = _number;
    int level = 0;
    while (number > 0) {
        number/=2;
        level++;
    }
    UIColor *color;
    if (level == 0) {
        color = [UIColor colorWithRed:236/255. green:186/255. blue:129/255. alpha:1];
    }
    else if (level == 2)
    {
        color = [UIColor colorWithRed:235/255. green:227/255. blue:217/255. alpha:1];
    }
    else if (level == 3)
    {
        color = [UIColor colorWithRed:233/255. green:223/255. blue:199/255. alpha:1];
    }
    else if (level == 4)
    {
        color = [UIColor colorWithRed:226/255. green:176/255. blue:119/255. alpha:1];
    }
    else if (level == 5)
    {
        color = [UIColor colorWithRed:224/255. green:148/255. blue:97/255. alpha:1];
        
    }
    else if (level == 6)
    {
        color = [UIColor colorWithRed:221/255. green:123/255. blue:92/255. alpha:1];
        
    }
    else if (level == 7)
    {
        color = [UIColor colorWithRed:218/255. green:93/255. blue:55/255. alpha:1];
        
    }
    else if (level == 8)
    {
        color = [UIColor colorWithRed:229/255. green:207/255. blue:113/255. alpha:1];
    }
    else if (level == 9)
    {
        color = [UIColor colorWithRed:229/255. green:204/255. blue:97/255. alpha:1];
    }
    else if (level == 10)
    {
        color = [UIColor colorWithRed:228/255. green:200/255. blue:80/255. alpha:1];
    }
    else
    {
        color = [UIColor colorWithRed:228/255. green:197/255. blue:80/255. alpha:1];
    }
    
    if (level == 0) {
        [_label setTextColor:[UIColor whiteColor]];
    }
    else if (level > 3) {
        [_label setTextColor:[UIColor whiteColor]];
    }
    else {
        [_label setTextColor:[UIColor colorWithRed:116/255. green:110/255. blue:101/255. alpha:1]];
    }
    
    if (animated) {
        [self changeBgColor:color];
    }
    else {
        self.backgroundColor = color;
    }
}

@end
