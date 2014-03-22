//
//  Global.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Q(__A__) (isPad?__A__*1.4:__A__)
#define AppKey_um @"532ae51856240b2cd8016426"

#define BackgroundColor [UIColor colorWithRed:249.0/255.0 green:248.0/255.0 blue:238.0/255.0 alpha:1]
#define Font @"Chalkduster"

#define ReboundOffsetYP CGPointMake(0, 8)
#define ReboundOffsetYN CGPointMake(0, -8)