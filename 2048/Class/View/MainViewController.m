//
//  MainViewController.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "MainViewController.h"
#import "GADBannerView.h"
#import "GADRequest.h"
#import <iAd/iAd.h>
#import "ADManager.h"
@interface MainViewController ()

@end

@implementation MainViewController
- (id)init
{
    self = [super init];
    if (self) {
        
        
        
        _gameView = [[GameView alloc] initWithFrame:self.view.frame];
        _mainView = [[MainView alloc] initWithFrame:self.view.frame];
        _countView = [[CountView alloc] initWithFrame:self.view.frame];
        __weak MainViewController *this = self;
        __weak GameView *game = _gameView;
        __weak MainView *main = _mainView;
        __weak CountView *count = _countView;
        _mainView.startGame = ^(int level){
            game.currentGameSize = level;
            this.view = game;
            [game Start];
            [[ADManager shared] loop];
        };
        _gameView.gameOver = ^(int score, int max) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            int bestScore = [userDefaults integerForKey:@"bestscore"];
            int bestNumber = [userDefaults integerForKey:@"bestNumber"];
            if (score > bestScore) {
                [userDefaults setInteger:score forKey:@"bestscore"];
            }
            if (max > bestNumber) {
                [userDefaults setInteger:max forKey:@"bestNumber"];
            }
            [userDefaults synchronize];
            
            if (score > bestScore) {
                count.lblTitle.text = @"New Score";
                count.lblScore.text = [NSString stringWithFormat:@"%d", score];
                count.lblDescription.text = @"Great job!";
            }
            else if (max > bestNumber) {
                count.lblTitle.text = @"New Max Number";
                count.lblScore.text = [NSString stringWithFormat:@"%d", max];
                count.lblDescription.text = @"Great job!";
            }
            else {
                if (max >= 2048) {
                    count.lblTitle.text = @"Score";
                    count.lblScore.text = [NSString stringWithFormat:@"%d", score];
                    count.lblDescription.text = @"Well Done!";
                }
                else {
                    count.lblTitle.text = @"Score";
                    count.lblScore.text = [NSString stringWithFormat:@"%d", score];
                    count.lblDescription.text = @"Try Again!";
                }
            }
            
            this.view = count;
            [[ADManager shared] loop];
            [count enter];
        };
        _countView.exitBlock = ^() {
            this.view = main;
            [[ADManager shared] loop];
            [main enter];
        };
        _countView.shareSnap = ^UIImage* () {
            return game.snap;
        };
        self.view = _mainView;

        [[ADManager shared] initWithViewController:self];
        

        // Use predefined GADAdSize constants to define the GADBannerView.
        

        [_mainView enter];
    }
    return self;
}
// We've received an ad successfully.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    //NSLog(@"Received ad successfully");
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    //NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
