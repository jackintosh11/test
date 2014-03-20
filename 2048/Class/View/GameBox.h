//
//  BackgroundCellView.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameBlock;
@interface GameBox : UIView
{
    
}
@property (nonatomic, assign) BOOL IsEmpty;
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, assign) GameBlock *currentBlock;

- (BOOL)hit:(GameBlock *)block;
- (void)creatBlock:(GameBlock *)block;
@end
