//
//  Kernel.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Kernel.h"

#import "Bomb.h"

#include "Bomber.h"

@implementation Kernel

@synthesize ctrlUI         ;
@synthesize onePlayer      ;
@synthesize map            ;
@synthesize bombCollect    ;

<<<<<<< HEAD
#define LIMIT_PLAYER_OFFSET_POINT_X 100.0
#define LIMIT_PLAYER_OFFSET_POINT_Y 80.0

#define LIMIT_PLAYER_POINT_X ( SCREEN_HIGHT - LIMIT_PLAYER_OFFSET_POINT_X )
#define LIMIT_PLAYER_POINT_Y ( SCREEN_WIDTH  - LIMIT_PLAYER_OFFSET_POINT_Y )
=======
>>>>>>> origin/Jin-Yuan

+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef drawImage = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage * _outImage = [UIImage imageWithCGImage:drawImage];
    CGImageRelease(drawImage);
    return _outImage ;
}

+ (UIImage *) subImageRotate:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height :(int) degree :(float) scale {
    
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef drawImage = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage *  _outImage ;
    if ( degree == 0 )
        _outImage = [UIImage imageWithCGImage:drawImage scale: 1.0 orientation:UIImageOrientationUp];
    else if ( degree == 90 )
        _outImage = [UIImage imageWithCGImage:drawImage scale: 1.0 orientation:UIImageOrientationRight];
    else if ( degree == -90 )
      _outImage = [UIImage imageWithCGImage:drawImage scale: 1.0 orientation:UIImageOrientationLeft];
    else if ( degree == 180 )
      _outImage = [UIImage imageWithCGImage:drawImage scale: 1.0 orientation:UIImageOrientationDown];
    
    _outImage = [UIImage imageWithCGImage:drawImage scale: scale orientation:UIImageOrientationUp];
        
    
    CGImageRelease(drawImage);
    return _outImage ;
    
}


+ (void) drawText:(NSString *) strText offsetWidth:(int)x offsetHeight:(int)y textSize:(int)size {
    [strText drawAtPoint:CGPointMake(x, y) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:size]}];
}

+ (void) drawFPS:(int) x offsetHeight:(int)y textSize:(int)size{
    // TODO 改版成這樣 數字比較不會浮動，因為數字會越來越大導致於比較不會變動
    static unsigned int count = 0 ;
    static double firstTime = 0 ;
    double currentTime = CACurrentMediaTime() ;
    if (count == 0 )  firstTime = currentTime ;
    NSString * fps =  [NSString stringWithFormat:@"FPS :%f", (count/(currentTime - firstTime)) ] ;
    count++ ;
    [[Kernel class] drawText:fps offsetWidth:x offsetHeight:y textSize:size];
}

- (id) init{
    self        = [super init] ;
    [[ Resource class ] InitalResource ] ;
    [[Player class] InitializeAllImage] ;
    ctrlUI      = [[Control alloc] init] ;
    onePlayer   = [[Player  alloc] initial :MARIO_RPG] ;
    map         = [[MapData alloc] init] ;
    bombCollect = [[NSMutableArray alloc] init] ;
    return self ;
}


- (void)start{
}

- (void)stop{
}


- (void)draw{
    // 玩家原始位置
    const CGPoint playerPoint = [onePlayer getLocalPoint] ;
    // 移動位置
    const CGPoint ctrlMove    = [ctrlUI getMove] ;
    // 移動過後位置
    const CGPoint playerAfterMovePoint = CGPointMake( playerPoint.x + ctrlMove.x, playerPoint.y + ctrlMove.y );
    // TODO 利用上面已知的三個值，算出 地圖要移動多少，與玩家要移動多少
    CGPoint screenMove = {0,0} ;
    CGPoint playerMove = {0,0} ;
    
    NSLog(@"Player Local_X:%f Local_Y:%f CTRL_X:%f CTRL_Y:%f PLAYER_X:%f PLAYER_Y:%f SCREEN_X:%f SCREEN_Y:%f",
          playerPoint.x, playerPoint.y, ctrlMove.x, ctrlMove.y, playerMove.x, playerMove.y, screenMove.x, screenMove.y ) ;

    
    // TODO 目標
    // [ map doMove:screenMove] ;
    // [ onePlayer doMove:playerMove] ;
    
    // TODO 測試中
    [ onePlayer doMove:ctrlMove] ;
    
    [ map draw ] ;
    [ ctrlUI draw ];
    [ onePlayer draw ];
    
    /*
    static int count = 0 ;
    if ( (count++ % 50) == 0 )
        [bombCollect addObject:[[Bomb class] putBomb:arc4random() % 300  :arc4random() % 300 :UNBOMB]] ;
    */
    
    
    // 是否 callback方法移除炸彈
    for(Bomb *bomb in bombCollect) {
        [bomb draw] ;
    }
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect redRect = CGRectMake(LIMIT_PLAYER_OFFSET_POINT_X,
                                LIMIT_PLAYER_OFFSET_POINT_Y,
                                SCREEN_HIGHT  - (LIMIT_PLAYER_POINT_X * 2),
                                SCREEN_WIDTH - (LIMIT_PLAYER_POINT_Y * 2 )) ;
    
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
	//填充矩形
	CGContextFillRect(ctx, redRect);
	//设置画笔颜色：黑色
	CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
	//设置画笔线条粗细
    CGContextSetLineWidth(ctx, 3.0);
	//画矩形边框
	CGContextAddRect(ctx,redRect);
	//执行绘画
    CGContextStrokePath(ctx);
    
    [[Kernel class] drawFPS:20 offsetHeight:30 textSize:24];
    
}

- (void)touchesBegan:(CGPoint *) location{
    [ctrlUI touchesBegan:location];
}
- (void)touchesCancelled:(CGPoint *) location{
    [ctrlUI touchesBegan:location];
}
- (void)touchesMoved:(CGPoint *) location{
    [ctrlUI touchesMoved:location];
    
}
- (void)touchesEnded:(CGPoint *) location{
    [ctrlUI touchesEnded:location];
}

@end
