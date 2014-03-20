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
    UILabel *_lblLevel;
}
@property (nonatomic, assign) int level;
@property (nonatomic, strong)void(^startGame)(int level);
@end
