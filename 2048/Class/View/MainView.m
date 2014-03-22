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
        
        _logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Q(296), Q(110))];
//        _logoView.backgroundColor = [UIColor whiteColor];
        _logoView.center = CGPointMake(frame.size.width/2.0, Q(128));
        [self addSubview:_logoView];
        [self initLogo];
        
        _btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnStart setTitle:@"Play Now" forState:UIControlStateNormal];
        [_btnStart addTarget:self action:@selector(btnStartSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnStart];
        _btnStart.frame = CGRectMake(0, 0, Q(150), Q(38));
        _btnStart.center = CGPointMake(frame.size.width/2 ,frame.size.height * 3.0/4);
        _btnStart.titleLabel.font = [UIFont fontWithName:Font size:Q(16)];
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
        _btnSetting.titleLabel.font = [UIFont fontWithName:Font size:Q(14)];
        [_btnSetting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnSetting setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        _btnAbout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnAbout setTitle:@"About me" forState:UIControlStateNormal];
//        [_btnAbout addTarget:self action:@selector(btnSettingSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnAbout];
        _btnAbout.frame = CGRectMake(0, 0, Q(75), Q(38));
        _btnAbout.titleLabel.font = [UIFont fontWithName:Font size:Q(14)];
        [_btnAbout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnAbout setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        _btnHelp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnHelp setTitle:@"How to" forState:UIControlStateNormal];
//        [_btnHelp addTarget:self action:@selector(btnSettingSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnHelp];
        _btnHelp.frame = CGRectMake(0, 0, Q(75), Q(38));
       
        _btnHelp.titleLabel.font = [UIFont fontWithName:Font size:Q(14)];
        [_btnHelp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnHelp setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        _isMenuShow = NO;
        
        _lblBestScore = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Q(200), Q(32))];
        [_lblBestScore setFont:[UIFont fontWithName:Font size:Q(14)]];
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

- (void)initLogo
{
    float centerx = _logoView.frame.size.width/2.0;
    float centery = _logoView.frame.size.height/2.0;
    float size = Q(64.0);
    
    GameBlock *block2 = [[GameBlock alloc] initWithFrame:CGRectMake(0,0,size,size)];
    block2.center = CGPointMake(centerx - Q(108), centery);
    [block2 setNumberDirectly:2];
    [block2 refresh];
    [_logoView addSubview:block2];
    
    GameBlock *block0 = [[GameBlock alloc] initWithFrame:CGRectMake(0,0,size,size)];
    block0.center = CGPointMake(centerx - Q(36), centery);
    [block0 setNumberDirectly:0];
    [block0 refresh];
    [_logoView addSubview:block0];
    
    GameBlock *block4 = [[GameBlock alloc] initWithFrame:CGRectMake(0,0,size,size)];
    block4.center = CGPointMake(centerx + Q(36), centery);
    [block4 setNumberDirectly:4];
    [block4 refresh];
    [_logoView addSubview:block4];
    
    GameBlock *block8 = [[GameBlock alloc] initWithFrame:CGRectMake(0,0,size,size)];
    block8.center = CGPointMake(centerx + Q(108), centery);
    [block8 setNumberDirectly:8];
    [block8 refresh];
    [_logoView addSubview:block8];
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
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(exitDidFinished)];
    [_logoView setCenter:CGPointMake(_logoView.center.x, -_logoView.frame.size.height)];
    [_btnStart setCenter:CGPointMake(_btnStart.center.x, self.frame.size.height+_btnStart.frame.size.height)];
    [_lblBestScore setCenter:_btnStart.center];
    [_btnSetting setCenter:CGPointMake(_btnSetting.center.x, self.frame.size.height+_btnSetting.frame.size.height)];
    [_btnAbout setCenter:_btnSetting.center];
    [_btnHelp setCenter:_btnHelp.center];
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

- (void)enter
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int bestScore = [userDefaults integerForKey:@"bestscore"];
    [_lblBestScore setText:[NSString stringWithFormat:@"Your best: %d",bestScore]];
    [_logoView setCenter:CGPointMake(_logoView.center.x, -_logoView.frame.size.height)];
    [_btnStart setCenter:CGPointMake(_btnStart.center.x, self.frame.size.height+_btnStart.frame.size.height)];
    [_lblBestScore setCenter:_btnStart.center];
    [_btnSetting setCenter:CGPointMake(_btnSetting.center.x, self.frame.size.height+_btnSetting.frame.size.height)];
    [_btnAbout setCenter:_btnSetting.center];
    [_btnHelp setCenter:_btnHelp.center];
    
    [_logoView moveToCenter:CGPointMake(self.frame.size.width/2.0, Q(128)) withRebound:CGPointMake(0, 8) delay:.05];
    [_btnStart moveToCenter:CGPointMake(self.frame.size.width/2 ,self.frame.size.height * 3.0/4) withRebound:CGPointMake(0, -8) delay:.1];
    [_lblBestScore moveToCenter:CGPointMake(self.frame.size.width/2.0, _btnStart.center.y - Q(48)) withRebound:CGPointMake(0, -8) delay:.05];
    [_btnSetting moveToCenter:CGPointMake(self.frame.size.width/2 ,self.frame.size.height-_btnSetting.frame.size.height/2.0 - Q(2)) withRebound:CGPointMake(0, -8) delay:.15 completion:^(BOOL finished) {
        
    }];
}

@end
