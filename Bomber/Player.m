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

static NSMutableArray * playerAllImages;

@synthesize local        ;
@synthesize state        ;
@synthesize speed        ;
@synthesize fire         ;
@synthesize bombNum      ;
@synthesize playerImages ;

#define PLAYER_SIZE        34
#define SPEED              3
#define SPEED_MAX          30
#define FIRE_MAX           9
#define BOMB_NUM           10

#define IMAGE_CHANGE_DELAY 8
#define ANTION_NUM         4

#define DEFAULT_SPEED      2
#define DEFAULT_FIR        2
#define DEFAULT_BOMBNUM    1


enum DIRECTION { TOP = 0, RIGHT, DOWN, LEFT,  DIRECTION_LENGTH } ;

- (id) initial : (int) chartype {
    
    local.x = 160 ;
    local.y = 200 ;
    state   = DOWN            ;
    speed   = DEFAULT_SPEED   ;
    fire    = DEFAULT_FIR     ;
    bombNum = DEFAULT_BOMBNUM ;
    
    playerImages = [playerAllImages objectAtIndex:chartype] ;

    
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


-(CGPoint) getLocalPoint{
    return local ;
}

-(void) doMove:(CGPoint) move{
    local.x += move.x * SPEED / 100;
    local.y += move.y * SPEED / 100;
    
    
    // 走到螢幕快出去會跳Error
    
    
    // local.x = MIN(MAX(local.x, 0 ), SCREEN_HIGHT - PLAYER_SIZE) ;
    // local.y = MIN(MAX(local.y, 0 ), SCREEN_WIDTH - PLAYER_SIZE) ;
    
    if      ( ABS(move.x) > ABS(move.y))   state = move.x >= 0 ? RIGHT : LEFT ;
    else if ( move.x != 0 && move.y != 0 ) state = move.y >= 0 ? DOWN  : TOP ;
    
}

-(void) setTurn:(CGPoint) move{
    if      ( ABS(move.x) > ABS(move.y))   state = move.x >= 0 ? RIGHT : LEFT ;
    else if ( move.x != 0 && move.y != 0 ) state = move.y >= 0 ? DOWN  : TOP ;
    
}

+(void) InitializeAllImage {
  playerAllImages = [[NSMutableArray alloc] init];
    
  [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < 4; i++) {
        [[playerAllImages objectAtIndex:FLY] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < 4 ; j++ ) {
            [[ [playerAllImages objectAtIndex:FLY] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] character_flying ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
  
    [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < 4; i++) {
        [[playerAllImages objectAtIndex:GOLD] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < 4 ; j++ ) {
            [[ [playerAllImages objectAtIndex:GOLD] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] character_gold ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
    
    [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < 4; i++) {
        [[playerAllImages objectAtIndex:CRAWLING] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < 4 ; j++ ) {
            [[ [playerAllImages objectAtIndex:CRAWLING] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] character_crawling ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
    
    [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < 4; i++) {
        [[playerAllImages objectAtIndex:MARIO_RPG] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < 4 ; j++ ) {
            [[ [playerAllImages objectAtIndex:MARIO_RPG] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] mario_rpg ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
    
    
    
}

@end
