//
//  CellView.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBox.h"
@interface GameBlock : UIView
{
    UILabel *_label;
    BOOL _disappear;
}
@property (nonatomic, assign) GameBox *box;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, assign) BOOL hitable;
@property (nonatomic, strong) void(^moveEnd)(GameBlock *);
@property (nonatomic, readonly) BOOL isMoving;
- (void)disappear;
- (void)refresh;
@end
