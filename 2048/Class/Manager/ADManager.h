//
//  ADManager.h
//  2048
//
//  Created by Joe on 14-4-2.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"
#import "GADRequest.h"
#import <iAd/iAd.h>

typedef enum
{
    ADTypeApple = 1,
    ADTypeGoogle = 2,
}ADType;

@interface ADManager : NSObject <ADBannerViewDelegate,GADBannerViewDelegate>
{
    ADBannerView *_aadBanner;
    GADBannerView *_gadBanner;
    NSTimer *_loopTimer;
}
@property (nonatomic, assign) UIViewController *rootViewController;
@property (nonatomic, assign) ADType currentType;
+ (ADManager *)shared;
- (void)initWithViewController:(UIViewController *)controller;
- (void)reloadWithType:(ADType)type;
- (void)loop;
@end
