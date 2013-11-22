//
//  Player.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Player.h"
#import "Kernel.h"
#import "Bomb.h"

@implementation Player

static NSMutableArray * playerAllImages;

@synthesize local        ;
@synthesize state        ;
@synthesize speed        ;
@synthesize fire         ;
@synthesize bombNum      ;
@synthesize playerImages ;
@synthesize bombCollect  ;

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

- (id)initial :(int)chartype startPoint:(CGPoint) localPoint {
    local.x = localPoint.x ;
    local.y = localPoint.y ;
    state   = DOWN            ;
    speed   = DEFAULT_SPEED   ;
    fire    = DEFAULT_FIR     ;
    bombNum = DEFAULT_BOMBNUM ;
    
    bombCollect = [[NSMutableArray alloc] init];
    playerImages = [playerAllImages objectAtIndex:chartype] ;
    return self ;
}

- (void) draw {
    static int count  = 0 ;
    count = count >= ( ANTION_NUM * IMAGE_CHANGE_DELAY - 1 ) ? 0 : count + 1 ;
    int imgIndex = count / IMAGE_CHANGE_DELAY ;
    
    assert( imgIndex < ANTION_NUM ) ;
    [self drawBomb];
    
    [ [ [ playerImages objectAtIndex:imgIndex ] objectAtIndex:state] drawAtPoint: local] ;
}

-(CGPoint) getLocalPoint{
    return local ;
}

-(void) drawBomb{
    for( int i = 0 ; i < [bombCollect count] ; i++ ){
        Bomb * bomb = [bombCollect objectAtIndex:i] ;
        if ( [bomb isKill] ) [bombCollect removeObject:bomb] ;
        else                 [bomb draw] ;
    }
}

- (void) putBomb{
    // FIXME 記得炸彈爆炸後要移出這邊把它銷燬
    const int x = ((int) local.x+16) /32 * 32 ;
    const int y = ((int) local.y+28) /32 * 32 ;
#ifdef DEBUG
    NSLog(@"%d, %d %d, %d", (x/32), (y/32),((int)local.x+16)/32,((int) local.y+28)/32) ;
#endif
    [bombCollect addObject:[[Bomb class] putBomb:x  :y :RANDOM_BOMB_COLOR :false :false]];
    NSLog(@"Put Bomb!!") ;
}

- (void) doMove:(CGPoint) move{
    local.x += move.x * SPEED / 100;
    local.y += move.y * SPEED / 100;
    if      ( ABS(move.x) > ABS(move.y))   state = move.x >= 0 ? RIGHT : LEFT ;
    else if ( move.x != 0 && move.y != 0 ) state = move.y >= 0 ? DOWN  : TOP ;
}

- (void) setTurn:(CGPoint) move{
    if      ( ABS(move.x) > ABS(move.y))   state = move.x >= 0 ? RIGHT : LEFT ;
    else if ( move.x != 0 && move.y != 0 ) state = move.y >= 0 ? DOWN  : TOP  ;
}

+ (void) initializeAllImage {
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
