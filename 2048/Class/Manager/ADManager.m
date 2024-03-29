//
//  ADManager.m
//  2048
//
//  Created by Joe on 14-4-2.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "ADManager.h"
#define admob_id @"a1532dc423dcc46"
#define loop_interval 75
@implementation ADManager
static ADManager *_sharedManager;
+ (ADManager *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ADManager alloc] init];
    });
    return _sharedManager;
}

- (void)loop
{
    if (self.currentType == ADTypeApple)
    {
        [self reloadWithType:ADTypeGoogle];
    }
    else
    {
        [self reloadWithType:ADTypeApple];
    }
}

- (void)reloadWithType:(ADType)type
{
    NSLog(@"reload");
    self.currentType = type;
    if (type == ADTypeApple)
    {
        _gadBanner.alpha = 0;
        _aadBanner.alpha = 1;
//        ;
    }
    else
    {
        _gadBanner.alpha = 1;
        _aadBanner.alpha = 0;
//        ;
    }
    [self.rootViewController.view  addSubview:_gadBanner];
    [self.rootViewController.view  addSubview:_aadBanner];
}

- (void)initWithViewController:(UIViewController *)controller
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    self.rootViewController = controller;
    _aadBanner = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _aadBanner.frame = CGRectMake(_aadBanner.frame.origin.x,
                                  winSize.height - _aadBanner.frame.size.height,
                                  winSize.width/2,
                                  _aadBanner.frame.size.height/2);
    _aadBanner.delegate = self;
    [controller.view addSubview:_aadBanner];
    
    _gadBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:CGPointZero];
    _gadBanner.frame = CGRectMake(0,
                                winSize.height - CGSizeFromGADAdSize(kGADAdSizeBanner).height,
                                winSize.width,
                                CGSizeFromGADAdSize(kGADAdSizeBanner).height);
    _gadBanner.adUnitID = admob_id;
    _gadBanner.delegate = self;
    _gadBanner.rootViewController = controller;
    [controller.view addSubview:_gadBanner];
    [_gadBanner loadRequest:[self gRequest]];
    
    [_loopTimer invalidate];
    _loopTimer = [NSTimer scheduledTimerWithTimeInterval:loop_interval target:self selector:@selector(loop) userInfo:nil repeats:YES];
}

#pragma mark - Google
- (GADRequest *)gRequest {
    GADRequest *request = [GADRequest request];
    request.testDevices = @[GAD_SIMULATOR_ID];
    return request;
}

- (void)adViewDidReceiveAd:(GADBannerView *)view{}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error{}
- (void)adViewWillPresentScreen:(GADBannerView *)adView{}
- (void)adViewWillDismissScreen:(GADBannerView *)adView{}
- (void)adViewDidDismissScreen:(GADBannerView *)adView{}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView{}

#pragma mark - apple
- (void)bannerViewWillLoadAd:(ADBannerView *)banner{}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{}
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return true;
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner{}
@end
