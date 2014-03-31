//
//  CountView.m
//  2048
//
//  Created by Jason.Zhang on 3/22/14.
//  Copyright (c) 2014 Joe. All rights reserved.
//

#import "CountView.h"
#import "UIView+Controller.h"
#import "UMSocial.h"
#import "UIView+Animation.h"
#import "AudioHelper.h"
@implementation CountView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BackgroundColor;
        
        _content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Q(235), Q(277))];
        _content.backgroundColor = [UIColor whiteColor];
        _content.center = CGPointMake(frame.size.width/2.0, frame.size.height*2.0/5.0);
        [self addSubview:_content];

        _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDone setTitle:@"Done" forState:UIControlStateNormal];
        [_btnDone addTarget:self action:@selector(btnDoneSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDone];
        _btnDone.frame = CGRectMake(0, 0, Q(75), Q(38));
        _btnDone.center = CGPointMake(frame.size.width/2 ,frame.size.height-_btnDone.frame.size.height/2.0 - Q(25));
        _btnDone.titleLabel.font = [UIFont fontWithName:Font size:Q(14)];
        [_btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnShare setTitle:@"Share" forState:UIControlStateNormal];
        [_btnShare addTarget:self action:@selector(btnShareSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnShare];
        _btnShare.frame = CGRectMake(0, 0, Q(150), Q(38));
        _btnShare.center = CGPointMake(frame.size.width/2 ,_btnDone.center.y - Q(48));
        _btnShare.titleLabel.font = [UIFont fontWithName:Font size:Q(16)];
        [_btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_btnShare setBackgroundColor:[UIColor colorWithRed:.2578 green:.6953 blue:.6758 alpha:1]];
        _btnShare.layer.cornerRadius = Q(19);
        
        _lblTitle = [[UILabel alloc] initClearWithFrame:CGRectMake(0, 0,  Q(200), Q(64))];
        _lblTitle.text = @"New Score";
        _lblTitle.font = [UIFont fontWithName:Font size:24];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.center = CGPointMake(_content.frame.size.width/2.0, Q(64));
        [_content addSubview:_lblTitle];
        
        _lblScore = [[UILabel alloc] initClearWithFrame:CGRectMake(0, 0, Q(200), Q(64))];
        _lblScore.text = @"109928";
        _lblScore.font = [UIFont fontWithName:Font size:48];
        _lblScore.textAlignment = NSTextAlignmentCenter;
        _lblScore.center = CGPointMake(_content.frame.size.width/2.0, Q(144));
        [_content addSubview:_lblScore];
        
        _lblDescription = [[UILabel alloc] initClearWithFrame:CGRectMake(0, 0, Q(200), Q(64))];
        _lblDescription.text = @"try again try again try again try again";
        _lblDescription.font = [UIFont fontWithName:Font size:16];
        _lblDescription.textAlignment = NSTextAlignmentCenter;
        _lblDescription.center = CGPointMake(_content.frame.size.width/2.0, Q(228));
        [_content addSubview:_lblDescription];
    }
    return self;
}

- (void)btnShareSelected
{
    [AudioHelper click];
    [UMSocialSnsService presentSnsIconSheetView:self.viewController
                                         appKey:AppKey_um
                                      shareText:@"Check out my score on 2048! http://goo.gl/NcAFrc"
                                     shareImage:_shareSnap()
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToFacebook,UMShareToTwitter,UMShareToWechatTimeline,UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:nil];
}

- (void)btnDoneSelected
{
    [AudioHelper click];
    [self exit];
}

- (void)enter
{
    _content.center = CGPointMake(_content.center.x, -_content.frame.size.height/2.0);
    _btnDone.center = CGPointMake(_btnDone.center.x, self.frame.size.height+_btnDone.frame.size.height/2.0);
    _btnShare.center = CGPointMake(_btnShare.center.x, self.frame.size.height+_btnShare.frame.size.height/2.0);
    
    [_content moveToCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height*2.0/5.0) withRebound:CGPointMake(0, 8) delay:0];
    [_btnDone moveToCenter:CGPointMake(self.frame.size.width/2 ,self.frame.size.height-_btnDone.frame.size.height/2.0 - Q(25)) withRebound:CGPointMake(0, -8) delay:.05];
    [_btnShare moveToCenter:CGPointMake(self.frame.size.width/2 ,_btnDone.center.y - Q(48)) withRebound:CGPointMake(0, -8) delay:.1 completion:^(BOOL finished) {
        
    }];
}

- (void)exit
{
    [UIView animateWithDuration:.3 animations:^{
        _content.center = CGPointMake(_content.center.x, -_content.frame.size.height/2.0);
        _btnDone.center = CGPointMake(_btnDone.center.x, self.frame.size.height+_btnDone.frame.size.height/2.0);
        _btnShare.center = CGPointMake(_btnShare.center.x, self.frame.size.height+_btnShare.frame.size.height/2.0);
    } completion:^(BOOL finished) {
        if (_exitBlock) {
            _exitBlock();
        }
    }];
}

@end
