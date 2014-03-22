//
//  PopupMenu.h
//  2048
//
//  Created by Jason.Zhang on 3/22/14.
//  Copyright (c) 2014 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupMenu : UIView
{
    UIButton *_btnResume;
    UIButton *_btnRestart;
    UIButton *_btnExit;
}

@property (nonatomic, strong)void(^resumeCallback)(BOOL finished);
@property (nonatomic, strong)void(^restartCallback)(BOOL finished);
@property (nonatomic, strong)void(^exitCallback)(BOOL finished);

- (void)enter;
- (void)exit:(void (^)(BOOL finished))completion;

@end
