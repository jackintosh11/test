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
#import "UIView+Controller.h"
#import "UMSocial.h"
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
        _btnTurnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTurnLeft setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
        [_btnTurnLeft addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        _btnTurnUp = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTurnUp setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
        [_btnTurnUp addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        _btnTurnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTurnRight setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
        [_btnTurnRight addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        _btnTurnDown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTurnDown setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
        [_btnTurnDown addTarget:self action:@selector(btnDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        _btnTurnUp.frame =
        _btnTurnDown.frame =
        _btnTurnLeft.frame =
        _btnTurnRight.frame = CGRectMake(0, 0, isPad?60:50, isPad?60:50);

        _btnTurnUp.frame = CGRectMake(frame.size.width/2 - _btnTurnUp.frame.size.width/2,
                                      frame.size.height - _btnTurnUp.frame.size.height * 3,
                                      _btnTurnUp.frame.size.width,
                                      _btnTurnUp.frame.size.height);
        _btnTurnDown.frame = CGRectMake(frame.size.width/2 - _btnTurnUp.frame.size.width/2,
                                        frame.size.height - _btnTurnUp.frame.size.height * 1.5,
                                        _btnTurnUp.frame.size.width,
                                        _btnTurnUp.frame.size.height);
        _btnTurnLeft.frame = CGRectMake(frame.size.width/2 - _btnTurnUp.frame.size.width * 2,
                                        frame.size.height - _btnTurnUp.frame.size.height * 1.5,
                                        _btnTurnUp.frame.size.width,
                                        _btnTurnUp.frame.size.height);
        _btnTurnRight.frame = CGRectMake(frame.size.width/2 + _btnTurnUp.frame.size.width,
                                         frame.size.height - _btnTurnUp.frame.size.height * 1.5,
                                         _btnTurnUp.frame.size.width,
                                         _btnTurnUp.frame.size.height);
        
//        _btnTurnLeft.backgroundColor = [UIColor purpleColor];
//        _btnTurnUp.backgroundColor = [UIColor purpleColor];
//        _btnTurnRight.backgroundColor = [UIColor purpleColor];
//        _btnTurnDown.backgroundColor = [UIColor purpleColor];
        
        
        [self addSubview:_btnTurnLeft];
        [self addSubview:_btnTurnUp];
        [self addSubview:_btnTurnRight];
        [self addSubview:_btnTurnDown];
        [_btnTurnLeft setTitle:@"<" forState:UIControlStateNormal];
        [_btnTurnUp setTitle:@"^" forState:UIControlStateNormal];
        [_btnTurnRight setTitle:@">" forState:UIControlStateNormal];
        [_btnTurnDown setTitle:@"V" forState:UIControlStateNormal];
        
        // Initialization code
        _currentGameSize = 4;
        UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnShare setTitle:@"share" forState:UIControlStateNormal];
        btnShare.frame = CGRectMake(frame.size.width - 100, 20, 50, 50);
        [btnShare addTarget:self
                     action:@selector(Share)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnShare];
        
        
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

- (void)Share
{
    NSLog(@"share");
    UIImage *img = [self convertViewToImage];
    NSLog(@"%@",img);
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"q23";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;

    [UMSocialSnsService presentSnsIconSheetView:self.viewController
                                         appKey:AppKey_um
                                      shareText:@"112112211212212121"
                                     shareImage:img
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,nil]
                                       delegate:nil];
}

- (void)Start
{
    [self initBackground:_currentGameSize];
    [self gameStart];
}

- (void)dealloc
{
    _gameBoxs = nil;
    _gameBlocks = nil;
}

- (void)btnDidSelect:(id)sender
{
    GameDirection direction = GameDirectionTurnLeft;
    if (sender == _btnTurnLeft)
    {
        direction = GameDirectionTurnLeft;
    }
    else if (sender == _btnTurnRight)
    {
        direction = GameDirectionTurnRight;
    }
    else if (sender == _btnTurnUp)
    {
        direction = GameDirectionTurnUp;
    }
    else if (sender == _btnTurnDown)
    {
        direction = GameDirectionTurnDown;
    }
    [self play:direction];
}

- (void)play:(GameDirection)direction
{
    BOOL moved = [self moveBlocksWithDicrection:direction];
    if (moved)
    {
        [self CreateNewCell];
    }
    [self resetBlock];
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
        [block show];
        block.center = box.center;
        block.number = (arc4random()%2 + 1) * 2;
        [block refresh];
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
        block.moveEnd = ^(GameBlock *b){
            [box.currentBlock refresh];
        };
        [box.currentBlock pop];
        box.currentBlock.number = result;
        box.currentBlock.hitable = false;
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
    NSLog(@"touch end");
}
@end
