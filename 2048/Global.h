//
//  Global.h
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define Q(__A__) (isPad?__A__*2:__A__)