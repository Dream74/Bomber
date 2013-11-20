//
//  Player.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Player.h"
#import "Kernel.h"

@implementation Player
@synthesize originalImg  ;
@synthesize playerImages ;
@synthesize local        ;
@synthesize state        ;
@synthesize speed        ;
@synthesize fire         ;
@synthesize bombNum      ;

#define PLAYER_SIZE        34
#define SPEED              3
#define SPEED_MAX          30
#define FIRE_MAX           9
#define BOMB_NUM           10

#define IMAGE_CHANGE_DELAY 8
#define ANTION_NUM         4

#define DEFAULT_SPEED   2
#define DEFAULT_FIR     2
#define DEFAULT_BOMBNUM 1


enum DIRECTION { TOP = 0, RIGHT, DOWN, LEFT,  LENGTH } ;

- (id) init{
    self = [super init] ;    
    local.x = 160 ;
    local.y = 200 ;
    state   = DOWN            ;
    speed   = DEFAULT_SPEED   ;
    fire    = DEFAULT_FIR     ;
    bombNum = DEFAULT_BOMBNUM ;
    
    originalImg = [UIImage imageNamed:@"character_flying.png"] ;
    
    playerImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; i++) {
        [playerImages addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < 4 ; j++ ) {
            [[ playerImages objectAtIndex: i ] addObject:[[Kernel class] subImage:originalImg offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
    
    
    return self ;
}

-(void) draw {
    static int count  = 0 ;
    count = count >= ( ANTION_NUM * IMAGE_CHANGE_DELAY - 1 ) ? 0 : count + 1 ;
    int imgIndex = count / IMAGE_CHANGE_DELAY ;
    
#ifdef DEBUG
    assert( imgIndex < ANTION_NUM ) ;
#endif
    
    [ [ [ playerImages objectAtIndex:imgIndex ] objectAtIndex:state] drawAtPoint: local] ;
}

-(void) doMove:(CGPoint) move{
    local.x += move.x * SPEED / 100;
    local.y += move.y * SPEED / 100;
    
    local.x = MIN(MAX(local.x, 0 ), SCREEN_HIGHT - PLAYER_SIZE) ;
    local.y = MIN(MAX(local.y, 0 ), SCREEN_WIDTH - PLAYER_SIZE) ;
    
    if      ( ABS(move.x) > ABS(move.y))   state = move.x >= 0 ? RIGHT : LEFT ;
    else if ( move.x != 0 && move.y != 0 ) state = move.y >= 0 ? DOWN  : TOP ;
    
}

@end
