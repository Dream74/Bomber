//
//  Bomb.m
//  Bomber
//
//  Created by dream on 11/20/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Bomb.h"
#import "Kernel.h"

@implementation Bomb

@synthesize originalImg;
@synthesize bombImages;
@synthesize local;

#define ANTION_NUM 9
#define BOMB_SEC   2


-(id)initWithLocation:(CGPoint) localPoint BOMB_COLOR:(int)bombcolor{
    self = [super init] ;
    local = localPoint ;
    [self color] = bombcolor ;
    
    originalImg = [UIImage imageNamed:@"blast.png"] ;
    
    bombImages = [[NSMutableArray alloc] init ];
    for ( int j = 0 ; j < 9 ; j++ ) {
        [ bombImages addObject: [[NSMutableArray alloc] init ] ];
        for ( int i = 0 ; i < 9 ; i++ ) {
            [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImage:originalImg offsetWidth:i*32 offsetHeight:j*32 imgWidth:32 imgHeight:32]];
        } // for
    } // for
    return self ;
}


+ (Bomb *) putBomb:(CGPoint)point :(int) bombColor{
    Bomb * bomb = [[Bomb alloc] initWithLocation:point BOMB_COLOR:bombColor] ;
    [bomb start] ;
    return bomb ;
}

+ (Bomb *) putBomb:(int)x :(int)y :(int) bombColor{
    return [[Bomb class] putBomb:CGPointMake(x, y) :bombColor] ;
}

-(void) draw{
    if ( imgIndex < ANTION_NUM )
        [ [ [ bombImages objectAtIndex:color ] objectAtIndex:imgIndex] drawAtPoint: local]  ;
}

-(void) start{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

-(void) run{
    for (int i = 0 ; i < ( ANTION_NUM + 1 ); i++) {
        imgIndex = i ;
        [NSThread sleepForTimeInterval:((float)BOMB_SEC/ANTION_NUM)];  ;
    }
    [self startbomb];
}

- (void) startbomb{
    NSLog(@"BOMB!!") ;
    
}

@end
