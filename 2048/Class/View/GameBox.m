//
//  BackgroundCellView.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "GameBox.h"
#import "QuartzCore/QuartzCore.h"
#import "GameBlock.h"
#import "UIView+Animation.h"
@implementation GameBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = Q(5);
        self.backgroundColor = [UIColor colorWithRed:192/255. green:179/255. blue:164/255. alpha:1];
        self.IsEmpty = true;
        // Initialization code
    }
    return self;
}

- (void)creatBlock:(GameBlock *)block
{
    block.center = self.center;
    self.currentBlock = block;
}

- (void)setCurrentBlock:(GameBlock *)currentBlock
{
    if (_currentBlock != currentBlock)
    {
        _currentBlock = currentBlock;
        _currentBlock.x = self.x;
        _currentBlock.y = self.y;
        if (!CGPointEqualToPoint(_currentBlock.center, self.center))
        {
            [_currentBlock moveToCenter:self.center];
        }
        _currentBlock.box = self;
    }
    if(_currentBlock)
    {
        self.IsEmpty = NO;
//        self.backgroundColor = [UIColor blackColor];
    }
    else
    {
        self.IsEmpty = YES;
//        self.backgroundColor = [UIColor grayColor];
    }
}

- (BOOL)hit:(GameBlock *)block
{
    if(_currentBlock != nil && _currentBlock != block)
    {
        if (_currentBlock.number == block.number &&
            _currentBlock.hitable)
        {
            return YES;
        }
        else
        {
            
            return NO;
        }
    }
    return YES;
}

- (BOOL)isBlockNearby:(GameBlock *)block
{
//    if(abs(_currentBlock.x - block.x) + abs(_currentBlock.y - block.y) <= 1)
//    {
//        return  YES;
//    }
    return NO;
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
