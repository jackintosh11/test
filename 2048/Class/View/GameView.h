//
//  GameView.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum GameDirection
{
    GameDirectionTurnLeft = 1,
    GameDirectionTurnUp = 2,
    GameDirectionTurnRight = 3,
    GameDirectionTurnDown = 4
}GameDirection;

@interface GameView : UIView
{
    UIButton *_btnTurnLeft;
    UIButton *_btnTurnUp;
    UIButton *_btnTurnRight;
    UIButton *_btnTurnDown;
    CGPoint _lastTouchLocation;
    NSMutableArray *_gameBoxs;
    NSMutableArray *_gameBlocks;
}
@property (nonatomic, assign) int currentGameSize;
- (void)Start;
@end
