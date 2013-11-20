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
@synthesize ctrlUI    ;
@synthesize onePlayer ;
@synthesize map       ;
@synthesize bombCollect       ;


+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef drawImage = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage * _outImage = [UIImage imageWithCGImage:drawImage];
    CGImageRelease(drawImage);
    return _outImage ;
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
   [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(draw) userInfo:nil repeats:YES];
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
        [bombCollect addObject:[[Bomb class] putBomb:arc4random() % 300  :arc4random() % 300 :RED]] ;
    
    // 是否 callback方法移除炸彈
    for(Bomb *bomb in bombCollect) {
        [bomb draw] ;
    }
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
