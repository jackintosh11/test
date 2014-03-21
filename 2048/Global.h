//
//  Global.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Q(__A__) (isPad?__A__*2:__A__)
#define AppKey_um @"532ae51856240b2cd8016426"

#define BackgroundColor [UIColor colorWithRed:231.0/255.0 green:235.0/255.0 blue:239.0/255.0 alpha:.1]
#define Font @"Chalkduster"
