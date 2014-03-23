//
//  AudioHelper.h
//  2048
//
//  Created by Joe on 14-3-23.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioHelper : NSObject

+ (void)play:(NSString *)url;

+ (void)click;

+ (void)crash;

+ (void)slide;

+ (void)error;

@end
