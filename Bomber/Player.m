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
#import "MapData.h"

@implementation Player

static NSMutableArray * playerAllImages;

@synthesize local        ;
@synthesize state        ;
@synthesize speed        ;
@synthesize fire         ;
@synthesize bombNum      ;

@synthesize playerImages ;
@synthesize imgIndex_count      ;
@synthesize dataLoc ;

#define PLAYER_SIZE        34
#define SPEED_MAX          30
#define FIRE_MAX           2
#define BOMB_NUM           10

#define IMAGE_CHANGE_DELAY 8
#define ANTION_NUM         4

#define DEFAULT_SPEED      2
#define DEFAULT_FIR        2
#define DEFAULT_BOMBNUM    3


enum DIRECTION { TOP = 0, RIGHT, DOWN, LEFT,  DIRECTION_LENGTH } ;


+ (void) initializeAllImage {
    playerAllImages = [[NSMutableArray alloc] init];
    
    [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < ANTION_NUM; i++) {
        [[playerAllImages objectAtIndex:FLY] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < ANTION_NUM ; j++ ) {
            [[ [playerAllImages objectAtIndex:FLY] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] character_flying ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
    
    [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < ANTION_NUM; i++) {
        [[playerAllImages objectAtIndex:GOLD] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < ANTION_NUM; j++ ) {
            [[ [playerAllImages objectAtIndex:GOLD] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] character_gold ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
    
    [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < ANTION_NUM; i++) {
        [[playerAllImages objectAtIndex:CRAWLING] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < ANTION_NUM; j++ ) {
            [[ [playerAllImages objectAtIndex:CRAWLING] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] character_crawling ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
    
    [playerAllImages addObject: [[NSMutableArray alloc] init ] ];
    for (int i = 0; i < ANTION_NUM; i++) {
        [[playerAllImages objectAtIndex:MARIO_RPG] addObject: [[NSMutableArray alloc] init ] ];
        for( int j = 0 ; j < ANTION_NUM ; j++ ) {
            [[ [playerAllImages objectAtIndex:MARIO_RPG] objectAtIndex: i ] addObject:[[Kernel class] subImage:[[Resource class] mario_rpg ] offsetWidth:i*PLAYER_SIZE offsetHeight:j*PLAYER_SIZE imgWidth:PLAYER_SIZE imgHeight:PLAYER_SIZE]];
        } // for
    } // for
}

- (id)initial :(int)chartype startPoint:(CGPoint) localPoint {
    local.x = localPoint.x ;
    local.y = localPoint.y ;
    state   = DOWN            ;
    speed   = DEFAULT_SPEED   ;
    fire    = DEFAULT_FIR     ;
    bombNum = DEFAULT_BOMBNUM ;
    
    playerImages = [playerAllImages objectAtIndex:chartype] ;
    return self ;
}

- (void) draw {
    // static int count  = 0 ;
    // 改成用   ----imgIndex_count---- 替代
    
    int imgIndex = imgIndex_count / IMAGE_CHANGE_DELAY ;

    
    assert( imgIndex < ANTION_NUM ) ;
#ifdef DEBUG
    [[Kernel class] drawGrid:CGRectMake(local.x,
                                        local.y,
                                        PLAYER_SIZE ,
                                        PLAYER_SIZE)   lineWidth:1.0] ;
#endif
    [ [ [ playerImages objectAtIndex:imgIndex ] objectAtIndex:state] drawAtPoint: local] ;
}

-(CGPoint) getLocalPoint{
    return local ;
}


- (bool) isHaveBomb{
    return bombNum > 0 ;
}

- (bool) putBomb{
    if ( bombNum > 0 ){
        bombNum-- ;
        assert( bombNum >= 0 ) ;
        return true ;
    } else {
        return false ;
    }
}

-(void) addBombNum{
    bombNum++;
}

- (void) removeBomb{
    // FIMEX 為什麼這邊也是 bombNum++ ???
    bombNum++ ;
    assert( bombNum < BOMB_NUM ) ;
}

- (void) doMove:(CGPoint) move{
    local.x += move.x ;
    local.y += move.y ;
    
    imgIndex_count = imgIndex_count >= ( ANTION_NUM * IMAGE_CHANGE_DELAY - 1 ) ? 0 : imgIndex_count + 1 ;
    
}

/* setTurn : 根據要移動的方向改變角色的圖片方向
 
 * move    : 要移動的方向
 */
- (void) setTurn:(CGPoint) move{
    if      ( fabsf(move.x) > fabsf(move.y) ) state = move.x >= 0 ? RIGHT : LEFT ;
    else if ( move.x != 0 && move.y != 0    ) state = move.y >= 0 ? DOWN  : TOP  ;
}

-(void) resetLocation : (CGPoint) localPoint {
    dataLoc = localPoint ;
    state   = DOWN ;
}



@end
