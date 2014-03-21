//
//  MainView.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "MainView.h"
#import "UMSocial.h"
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
        _btnStart.center = CGPointMake(frame.size.width/2 ,frame.size.height * 3.0/4.5);
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
        
        _btnSetting.center = CGPointMake(frame.size.width/2 ,frame.size.height-_btnSetting.frame.size.height/2.0 - Q(2));
        _btnAbout.center = CGPointMake(self.frame.size.width/2 ,_btnSetting.frame.origin.y + Q(48));
        _btnHelp.center = CGPointMake(self.frame.size.width/2 ,_btnAbout.frame.origin.y + Q(48));
        _isMenuShow = NO;
        
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
    if (self.startGame)
    {
        self.startGame(_level);
    }
}

- (void)btnSettingSelected
{
    if (_isMenuShow) {
        _isMenuShow = NO;
        [_btnSetting setTitle:@"Menu" forState:UIControlStateNormal];
        
        [UIView beginAnimations:@"SettingHidden" context:nil];
        [_btnStart setCenter:CGPointMake(self.frame.size.width/2 ,self.frame.size.height * 3.0/4.5)];
        _btnSetting.center = CGPointMake(self.frame.size.width/2 ,self.frame.size.height-_btnSetting.frame.size.height/2.0 - Q(2));
        _btnAbout.center = CGPointMake(self.frame.size.width/2 ,_btnSetting.frame.origin.y + Q(48));
        _btnHelp.center = CGPointMake(self.frame.size.width/2 ,_btnAbout.frame.origin.y + Q(48));
        [UIView commitAnimations];
    }
    else {
        _isMenuShow = YES;
        [_btnSetting setTitle:@"Hidden" forState:UIControlStateNormal];
        
        [UIView beginAnimations:@"SettingShow" context:nil];
        [_btnStart setCenter:CGPointMake(self.frame.size.width/2 ,self.frame.size.height * 3.0/5)];
        _btnSetting.center = CGPointMake(self.frame.size.width/2 ,self.frame.size.height-_btnSetting.frame.size.height/2.0 - Q(72));
        _btnAbout.center = CGPointMake(self.frame.size.width/2 ,_btnSetting.frame.origin.y + Q(48));
        _btnHelp.center = CGPointMake(self.frame.size.width/2 ,_btnAbout.frame.origin.y + Q(48));
        [UIView commitAnimations];
    }
}

- (void)setLevel:(int)level
{
    _level = level;
    _lblLevel.text = [NSString stringWithFormat:@"%d",_level];
}


@end
