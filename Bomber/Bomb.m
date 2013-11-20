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
@synthesize color ;
@synthesize imgIndex ;



#define ANTION_NUM 9
#define BOMB_SEC   1


-(id)initWithLocation:(CGPoint) localPoint BOMB_COLOR:(int)bombcolor{
    self = [super init] ;
    local = localPoint ;
    color = bombcolor ;
    
    originalImg = [UIImage imageNamed:@"blast.png"] ;
    UIImage * originalImg2 = [UIImage imageNamed:@"bomb_32x32_2.png"] ;
    
    bombImages = [[NSMutableArray alloc] init ];
    for ( int j = 0 ; j < 10 ; j++ ) {
        [ bombImages addObject: [[NSMutableArray alloc] init ] ];
        if ( j == 0 ) {
            for ( int i = 0 ; i < 14 ; i++ ) {
                [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImage:originalImg2 offsetWidth:0 offsetHeight:i*32 imgWidth:32 imgHeight:32]];
            } // for
        } // if
        
        else {
            for ( int i = 0 ; i < 9 ; i++ ) {
                [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImage:originalImg offsetWidth:i*32 offsetHeight:(j-1)*32 imgWidth:32 imgHeight:32]];
            } // for
        } // else
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
    if ( color == 0 && imgIndex < 14 )
        [ [ [ bombImages objectAtIndex:color ] objectAtIndex:imgIndex] drawAtPoint: local]  ;
    else if ( imgIndex < 9 )
        [ [ [ bombImages objectAtIndex:color ] objectAtIndex:imgIndex] drawAtPoint: local]  ;
}

-(void) start{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

-(void) run{
    for (int i = 0 ; i < ( 15 ); i++) {
        imgIndex = i ;
        if ( i != 14 ) [NSThread sleepForTimeInterval:((float)5/14)];
    } // for
    color = random() %9 + 1;
    
    for ( int i = 0 ; i < ( ANTION_NUM + 1 ) ; i++ ) {
        imgIndex = i ;
        [NSThread sleepForTimeInterval:((float)BOMB_SEC /ANTION_NUM)];
        
    } // for
    [self startbomb];}

- (void) startbomb{
    NSLog(@"BOMB!!") ;
}

@end
