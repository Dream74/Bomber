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

// #undef DEBUG


@synthesize ctrlUI         ;
@synthesize onePlayer      ;
@synthesize map            ;
@synthesize one_block      ;
@synthesize twoPlayer      ;


/*
 * subImage
 * img         : original img
 * offsetWidth : get original img offset width
 * offsetHeight: get original img offset hight
 * imgWidth    : get original img width
 * imgHeight   : get original img hight
 * imgTurn     : get original trans trun 
 * imgScale    : get original scale
 */
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

/*
 * drawText
 * strText     : draw text content
 * offsetWidth : draw offset screen width
 * offsetHeight: draw offset screen height
 * textSize    : text size
 */
+ (void) drawText:(NSString *) strText offsetWidth:(int)x offsetHeight:(int)y textSize:(int)size {
    [strText drawAtPoint:CGPointMake(x, y) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:size]}];
}

/*
 * drawFPS
 * x           : draw offset screen width
 * offsetHeight: draw offset screen height
 * textSize    : text size
 */
+ (void) drawFPS:(int) x offsetHeight:(int)y textSize:(int)size{
    // TODO 改版成這樣 數字比較不會浮動，因為數字會越來越大導致於比較不會變動
    static unsigned int count = 0 ;
    static double firstTime = 0 ;
    double currentTime = CACurrentMediaTime() ;
    if (count == 0 )  firstTime = currentTime ;
    NSString * fps =  [NSString stringWithFormat:@"FPS :%f", (count/(currentTime - firstTime)) ] ;
    // NSLog(@"%d", count) ;
    count++ ;
    [[Kernel class] drawText:fps offsetWidth:x offsetHeight:y textSize:size];
}

/*
 * drawGrid
 * x           : draw offset screen width
 * offsetHeight: draw offset screen height
 * lineWidth   : draw rect line width
 */
+ (void) drawGrid:(CGRect)rect lineWidth:(float)line {
    // 畫格子
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    // 設定畫線的顏色 , 黑色
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
    // 設定畫的線條粗細
    CGContextSetLineWidth(ctx, line);
    // 畫的區域背景
    CGContextFillRect(ctx, rect);
    // 設定畫的邊框
    CGContextAddRect(ctx,rect);
    // 開始畫上去
    CGContextStrokePath(ctx);
}

- (id) init{
    self        = [super init] ;
<<<<<<< HEAD
    
    /*
     for( int i = 0 ; i < 5 ; i++) {
     [[self.firebase childByAutoId] setValue:@{@"text" :  [NSString stringWithFormat:@"%d",i], @"name": @"Tester"} ] ;
     }
     */
    // Server End
    
=======
  
>>>>>>> Dream
    [[Resource class ] initalResource ] ;
    [[MapData class ]  initialImage ] ;
    [[Player class]    initializeAllImage] ;
    [[Bomb class]      initialImage] ;
    [[Block class]     initializeAllImage] ;
    
<<<<<<< HEAD
    // TODO 未來應該是有個地方，給予使用者一個起始位置，然而有了這個起始座標，就可以畫出螢幕畫面
    CGPoint roleStartPoint = CGPointMake( SCREEN_HIGHT/ 2 , SCREEN_WIDTH  / 2 ) ;
    CGPoint roleStartPoint2   = CGPointMake( SCREEN_HIGHT/ 2-32 , SCREEN_WIDTH  / 2 ) ;
    //  FIXME 換圖片人物角色會跑掉 .
    onePlayer   = [[Player  alloc] initial:MARIO_RPG startPoint:roleStartPoint] ;
    twoPlayer   = [[Player  alloc] initial:FLY startPoint:roleStartPoint2] ;
=======
    // 人物 螢幕 位置 : 螢幕中間
    CGPoint roleStartPoint = CGPointMake( SCREEN_HIGHT  / 2 , SCREEN_WIDTH  / 2 ) ;
    // 人物 格子 位置 : 30, 40 這個格子上
    CGPoint roleStartMap   = CGPointMake( 30,40 ) ;
    
    // 人物 角色為 MARIO
    onePlayer   = [[Player  alloc] initial:MARIO_RPG startPoint:roleStartPoint] ;
    // FIMEX 其他角色座標有跑掉的問題
>>>>>>> Dream
    // onePlayer   = [[Player  alloc] initial :GOLD startPoint:roleStartPoint] ;

    onePlayer.dataLoc = roleStartMap ;
    
    /* 地圖要從哪邊開始畫起來
     * 我們當然希望螢幕一打開就看到角色在中間
     * 所以在畫哪個背景是由角色的位置{ roleStartMap, roleStartPoint }開始計算
     */
    map         = [[MapData alloc] initWithUsr:onePlayer mapPoint:roleStartMap startScreen:roleStartPoint] ;
    ctrlUI      = [[Control alloc] initWithMap:map] ;

    return self ;
}


- (void)start{
}

- (void)stop{
}


- (void)draw{
<<<<<<< HEAD
    
=======
    // 每次要畫前 利用 getMove 我們可以知道玩家在控制器上面移動了多少距離
>>>>>>> Dream
    const CGPoint ctrlMove    = [ctrlUI getMove] ;
    
    /*
     * 根據這個移動距離，我們要丟給map計算 是玩家螢幕位子要改變還是，背景圖移動
     * 因為我們希望角色會被定在螢幕中間
     * 所以角色在螢幕中央附近，角色會移動他的位置
     * 反之角色快移動超出中央位置，會改變成角色只是轉了移動方向，
     * 但剩下的是背景在移動
     */
    [ map doMove:ctrlMove] ;
    
    // 畫 背景
    [ map draw ]           ;
    // control ui draw
    [ ctrlUI draw ]        ;
    // 人物的狀態畫上去
    [ onePlayer draw ]     ;
<<<<<<< HEAD
    [ twoPlayer draw ]      ;
=======
    // 畫FPS狀態
>>>>>>> Dream
    [[Kernel class] drawFPS:20 offsetHeight:30 textSize:24];
    
}


-(void)drawctrlUI {
    
}


/*
 * 把螢幕的觸控狀態傳給 ctrUI
 * 讓他可以計算 
 * 1. 角色該移動多少
 * 2. 角色是否該放置炸彈
 */
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
