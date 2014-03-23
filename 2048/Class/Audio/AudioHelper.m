//
//  AudioHelper.m
//  2048
//
//  Created by Joe on 14-3-23.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "AudioHelper.h"
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>
@implementation AudioHelper

+ (void)play:(NSString *)filename
{
    SystemSoundID soundID;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],filename]];
    //NSLog(@"%@",url);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound (soundID);
}

+ (void)click
{
    [AudioHelper play:@"button_click.mp3"];
}

+ (void)crash
{
    [AudioHelper play:@"woosh.aif"];
}

+ (void)slide
{
//    [AudioHelper play:@"OpenPage.wav"];
    
}

+ (void)error
{
    [AudioHelper play:@"down.mp3"];
}

@end
