//
//  Kernel.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import  "Kernel.h"
#import  "Player.h"
#import  "Bomb.h"
#import  "Bomber.h"
#import  "Block.h"

@implementation Kernel

@synthesize ctrlUI         ;
@synthesize onePlayer      ;
@synthesize map            ;
@synthesize one_block      ;

#define LIMIT_PLAYER_OFFSET_POINT_X 100.0
#define LIMIT_PLAYER_OFFSET_POINT_Y 80.0

#define LIMIT_PLAYER_POINT_X ( SCREEN_HIGHT - LIMIT_PLAYER_OFFSET_POINT_X )
#define LIMIT_PLAYER_POINT_Y ( SCREEN_WIDTH  - LIMIT_PLAYER_OFFSET_POINT_Y )

#undef DEBUG

+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height imgTurn:(NSInteger)degree imgScale:(float) scale {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef drawImage = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage *  _outImage ;
    _outImage = [UIImage imageWithCGImage:drawImage scale:scale orientation:degree];
    CGImageRelease(drawImage);
    return _outImage ;
}

+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height {
    return [[Kernel class] subImage:img offsetWidth:x offsetHeight:y imgWidth:width imgHeight:height imgTurn:UIImageOrientationUp imgScale:1.0] ;
}

+ (UIImage *) subImage:(UIImage *) img getImgRect:(CGRect)rect {
    return [[Kernel class] subImage:img offsetWidth:rect.origin.x offsetHeight:rect.origin.y imgWidth:rect.size.width imgHeight:rect.size.height imgTurn:UIImageOrientationUp imgScale:1.0] ;
}

+ (UIImage *) subImage:(UIImage *) img getImgRect:(CGRect)rect imgTurn:(NSInteger)degree imgScale:(float)scale{
    return [[Kernel class] subImage:img offsetWidth:rect.origin.x offsetHeight:rect.origin.y imgWidth:rect.size.width imgHeight:rect.size.height imgTurn:degree imgScale:scale] ;
}

+ (UIImage *) subImage:(UIImage *) img getImgRect:(CGRect)rect imgScale:(float)scale{
    return [[Kernel class] subImage:img offsetWidth:rect.origin.x offsetHeight:rect.origin.y imgWidth:rect.size.width imgHeight:rect.size.height imgTurn:UIImageOrientationUp imgScale:scale] ;
}

+ (UIImage *) subImage:(UIImage *) img getImgRect:(CGRect)rect imgTurn:(NSInteger)degree{
    return [[Kernel class] subImage:img offsetWidth:rect.origin.x offsetHeight:rect.origin.y imgWidth:rect.size.width imgHeight:rect.size.height imgTurn:degree imgScale:1.0] ;
}

+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height imgScale:(float)scale{
    return [[Kernel class] subImage:img offsetWidth:x offsetHeight:y imgWidth:width imgHeight:height imgTurn:UIImageOrientationUp imgScale:scale] ;
}

+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height imgTurn:(NSInteger)degree{
    return [[Kernel class] subImage:img offsetWidth:x offsetHeight:y imgWidth:width imgHeight:height imgTurn:degree imgScale:1.0] ;
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
    [[Resource class ] initalResource ] ;
    [[MapData class ]  initialImage ] ;
    [[MapData class ]  initialDSGroung ] ;
    [[Player class]    initializeAllImage] ;
    [[Bomb class]      initialImage] ;
    [[Block class]     initializeAllImage] ;
    
    // TODO 未來應該是有個地方，給予使用者一個起始位置，然而有了這個起始座標，就可以畫出螢幕畫面
    CGPoint roleStartPoint = CGPointMake( SCREEN_HIGHT/ 2 , SCREEN_WIDTH  / 2 ) ;
    
    onePlayer   = [[Player  alloc] initial :MARIO_RPG startPoint:roleStartPoint] ;
    
    ctrlUI      = [[Control alloc] initWithUsrPlay:onePlayer] ;
    // TODO 起始的位置 格子
    CGPoint roleStartMap   = CGPointMake(20, 25) ;
    map         = [[MapData alloc] initWithPoint:roleStartMap startScreen:roleStartPoint] ;
    
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
    // 利用上面已知的三個值，算出 地圖要移動多少，與玩家要移動多少
    CGPoint screenMove = {0,0} ;
    CGPoint playerMove = {0,0} ;
    if ( playerAfterMovePoint.x > LIMIT_PLAYER_POINT_X ||  playerAfterMovePoint.x < LIMIT_PLAYER_OFFSET_POINT_X) {
        screenMove.x = ctrlMove.x ;
    } else {
        playerMove.x = ctrlMove.x ;
    }
    
    if ( playerAfterMovePoint.y > LIMIT_PLAYER_POINT_Y ||  playerAfterMovePoint.y < LIMIT_PLAYER_OFFSET_POINT_Y) {
        screenMove.y = ctrlMove.y ;
    } else {
        playerMove.y = ctrlMove.y ;
    }
    
    // TODO 因為假如只有移動螢幕，就不會動角色，但是這樣角色就不會轉方向
    // FIXME 莫名其妙有時候他轉的方向是錯的
    [ onePlayer setTurn:ctrlMove]  ;
    
    /* 未來應該是，由這邊判斷，使用者是否可以移動，
       因為已使用者目前座標與底下的陣列，發現他已經碰到底了，導致他無法移動過去
       所以這邊需要:
       1. 使用者目前位置
       2. 周遭座標的邊
       3. 周遭是什麼東西
       4. 如果可以移動，那是使用者移動，還是畫面移動
    */
    [ map doMove:screenMove]       ;
    [ onePlayer doMove:playerMove] ;
    
    [ map draw ] ;
    [ ctrlUI draw ];
    [ onePlayer draw ];
    
    
#ifdef DEBUG
    
    static int count = 0 ;
    if ( (count++ % 50) == 0 )
        [bombCollect addObject:[[Bomb class] putBomb:arc4random() % 300  :arc4random() % 300 :UNBOMB :false : false ]] ;
    
    
    // 是否 callback方法移除炸彈
    for(Bomb *bomb in bombCollect) {
        [bomb draw] ;
    }
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect redRect = CGRectMake(LIMIT_PLAYER_OFFSET_POINT_X,
                                LIMIT_PLAYER_OFFSET_POINT_Y,
                                LIMIT_PLAYER_POINT_X  - LIMIT_PLAYER_OFFSET_POINT_X ,
                                LIMIT_PLAYER_POINT_Y  - LIMIT_PLAYER_OFFSET_POINT_Y ) ;
    
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
#endif 
    
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
