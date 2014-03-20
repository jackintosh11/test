//
//  AppDelegate.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MainViewController *_mainViewController;

}
@property (strong, nonatomic) UIWindow *window;

@end
