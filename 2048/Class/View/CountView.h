//
//  CountView.h
//  2048
//
//  Created by Jason.Zhang on 3/22/14.
//  Copyright (c) 2014 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountView : UIView
{
    UIView *_content;
    
    UIButton *_btnShare;
    UIButton *_btnDone;
}

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblScore;
@property (nonatomic, strong) UILabel *lblDescription;
@property (nonatomic, strong)void(^exitBlock)();

- (void)enter;
- (void)exit;

@end
