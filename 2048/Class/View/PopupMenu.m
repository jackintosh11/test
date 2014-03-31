//
//  PopupMenu.m
//  2048
//
//  Created by Jason.Zhang on 3/22/14.
//  Copyright (c) 2014 Joe. All rights reserved.
//

#import "PopupMenu.h"
#import "UIView+Animation.h"
#import "AudioHelper.h"
@implementation PopupMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btnRestart = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRestart setTitle:@"Restart" forState:UIControlStateNormal];
        [_btnRestart addTarget:self action:@selector(btnRestartSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnRestart];
        _btnRestart.frame = CGRectMake(0, 0, Q(150), Q(38));
        _btnRestart.center = CGPointMake(frame.size.width/2 ,frame.size.height/2.0);
        _btnRestart.titleLabel.font = [UIFont fontWithName:Font size:Q(16)];
        [_btnRestart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnRestart setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_btnRestart setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:101.0/255.0 blue:107.0/255.0 alpha:1]];
        _btnRestart.layer.cornerRadius = Q(19);
        
        _btnResume = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnResume setTitle:@"Resume" forState:UIControlStateNormal];
        [_btnResume addTarget:self action:@selector(btnResumeSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnResume];
        _btnResume.frame = CGRectMake(0, 0, Q(150), Q(38));
        _btnResume.center = CGPointMake(frame.size.width/2 ,_btnRestart.center.y - Q(48));
        _btnResume.titleLabel.font = [UIFont fontWithName:Font size:Q(16)];
        [_btnResume setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnResume setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_btnResume setBackgroundColor:[UIColor colorWithRed:.2578 green:.6953 blue:.6758 alpha:1]];
        _btnResume.layer.cornerRadius = Q(19);
        
        _btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnExit setTitle:@"Exit" forState:UIControlStateNormal];
        [_btnExit addTarget:self action:@selector(btnExitSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnExit];
        _btnExit.frame = CGRectMake(0, 0, Q(150), Q(38));
        _btnExit.center = CGPointMake(frame.size.width/2 ,_btnRestart.center.y + Q(48));
        _btnExit.titleLabel.font = [UIFont fontWithName:Font size:Q(16)];
        [_btnExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnExit setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_btnExit setBackgroundColor:[UIColor colorWithRed:148.0/255.0 green:93.0/255.0 blue:165.0/255.0 alpha:1]];
        _btnExit.layer.cornerRadius = Q(19);
    }
    return self;
}

- (void)btnResumeSelected
{
    [AudioHelper click];
    [self exit:_resumeCallback];
}

- (void)btnRestartSelected
{
    [AudioHelper click];
    [UIView animateWithDuration:.3 animations:^{
        _btnRestart.center = CGPointMake(-_btnRestart.frame.size.width ,_btnRestart.center.y);
        _btnResume.center = CGPointMake(-_btnRestart.frame.size.width ,_btnResume.center.y);
        _btnExit.center = CGPointMake(-_btnRestart.frame.size.width ,_btnExit.center.y);
    } completion:_restartCallback];
}

- (void)btnExitSelected
{
    [AudioHelper click];
    if (_exitCallback) {
        _exitCallback(true);
    }
}

- (void)enter
{
    _btnRestart.center = CGPointMake(self.frame.size.width+_btnRestart.frame.size.width ,_btnRestart.center.y);
    _btnResume.center = CGPointMake(self.frame.size.width+_btnRestart.frame.size.width ,_btnResume.center.y);
    _btnExit.center = CGPointMake(self.frame.size.width+_btnRestart.frame.size.width ,_btnExit.center.y);

    [_btnRestart moveToCenter:CGPointMake(self.frame.size.width/2 ,self.frame.size.height/2.0) withRebound:CGPointMake(-8, 0) delay:.05];
    [_btnResume moveToCenter:CGPointMake(self.frame.size.width/2 ,_btnRestart.center.y - Q(48)) withRebound:CGPointMake(-8, 0) delay:0];
    [_btnExit moveToCenter:CGPointMake(self.frame.size.width/2 ,_btnRestart.center.y + Q(48)) withRebound:CGPointMake(-8, 0) delay:.1];
}

- (void)exit:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:.3 animations:^{
        _btnRestart.center = CGPointMake(self.frame.size.width+_btnRestart.frame.size.width ,_btnRestart.center.y);
        _btnResume.center = CGPointMake(self.frame.size.width+_btnRestart.frame.size.width ,_btnResume.center.y);
        _btnExit.center = CGPointMake(self.frame.size.width+_btnRestart.frame.size.width ,_btnExit.center.y);
    } completion:completion];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
