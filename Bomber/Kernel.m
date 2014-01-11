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
    // NSLog(@"%d", count) ;
    count++ ;
    [[Kernel class] drawText:fps offsetWidth:x offsetHeight:y textSize:size];
}

+ (void) drawGrid:(CGRect)rect lineWidth:(float)line {
    // 畫格子
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    //设置画笔颜色：黑色
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
    //设置画笔线条粗细
    CGContextSetLineWidth(ctx, line);
    //填充矩形
    CGContextFillRect(ctx, rect);
    //画矩形边框
    CGContextAddRect(ctx,rect);
    //执行绘画
    CGContextStrokePath(ctx);
}

- (id) init{
    self        = [super init] ;
    
    /*
     for( int i = 0 ; i < 5 ; i++) {
     [[self.firebase childByAutoId] setValue:@{@"text" :  [NSString stringWithFormat:@"%d",i], @"name": @"Tester"} ] ;
     }
     */
    // Server End
    
    [[Resource class ] initalResource ] ;
    [[MapData class ]  initialImage ] ;
    [[MapData class ]  initialDSGroung ] ;
    [[Player class]    initializeAllImage] ;
    [[Bomb class]      initialImage] ;
    [[Block class]     initializeAllImage] ;
    
    // TODO 未來應該是有個地方，給予使用者一個起始位置，然而有了這個起始座標，就可以畫出螢幕畫面
    CGPoint roleStartPoint = CGPointMake( SCREEN_HIGHT/ 2 , SCREEN_WIDTH  / 2 ) ;
    CGPoint roleStartPoint2   = CGPointMake( SCREEN_HIGHT/ 2-32 , SCREEN_WIDTH  / 2 ) ;
    //  FIXME 換圖片人物角色會跑掉 .
    onePlayer   = [[Player  alloc] initial:MARIO_RPG startPoint:roleStartPoint] ;
    twoPlayer   = [[Player  alloc] initial:FLY startPoint:roleStartPoint2] ;
    // onePlayer   = [[Player  alloc] initial :GOLD startPoint:roleStartPoint] ;
    
    // TODO 起始的位置 格子
    CGPoint roleStartMap   = CGPointMake(5, 25) ;
    
    map         = [[MapData alloc] initWithUsr:onePlayer mapPoint:roleStartMap startScreen:roleStartPoint] ;
    ctrlUI      = [[Control alloc] initWithMap:map] ;

    return self ;
}


- (void)start{
}

- (void)stop{
}


- (void)draw{
    
    const CGPoint ctrlMove    = [ctrlUI getMove] ;
    
    [ map doMove:ctrlMove] ;
    [ map draw ]           ;
    [ ctrlUI draw ]        ;
    [ onePlayer draw ]     ;
    [ twoPlayer draw ]      ;
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
