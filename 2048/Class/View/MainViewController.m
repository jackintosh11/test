//
//  MainViewController.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self = [super init];
    if (self) {
        _gameView = [[GameView alloc] initWithFrame:self.view.frame];
        _mainView = [[MainView alloc] initWithFrame:self.view.frame];
        __weak MainViewController *this = self;
        __weak GameView *thisGame = _gameView;
        _mainView.startGame = ^(int level){
            thisGame.currentGameSize = level;
            this.view = thisGame;
            [thisGame Start];
        };
        self.view = _mainView;
    }
    return self;
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
