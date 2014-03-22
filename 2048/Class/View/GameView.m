//
//  GameView.m
//  2048
//
//  Created by Joe on 14-3-19.
//  Copyright (c) 2014年 Joe. All rights reserved.
//

#import "GameView.h"
#import "GameBox.h"
#import "GameBlock.h"
#import "UIView+Animation.h"
#import "Global.h"
//#import "UIView+Controller.h"

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:BackgroundColor];
        
        _gameBoxs = [[NSMutableArray alloc] init];
        _gameBlocks = [[NSMutableArray alloc] init];
        _baseView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_baseView];
//        _btnTurnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_btnTurnLeft setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
//        [_btnTurnLeft addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
//        _btnTurnUp = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_btnTurnUp setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
//        [_btnTurnUp addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
//        _btnTurnRight = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_btnTurnRight setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
//        [_btnTurnRight addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
//        _btnTurnDown = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_btnTurnDown setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
//        [_btnTurnDown addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
//        _btnTurnUp.frame =
//        _btnTurnDown.frame =
//        _btnTurnLeft.frame =
//        _btnTurnRight.frame = CGRectMake(0, 0, isPad?60:50, isPad?60:50);
//
//        _btnTurnUp.frame = CGRectMake(frame.size.width/2 - _btnTurnUp.frame.size.width/2,
//                                      frame.size.height - _btnTurnUp.frame.size.height * 3,
//                                      _btnTurnUp.frame.size.width,
//                                      _btnTurnUp.frame.size.height);
//        _btnTurnDown.frame = CGRectMake(frame.size.width/2 - _btnTurnUp.frame.size.width/2,
//                                        frame.size.height - _btnTurnUp.frame.size.height * 1.5,
//                                        _btnTurnUp.frame.size.width,
//                                        _btnTurnUp.frame.size.height);
//        _btnTurnLeft.frame = CGRectMake(frame.size.width/2 - _btnTurnUp.frame.size.width * 2,
//                                        frame.size.height - _btnTurnUp.frame.size.height * 1.5,
//                                        _btnTurnUp.frame.size.width,
//                                        _btnTurnUp.frame.size.height);
//        _btnTurnRight.frame = CGRectMake(frame.size.width/2 + _btnTurnUp.frame.size.width,
//                                         frame.size.height - _btnTurnUp.frame.size.height * 1.5,
//                                         _btnTurnUp.frame.size.width,
//                                         _btnTurnUp.frame.size.height);
//        
//        _btnTurnLeft.backgroundColor = [UIColor purpleColor];
//        _btnTurnUp.backgroundColor = [UIColor purpleColor];
//        _btnTurnRight.backgroundColor = [UIColor purpleColor];
//        _btnTurnDown.backgroundColor = [UIColor purpleColor];
        
        
//        [self addSubview:_btnTurnLeft];
//        [self addSubview:_btnTurnUp];
//        [self addSubview:_btnTurnRight];
//        [self addSubview:_btnTurnDown];
//        [_btnTurnLeft setTitle:@"<" forState:UIControlStateNormal];
//        [_btnTurnUp setTitle:@"^" forState:UIControlStateNormal];
//        [_btnTurnRight setTitle:@">" forState:UIControlStateNormal];
//        [_btnTurnDown setTitle:@"V" forState:UIControlStateNormal];
        
        _currentGameSize = 4;
//        UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [btnShare setTitle:@"share" forState:UIControlStateNormal];
//        btnShare.frame = CGRectMake(frame.size.width - 100, 20, 50, 50);
//        [btnShare addTarget:self
//                     action:@selector(Share)
//           forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btnShare];
        
        _btnMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnMenu.frame = CGRectMake(0, 0, frame.size.width, Q(64));
        [self unhighlightMenu];
        [_btnMenu addTarget:self action:@selector(menuSelected) forControlEvents:UIControlEventTouchUpInside];
        [_btnMenu addTarget:self action:@selector(highlightMenu) forControlEvents:UIControlEventTouchDown];
        [_btnMenu addTarget:self action:@selector(unhighlightMenu) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:_btnMenu];

        _lblScoreText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Q(40), Q(30))];
        [_lblScoreText setCenter:CGPointMake(frame.size.width/2.0 + _lblScoreText.frame.size.width/2.0, _lblScoreText.frame.size.height)];
        [_lblScoreText setFont:[UIFont fontWithName:Font size:Q(12)]];
        [_lblScoreText setText:@"Score"];
        [_lblScoreText setTextAlignment:NSTextAlignmentCenter];
        [_btnMenu addSubview:_lblScoreText];
        _lblScore = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Q(100), Q(30))];
        [_lblScore setCenter:CGPointMake(_lblScoreText.center.x + Q(75), _lblScoreText.frame.size.height)];
        [_lblScore setFont:[UIFont fontWithName:Font size:Q(18)]];
        [_lblScore setText:@"0"];
        [_lblScore setTextAlignment:NSTextAlignmentCenter];
        [_btnMenu addSubview:_lblScore];
        
        _lblNumberText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Q(90), Q(30))];
        [_lblNumberText setCenter:CGPointMake(_lblNumberText.frame.size.width/2.0, _lblNumberText.frame.size.height)];
        [_lblNumberText setFont:[UIFont fontWithName:Font size:Q(12)]];
        [_lblNumberText setText:@"Number"];
        [_lblNumberText setTextAlignment:NSTextAlignmentCenter];
        [_btnMenu addSubview:_lblNumberText];
        _lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Q(60), Q(30))];
        [_lblNumber setCenter:CGPointMake(_lblNumberText.center.x + Q(65), _lblNumberText.frame.size.height)];
        [_lblNumber setFont:[UIFont fontWithName:Font size:Q(18)]];
        [_lblNumber setText:@"0"];
        [_lblNumber setTextAlignment:NSTextAlignmentCenter];
        [_btnMenu addSubview:_lblNumber];
    }
    return self;
}

- (UIImage *)pb_takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [_baseView drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [_baseView drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//
//- (UIImage *)gameView
//{
//    UIGraphicsBeginImageContext(CGSizeMake(320,480));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [_baseView.layer drawInContext:context];
//    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();;
//    return screenShot;
//}

//- (void)Share
//{
//    NSLog(@"share");
//    UIImage *img = [self convertViewToImage];
//    NSLog(@"%@",img);
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"q23";
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
//
//    [UMSocialSnsService presentSnsIconSheetView:self.viewController
//                                         appKey:AppKey_um
//                                      shareText:@"112112211212212121"
//                                     shareImage:img
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,nil]
//                                       delegate:nil];
//}

- (void)Start
{
    [self initBackground:_currentGameSize];
    _baseView.center = CGPointMake(self.frame.size.width * 1.5, self.center.y);
    [_btnMenu setCenter:CGPointMake(_btnMenu.center.x, -_btnMenu.frame.size.height/2.0)];
    
    [_baseView moveToCenter:CGPointMake(self.frame.size.width/2.0, self.center.y)
           withRebound:CGPointMake(-8, 0) delay:0
            completion:^(BOOL finished) {
                [self gameStart];
                
                [_btnMenu moveToCenter:CGPointMake(_btnMenu.center.x, _btnMenu.frame.size.height/2.0) withRebound:CGPointMake(0, 8) delay:0];
            }];
}

- (void)restart
{
    for (GameBlock *block in _gameBlocks) {
        [block removeFromSuperview];
    }
    for (GameBlock *box in _gameBoxs) {
        [box removeFromSuperview];
    }
    [_gameBlocks removeAllObjects];
    [_gameBoxs removeAllObjects];
    
    for (UIView *view in [NSArray arrayWithArray:_baseView.subviews]) {
        [view removeFromSuperview];
    }
    
    [_popup removeFromSuperview];
    
    self.maxNumber = 0;
    self.score = 0;
}
- (void)dealloc
{
    _gameBoxs = nil;
    _gameBlocks = nil;
}

//- (void)btnDidSelect:(id)sender
//{
//    GameDirection direction = GameDirectionTurnLeft;
//    if (sender == _btnTurnLeft)
//    {
//        direction = GameDirectionTurnLeft;
//    }
//    else if (sender == _btnTurnRight)
//    {
//        direction = GameDirectionTurnRight;
//    }
//    else if (sender == _btnTurnUp)
//    {
//        direction = GameDirectionTurnUp;
//    }
//    else if (sender == _btnTurnDown)
//    {
//        direction = GameDirectionTurnDown;
//    }
//    [self play:direction];
//}

- (void)play:(GameDirection)direction
{
    BOOL moved = [self moveBlocksWithDicrection:direction];
    if (moved)
    {
        [self CreateNewCell];
    }
    [self resetBlock];
    
    if ([self checkGameOver]) {
        [self performSelector:@selector(finishGame) withObject:nil afterDelay:1.5];
    }
}

- (BOOL)checkGameOver
{
    for (int i = 0; i < _gameBoxs.count; i++) {
        GameBox *box = _gameBoxs[i];
        if (box.currentBlock == nil) {
            return NO;
        }
    }
    if ([self moveBlocksWithDicrection:GameDirectionTurnDown]) {
        return NO;
    }
    if ([self moveBlocksWithDicrection:GameDirectionTurnRight]) {
        return NO;
    }
    if ([self moveBlocksWithDicrection:GameDirectionTurnUp]) {
        return NO;
    }
    if ([self moveBlocksWithDicrection:GameDirectionTurnLeft]) {
        return NO;
    }
    return YES;
}

- (void)finishGame
{
    int score = self.score;
    int max = self.maxNumber;
    [self exit:^(BOOL finished) {
        if (_gameOver) {
            _gameOver(score, max);
        }
    }];
}

- (void)initBackground:(int)size
{
    float padding = Q(20);
    float cellSize = ([UIScreen mainScreen].bounds.size.width - 2 * padding)/size;
    float offset = Q(3);
    float spacing = Q(16);
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(spacing, 100 - (padding - spacing),
                                                             ([UIScreen mainScreen].bounds.size.width - 2 * spacing),
                                                             ([UIScreen mainScreen].bounds.size.width - 2 * spacing))];
    bgView.backgroundColor = [UIColor colorWithRed:173/255. green:157/255. blue:143/255. alpha:1];
    bgView.layer.cornerRadius = Q(5);
    [_baseView addSubview:bgView];
    
    
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            CGRect r = CGRectMake(Q(20) + j * cellSize + offset,
                                  100 + i * cellSize + offset,
                                  cellSize - 2 * offset,
                                  cellSize - 2 * offset);
            GameBox *bgCell = [[GameBox alloc]initWithFrame:r];
            bgCell.x = j;
            bgCell.y = i;
            [_baseView addSubview:bgCell];
            [_gameBoxs addObject:bgCell];
        }
    }
}

- (NSMutableArray *)getEmptyBgCells
{
    NSMutableArray *results = [NSMutableArray array];
    for (GameBox *bg in _gameBoxs) {
        if (bg.IsEmpty)
        {
            [results addObject:bg];
        }
    }
    return results;
}

- (NSArray *)getAllBlocksWithDicrection:(GameDirection)direction
{
    NSArray *results = [_gameBlocks sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        GameBlock *block1 = obj1;
        GameBlock *block2 = obj2;
        if (direction == GameDirectionTurnLeft)
        {
            if (block1.x > block2.x)
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }
        else if (direction == GameDirectionTurnRight)
        {
            if (block1.x < block2.x)
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }
        else if (direction == GameDirectionTurnUp)
        {
            if (block1.y > block2.y)
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }
        else if (direction == GameDirectionTurnDown)
        {
            if (block1.y < block2.y)
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }
        return NSOrderedAscending;
    }];
    return results;
}

- (BOOL)hasBlockMoving
{
    for (GameBlock *block in _gameBlocks) {
        if (block.isMoving)
        {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)getBoxesWithx:(int)x y:(int)y direction:(GameDirection)direction
{
    NSMutableArray *results = [NSMutableArray array];
    for (GameBox *box in _gameBoxs) {
        if (direction == GameDirectionTurnLeft)
        {
            if (box.y == y && box.x < x)
            {
                [results addObject:box];
            }
        }
        else if (direction == GameDirectionTurnRight)
        {
            if (box.y == y && box.x > x)
            {
                [results insertObject:box atIndex:0];
            }
        }
        else if (direction == GameDirectionTurnUp)
        {
            if (box.x == x && box.y < y)
            {
                [results addObject:box];
            }
        }
        else
        {
            if (box.x == x && box.y > y)
            {
                [results insertObject:box atIndex:0];
            }
        }

    }
    return results;
}


- (BOOL)moveBlocksWithDicrection:(GameDirection)direction
{
    BOOL moved = NO;
    NSArray *blocks = [self getAllBlocksWithDicrection:direction];
    for (GameBlock *block in blocks) {
        NSArray *boxes = [self getBoxesWithx:block.x y:block.y direction:direction];
        for (GameBox *box in boxes) {
            if ([box hit:block] && [self isConnected:block toBox:box])
            {
                [self hitBlock:block intoBox:box];
                moved = YES;
                break;
            }
        }
    }
    return moved;
}

- (void)gameStart
{
    [self CreateNewCell];
    [self CreateNewCell];
}

- (void)CreateNewCell
{
    NSMutableArray *emptyCells = [self getEmptyBgCells];
    if (emptyCells.count)
    {
        int index = arc4random()%emptyCells.count;
        GameBox *box = [emptyCells objectAtIndex:index];
        GameBlock *block = [[GameBlock alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    box.frame.size.width - 2,
                                                                    box.frame.size.height - 2)];
        block.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
        [box creatBlock:block];
        block.center = box.center;
        [block setNumberDirectly:arc4random()%6 < 5?2:4];
        [block refresh];
        [block show];
        block.moveEnd = ^(GameBlock *b){
            
        };
        [_baseView addSubview:block];
        [_gameBlocks addObject:block];
    }
}

- (void)hitBlock:(GameBlock *)block intoBox:(GameBox *)box
{
    int result = block.number + box.currentBlock.number;
    if (box.currentBlock)
    {
        [block moveToView:box.currentBlock];
        [block disappear];
        __weak GameBlock* temp = block;
        __weak GameView* this = self;
        block.moveEnd = ^(GameBlock *b){
            if (box.currentBlock != temp) {
                [box.currentBlock refresh];
                this.score += box.currentBlock.number;
                if (box.currentBlock.number > this.maxNumber) {
                    this.maxNumber = box.currentBlock.number;
                }
            }
        };
        box.currentBlock.number = result;
        box.currentBlock.hitable = false;
//        [box.currentBlock bounce:1.2 delay:.05 completion:NULL];
    }
    else
    {
        block.number = result;
        block.moveEnd = ^(GameBlock *b){
            [b refresh];
        };
        box.currentBlock = block;
    }
    [self clearBlock];
    
}

- (BOOL)isConnected:(GameBlock *)block toBox:(GameBox *)box
{
    int minX = MIN(block.x, box.x);
    int maxX = MAX(block.x, box.x);
    int minY = MIN(block.y, box.y);
    int maxY = MAX(block.y, box.y);
    for (GameBlock *b in _gameBlocks) {
        if ((b.x > minX && b.x < maxX && b.y == block.y) ||
            (b.y > minY && b.y < maxY && b.x == block.x) )
        {
            return false;
        }
    }
    return true;
}

- (void)clearBlock
{
    for (int i = 0 ; i< _gameBlocks.count; i++) {
        GameBlock *block = [_gameBlocks objectAtIndex:i];
        if (block.box == NULL)
        {
            [_gameBlocks removeObjectAtIndex:i--];
        }
    }
}

- (void)resetBlock
{
    for (int i = 0 ; i< _gameBlocks.count; i++) {
        GameBlock *block = [_gameBlocks objectAtIndex:i];
        block.hitable = true;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    _lastTouchLocation = touchLocation;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    GameDirection direction = -1;
    
    int absX = abs(touchLocation.x - _lastTouchLocation.x);
    int absY = abs(touchLocation.y - _lastTouchLocation.y);
    if ((touchLocation.x - _lastTouchLocation.x)/absY > 2)
    {
        direction = GameDirectionTurnRight;
    }
    else if ((_lastTouchLocation.x - touchLocation.x)/absY > 2)
    {
        direction = GameDirectionTurnLeft;
    }
    else if ((touchLocation.y - _lastTouchLocation.y)/absX > 2)
    {
        direction = GameDirectionTurnDown;
    }
    else if ((_lastTouchLocation.y - touchLocation.y)/absX > 2)
    {
        direction = GameDirectionTurnUp;
    }
    if ((int)direction != -1)
    {
        [self play:direction];
    }
//    else
//    {
//        [self restart];
//    }
    NSLog(@"touch end");
    
}

- (void)menuSelected
{
//    [self exit:^(BOOL finished) {
//        _gameOver(0, 0);
//    }];
    [self unhighlightMenu];
    
    if (!_popup) {
        _popup = [[PopupMenu alloc] initWithFrame:_baseView.frame];
        
        __weak UIView *base = _baseView;
        __weak GameView *this = self;
        __weak UIView *popup = _popup;
        _popup.resumeCallback = ^(BOOL finished) {
            [popup removeFromSuperview];
            [base moveToCenter:CGPointMake(this.frame.size.width/2.0, this.center.y) withRebound:CGPointMake(8, 0) delay:0];
        };
        _popup.exitCallback = ^(BOOL finished) {
            [popup removeFromSuperview];
            this.gameOver(this.score, this.maxNumber);
            [this restart];
        };
        _popup.restartCallback = ^(BOOL finished) {
            [popup removeFromSuperview];
            [this restart];
            [base moveToCenter:CGPointMake(this.frame.size.width/2.0, this.center.y) withRebound:CGPointMake(8, 0) delay:0 completion:^(BOOL finished) {
                [this Start];
            }];
        };
    }
    
    [UIView animateWithDuration:.3 animations:^{
        _baseView.center = CGPointMake(-_baseView.frame.size.width/2.0, _baseView.center.y);
    } completion:^(BOOL finished) {
        [self addSubview:_popup];
        [_popup enter];
    }];
}

- (void)highlightMenu
{
    _btnMenu.backgroundColor = _btnMenu.backgroundColor = [UIColor colorWithRed:207.0/255.0 green:205.0/255.0 blue:200.0/255.0 alpha:1];
}

- (void)unhighlightMenu
{
    _btnMenu.backgroundColor = _btnMenu.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:245.0/255.0 blue:240.0/255.0 alpha:1];
}

- (void)exit:(void (^)(BOOL finished))completion
{
    [self restart];
    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [_baseView setCenter:CGPointMake(-self.frame.size.width/2.0, _baseView.center.y)];
        [_btnMenu setCenter:CGPointMake(_btnMenu.center.x, -self.frame.size.height/2.0)];
        
    } completion:completion];
}

- (void)setMaxNumber:(int)maxNumber
{
    if (_maxNumber != maxNumber) {
        _maxNumber = maxNumber;
        _lblNumber.text = [NSString stringWithFormat:@"%d", _maxNumber];
    }
}

- (void)setScore:(int)score
{
    if (_score != score) {
        _score = score;
        _lblScore.text = [NSString stringWithFormat:@"%d", _score];
    }
}

@end
