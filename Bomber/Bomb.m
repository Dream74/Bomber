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

@synthesize bombImages;
@synthesize local;
@synthesize bomb ;
@synthesize imgIndex ;



#define BOMB_ANTION_NUM 9
#define UNBOMB_ACTION   14
#define BOMB_SEC        1
#define UNBOMB_SEC      5


-(id)initWithLocation:(CGPoint) localPoint BOMB_COLOR:(int)bombcolor{
    self = [super init] ;
    local = localPoint ;
    bomb = bombcolor ;
    
    bombImages = [[NSMutableArray alloc] init ];
    for ( int j = 0 ; j < 10 ; j++ ) {
        [ bombImages addObject: [[NSMutableArray alloc] init ] ];
        if ( j == 0 ) {
            for ( int i = 0 ; i < 14 ; i++ ) {
              if ( i % 2 == 1 )
                [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImageRotate:[[Resource class] bomb_32x32_2] offsetWidth:0 offsetHeight:i*32 imgWidth:32 imgHeight:32 :0 :1.1]];
              else
                [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImageRotate:[[Resource class] bomb_32x32_2] offsetWidth:0 offsetHeight:i*32 imgWidth:32 imgHeight:32 :0 :1.0]];
            } // for
        } // if
        
        else {
            for ( int i = 0 ; i < 9 ; i++ ) {
                [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImage:[[Resource class] blast] offsetWidth:i*32 offsetHeight:(j-1)*32 imgWidth:32 imgHeight:32]];
            } // for
        } // else
    } // for
    
    // add 火焰
    [ bombImages addObject: [[NSMutableArray alloc] init ] ];
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:0 offsetHeight:0 imgWidth:32 imgHeight:32]];
    // normal
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:32 offsetHeight:0 imgWidth:32 imgHeight:32]];
    // right
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:64 offsetHeight:0 imgWidth:32 imgHeight:32 :0:1.0]] ;
    // top
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:64 offsetHeight:0 imgWidth:32 imgHeight:32 :-90:1.0]] ;
    // left
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:64 offsetHeight:0 imgWidth:32 imgHeight:32 :180:1.0]] ;
    // down
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:64 offsetHeight:0 imgWidth:32 imgHeight:32 :90:1.0]] ;

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
    if ( bomb == UNBOMB && imgIndex < 14 )
        [ [ [ bombImages objectAtIndex:bomb ] objectAtIndex:imgIndex] drawAtPoint: local]  ;
    else if ( bomb != 10 && imgIndex < 9 )
        [ [ [ bombImages objectAtIndex:bomb ] objectAtIndex:imgIndex] drawAtPoint: local]  ;
}

-(void) start{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

-(void) run{
    for (int i = 0 ; i < ( UNBOMB_ACTION + 1 ); i++) {
        imgIndex = i ;
        if ( i != 14 ) [NSThread sleepForTimeInterval:((float) UNBOMB_SEC/UNBOMB_ACTION)];
    } // for
    
    if ( bomb == 0 ) bomb = random() % 9 + 1;
    
    for ( int i = 0 ; i < ( BOMB_ANTION_NUM + 1 ) ; i++ ) {
        imgIndex = i ;
        [NSThread sleepForTimeInterval:((float)BOMB_SEC /BOMB_ANTION_NUM)];
        
    } // for
    
    [self startbomb];
}

- (void) startbomb{
    NSLog(@"BOMB!!") ;
}

@end
