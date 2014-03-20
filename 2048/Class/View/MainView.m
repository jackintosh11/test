//
//  MainView.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnStart setTitle:@"Start" forState:UIControlStateNormal];
        [btnStart addTarget:self action:@selector(btnStartSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnStart];
        btnStart.frame = CGRectMake(0, 0, 60, 60);
        btnStart.center = CGPointMake(frame.size.width/2 ,frame.size.height * 3/4);
        
        
        UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnAdd setTitle:@"+" forState:UIControlStateNormal];
        [btnAdd addTarget:self action:@selector(btnAddSelected) forControlEvents:UIControlEventTouchUpInside];
        btnAdd.frame = CGRectMake(0, 0, 60, 60);
        btnAdd.center = CGPointMake(btnStart.center.x + Q(50), btnStart.center.y - Q(200));
        [self addSubview:btnAdd];
        
        UIButton *btnCut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCut addTarget:self action:@selector(btnCutSelected) forControlEvents:UIControlEventTouchUpInside];
        btnCut.frame = CGRectMake(0, 0, 60, 60);
        btnCut.center = CGPointMake(btnStart.center.x - Q(50), btnStart.center.y - Q(200));
        [btnCut setTitle:@"-" forState:UIControlStateNormal];
        [self addSubview:btnCut];
        
      
        _lblLevel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _lblLevel.center = CGPointMake(btnStart.center.x, btnStart.center.y - Q(200));
        _lblLevel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblLevel];
        self.level = 4;
        // Initialization code
    }
    return self;
}

- (void)btnCutSelected
{
    self.level--;
    self.level = MAX(2, self.level);
}

- (void)btnAddSelected
{
    self.level++;
    self.level = MIN(20, self.level);
}

- (void)btnStartSelected
{
    if (self.startGame)
    {
        self.startGame(_level);
    }
}

- (void)setLevel:(int)level
{
    _level = level;
    _lblLevel.text = [NSString stringWithFormat:@"%d",_level];
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
