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
    UIView *_baseView;
    
    UIView *_lblBack;
    UILabel *_lblScoreText;
    UILabel *_lblScore;
    UILabel *_lblNumberText;
    UILabel *_lblNumber;
}
@property (nonatomic, assign) int currentGameSize;
@property (nonatomic, strong)void(^gameOver)();

- (void)Start;
- (void)restart;
@end
