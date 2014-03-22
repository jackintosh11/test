//
//  MainViewController.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
#import "GameView.h"
#import "CountView.h"

@interface MainViewController : UIViewController
{
    MainView *_mainView;
    GameView *_gameView;
    CountView *_countView;
}
@end
