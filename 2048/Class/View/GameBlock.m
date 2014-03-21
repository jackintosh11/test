//
//  CellView.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "GameBlock.h"
#import "UIView+Animation.h"
#import "UILabel+Change.h"
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
        _label.font = [UIFont fontWithName:@"Helvetica" size:Q(30)];
        _label.textAlignment = NSTextAlignmentCenter;
        [_label setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_label];
        self.hitable = YES;
        // Initialization code
    }
    return self;
}

- (void)setNumber:(int)number
{
    _number = number;
        int level = 0;
    while (number > 0) {
        number/=2;
        level++;
    }
    if (level == 2)
    {
        [self changeBgColor:[UIColor colorWithRed:233/255. green:222/255. blue:209/255. alpha:1]];
    }
    else if (level == 3)
    {
        [self changeBgColor:[UIColor colorWithRed:232/255. green:117/255. blue:118/255. alpha:1]];
    }
    else if (level == 4)
    {
        [self changeBgColor:[UIColor colorWithRed:237/255. green:162/255. blue:102/255. alpha:1]];
    }
    else if (level == 5)
    {
        [self changeBgColor:[UIColor colorWithRed:241/255. green:101/255. blue:77/255. alpha:1]];

    }
    else if (level == 6)
    {
        [self changeBgColor:[UIColor colorWithRed:241/255. green:76/255. blue:46/255. alpha:1]];

    }
    else if (level == 7)
    {
        [self changeBgColor:[UIColor colorWithRed:232/255. green:198/255. blue:95/255. alpha:1]];

    }
    else if (level == 8)
    {
        [self changeBgColor:[UIColor colorWithRed:232/255. green:195/255. blue:75/255. alpha:1]];
    }
}
- (void)refresh
{
    if (_label.text.length && [_label.text intValue] != _number)
    {
        NSLog(@"%@:%d",self,_number);
        [self pop];
    }
    [_label changeText:[NSString stringWithFormat:@"%d",_number]];

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
        NSLog(@"!!!!!");
    }
//    NSLog(@"moving %d,%d",self.x,self.y);
    [super moveToView:view];
    _isMoving = YES;
}

@end
