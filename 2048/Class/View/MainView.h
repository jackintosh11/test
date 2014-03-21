//
//  MainView.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
{
    UIButton *_btnStart;
    UILabel *_lblLevel;
    
    UILabel *_lblBestScore;
    UILabel *_lblMaxCount;
    
    UIButton *_btnSetting;
    UIButton *_btnAbout;
    UIButton *_btnHelp;
    BOOL _isMenuShow;
}
@property (nonatomic, assign) int level;
@property (nonatomic, strong)void(^startGame)(int level);

- (void)calculateLayersCenter;

@end
