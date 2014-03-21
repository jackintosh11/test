//
//  MainView.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "MainView.h"
#import "UMSocial.h"
#import "UIView+Animation.h"
#import "UIView+Controller.h"
#import "GameBox.h"
#import "GameBlock.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BackgroundColor;
        
        _btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnStart setTitle:@"Play Now" forState:UIControlStateNormal];
        [_btnStart addTarget:self action:@selector(btnStartSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnStart];
        _btnStart.frame = CGRectMake(0, 0, Q(150), Q(38));
        _btnStart.center = CGPointMake(frame.size.width/2 ,frame.size.height * 3.0/4);
        _btnStart.titleLabel.font = [UIFont fontWithName:Font size:16.0];
        [_btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_btnStart setBackgroundColor:[UIColor colorWithRed:.2578 green:.6953 blue:.6758 alpha:1]];
        _btnStart.layer.cornerRadius = Q(19);
        
        _btnSetting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnSetting setTitle:@"Menu" forState:UIControlStateNormal];
        [_btnSetting addTarget:self action:@selector(btnSettingSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnSetting];
        _btnSetting.frame = CGRectMake(0, 0, Q(75), Q(38));
        _btnSetting.center = CGPointMake(frame.size.width/2 ,frame.size.height-_btnSetting.frame.size.height/2.0 - Q(2));
        _btnSetting.titleLabel.font = [UIFont fontWithName:Font size:14.0];
        [_btnSetting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnSetting setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        _btnAbout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnAbout setTitle:@"About me" forState:UIControlStateNormal];
//        [_btnAbout addTarget:self action:@selector(btnSettingSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnAbout];
        _btnAbout.frame = CGRectMake(0, 0, Q(75), Q(38));
        _btnAbout.titleLabel.font = [UIFont fontWithName:Font size:14.0];
        [_btnAbout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnAbout setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        _btnHelp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnHelp setTitle:@"How to" forState:UIControlStateNormal];
//        [_btnHelp addTarget:self action:@selector(btnSettingSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnHelp];
        _btnHelp.frame = CGRectMake(0, 0, Q(75), Q(38));
       
        _btnHelp.titleLabel.font = [UIFont fontWithName:Font size:14.0];
        [_btnHelp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnHelp setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        _isMenuShow = NO;
        
        _lblBestScore = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Q(200), Q(32))];
        [_lblBestScore setFont:[UIFont fontWithName:Font size:14]];
        [_lblBestScore setText:@"Your best: 1024"];
        [_lblBestScore setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_lblBestScore];
        
        [self calculateLayersCenter];
        
//        _lblMaxCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Q(200), Q(32))];
//        [_lblMaxCount setCenter:CGPointMake(frame.size.width/2.0, _lblBestScore.center.y - Q(32))];
//        [_lblMaxCount setFont:[UIFont fontWithName:Font size:14]];
//        [_lblMaxCount setText:@"Max count: 1024"];
//        [_lblMaxCount setTextAlignment:NSTextAlignmentCenter];
//        [self addSubview:_lblMaxCount];
        
//        UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [btnAdd setTitle:@"+" forState:UIControlStateNormal];
//        [btnAdd addTarget:self action:@selector(btnAddSelected) forControlEvents:UIControlEventTouchUpInside];
//        btnAdd.frame = CGRectMake(0, 0, 60, 60);
//        btnAdd.center = CGPointMake(btnStart.center.x + Q(50), btnStart.center.y - Q(200));
//        [self addSubview:btnAdd];
//        
//        UIButton *btnCut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [btnCut addTarget:self action:@selector(btnCutSelected) forControlEvents:UIControlEventTouchUpInside];
//        btnCut.frame = CGRectMake(0, 0, 60, 60);
//        btnCut.center = CGPointMake(btnStart.center.x - Q(50), btnStart.center.y - Q(200));
//        [btnCut setTitle:@"-" forState:UIControlStateNormal];
//        [self addSubview:btnCut];
        
      
//        _lblLevel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
//        _lblLevel.center = CGPointMake(_btnStart.center.x, _btnStart.center.y - Q(200));
//        _lblLevel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_lblLevel];
        self.level = 4;
        
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
    [UIView beginAnimations:@"MainViewExit" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(exitDidFinished)];
    [UIView commitAnimations];
}

- (void)exitDidFinished
{
    if (self.startGame)
    {
        self.startGame(_level);
    }
}

- (void)btnSettingSelected
{
    float centerx = self.frame.size.width/2;
    if (_isMenuShow) {
        _isMenuShow = NO;
        [_btnSetting setTitle:@"Menu" forState:UIControlStateNormal];
        
        float starty = self.frame.size.height * 3.0/4;
        float settingy = self.frame.size.height-_btnSetting.frame.size.height/2.0 - Q(2);
        
        [_lblBestScore moveToCenter:CGPointMake(centerx, starty - Q(48)) withRebound:ReboundOffsetYP delay:0];
        [_btnStart moveToCenter:CGPointMake(centerx ,starty) withRebound:ReboundOffsetYP delay:0.05];
        [_btnSetting moveToCenter:CGPointMake(centerx ,settingy) withRebound:ReboundOffsetYP delay:0.1];
        
        [_btnAbout moveToCenter:CGPointMake(centerx ,settingy + Q(32)) withRebound:ReboundOffsetYP delay:0.15];
        [_btnHelp moveToCenter:CGPointMake(centerx ,settingy + Q(64)) withRebound:ReboundOffsetYP delay:0.2];
        
    }
    else {
        _isMenuShow = YES;
        [_btnSetting setTitle:@"Hidden" forState:UIControlStateNormal];
        
        float starty = self.frame.size.height * 3.0/4.5;
        float settingy = self.frame.size.height-_btnSetting.frame.size.height/2.0 - Q(72);
        
        [_lblBestScore moveToCenter:CGPointMake(self.frame.size.width/2.0, starty- Q(48)) withRebound:ReboundOffsetYN delay:0.2];
        [_btnStart moveToCenter:CGPointMake(centerx ,starty) withRebound:ReboundOffsetYN delay:0.15];
        [_btnSetting moveToCenter:CGPointMake(centerx ,settingy) withRebound:ReboundOffsetYN delay:0.1];
    
        [_btnAbout moveToCenter:CGPointMake(self.frame.size.width/2 ,settingy + Q(32)) withRebound:ReboundOffsetYN delay:0.05];
        [_btnHelp moveToCenter:CGPointMake(self.frame.size.width/2 ,settingy + Q(64)) withRebound:ReboundOffsetYN delay:0];
    }
}

- (void)setLevel:(int)level
{
    _level = level;
    _lblLevel.text = [NSString stringWithFormat:@"%d",_level];
}

- (void)calculateLayersCenter
{
    
    _btnAbout.center = CGPointMake(self.frame.size.width/2 ,_btnSetting.frame.origin.y + Q(48));
    _btnHelp.center = CGPointMake(self.frame.size.width/2 ,_btnAbout.frame.origin.y + Q(48));
    [_lblBestScore setCenter:CGPointMake(self.frame.size.width/2.0, _btnStart.center.y - Q(48))];
    
}

@end
