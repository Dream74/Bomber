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


+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef drawImage = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage * _outImage = [UIImage imageWithCGImage:drawImage];
    CGImageRelease(drawImage);
    return _outImage ;
}

+ (UIImage *) subImageRotate:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height :(int) degree{
    
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
    
    CGImageRelease(drawImage);
    return _outImage ;
    
}


+ (void) drawText:(NSString *) strText offsetWidth:(int)x offsetHeight:(int)y textSize:(int)size {
    [strText drawAtPoint:CGPointMake(x, y) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:size]}];
}

+ (void) drawFPS:(int) x offsetHeight:(int)y textSize:(int)size{
    static double lastTime = 0 ;
    double currentTime = CACurrentMediaTime() ;
    NSString * fps =  [NSString stringWithFormat:@"FPS :%f", (1/(currentTime - lastTime)) ] ;
    lastTime = currentTime ;
    [[Kernel class] drawText:fps offsetWidth:x offsetHeight:y textSize:size];
}

- (id) init{
    self        = [super init] ;
    ctrlUI      = [[Control alloc] init] ;
    onePlayer   = [[Player  alloc] init] ;
    map         = [[MapData alloc] init] ;
    bombCollect = [[NSMutableArray alloc] init] ;
    return self ;
}


- (void)start{
}

- (void)stop{
}


- (void)draw{
    // [ map draw ] ;
    [ ctrlUI draw ];
    [ onePlayer doMove:[ctrlUI getMove]] ;
    [ onePlayer draw ];
    
    static int count = 0 ;
    if ( (count++ % 50) == 0 )
        [bombCollect addObject:[[Bomb class] putBomb:arc4random() % 300  :arc4random() % 300 :UNBOMB]] ;
    
    // 是否 callback方法移除炸彈
    for(Bomb *bomb in bombCollect) {
        [bomb draw] ;
    }
    
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
