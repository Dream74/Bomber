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

static  NSMutableArray * bombImages;
@synthesize imgIndex  ;
@synthesize local     ;
@synthesize bombColor ;
@synthesize isKilling ;
@synthesize isKill    ;
@synthesize fireColumn ;
@synthesize bombEvent ;
@synthesize finish ;

#define BOMB_ANTION_NUM      9
#define UNBOMB_ACTION        14
#define BOMB_SEC             1
#define UNBOMB_SEC           5
#define BOMB_IMG_SIZE        32
#define BOMB_SHOW_BIG_SIZE   0.9
#define BOMB_SHOW_SMAIL_SIZE 0.8

+(void) initialImage {
    bombImages = [[NSMutableArray alloc] init ];
    // 炸彈
    [ bombImages addObject: [[NSMutableArray alloc] init ] ];
    for ( int i = 0 ; i < UNBOMB_ACTION ; i++ ) {
        if ( i % 2 == 1 )
            [ [ bombImages objectAtIndex: 0 ] addObject:[[Kernel class] subImage:[[Resource class] bomb_32x32_2] offsetWidth:4 offsetHeight:i*BOMB_IMG_SIZE +5 imgWidth:BOMB_IMG_SIZE - 4 imgHeight:BOMB_IMG_SIZE -5 imgScale:BOMB_SHOW_BIG_SIZE]];
        else
            [ [ bombImages objectAtIndex: 0 ] addObject:[[Kernel class] subImage:[[Resource class] bomb_32x32_2] offsetWidth:4 offsetHeight:i*BOMB_IMG_SIZE +5 imgWidth:BOMB_IMG_SIZE - 4 imgHeight:BOMB_IMG_SIZE -5 imgScale:BOMB_SHOW_SMAIL_SIZE]];
    } // for
    
    
    // 炸彈爆炸消失圖片
    for ( int j = 1 ; j < BOMB_COLOR_LENGTH ; j++ ) {
        [ bombImages addObject: [[NSMutableArray alloc] init ] ];
        for ( int i = 0 ; i < BOMB_ANTION_NUM ; i++ ) {
            [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImage:[[Resource class] blast] offsetWidth:i*BOMB_IMG_SIZE offsetHeight:(j-1)*BOMB_IMG_SIZE imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE]];
        } // for
    } // for
    
    // add 火焰
    [ bombImages addObject: [[NSMutableArray alloc] init ] ];
    // normal
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:0 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE]];
    
    // right
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE]];
    
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE imgTurn:UIImageOrientationLeft]];
    
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE imgTurn:UIImageOrientationUp   ]] ;
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE imgTurn:UIImageOrientationLeft ]] ;
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE imgTurn:UIImageOrientationDown ]] ;
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE imgTurn:UIImageOrientationRight]] ;
}



+ (Bomb *) putBomb:(CGPoint)point :(int) bombColor :(int) FireColumn  {
    Bomb * bomb = [[Bomb alloc] initWithLocation:point BOMB_COLOR:bombColor : FireColumn ] ;
    
    [bomb start] ;
    return bomb ;
}


-(id)initWithLocation:(CGPoint) localPoint BOMB_COLOR:(int)bombcolor : (int) FireColumn {
    self = [super init] ;
    local = localPoint ;
    
    // Bombcolor index : 0 ==> Random Color
    bombColor = ( bombcolor == 0 ) ? random() % 9 + 1 : bombcolor ;
    
    fireColumn = FireColumn ;
    isKilling = false   ;
    isKill    = false   ;
    finish = false ;
    return self ;
}


-(void) draw: (int)x : (int) y {
    
#ifdef DEBUG
    [[Kernel class] drawGrid:CGRectMake(x,
                                        y,
                                        BOMB_IMG_SIZE ,
                                        BOMB_IMG_SIZE)   lineWidth:2.0] ;
#endif
    
    if ( !isKilling) {
        assert( imgIndex < UNBOMB_ACTION ) ;
        [ [ [ bombImages objectAtIndex:0 ] objectAtIndex:imgIndex] drawAtPoint:CGPointMake(x, y)]  ;
    } else if ( isKilling && imgIndex < BOMB_ANTION_NUM ) {
        assert( imgIndex < BOMB_ANTION_NUM ) ;
        assert( bombColor < BOMB_COLOR_LENGTH  ) ;
        [ [ [ bombImages objectAtIndex:bombColor] objectAtIndex:imgIndex] drawAtPoint:CGPointMake(x, y)]  ;
    }
    
  
}

+(void) drawFire :(int) type :(int) x : (int)y {
    [ [ [ bombImages objectAtIndex:10] objectAtIndex:(type-1)] drawAtPoint:CGPointMake(x, y)]  ;
    
}

-(void) start{
    
    //[NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    [self performSelectorInBackground:@selector(run) withObject:nil];
    
    
}

-(bool) isKill{
    if ( isKill ) {
      isKill = false ;
      return isKill ;
    } // if
    
    else return isKill ;
}

-(void) run{
    
    for (int i = 0 ; i < UNBOMB_ACTION ; i++) {
        imgIndex = i ;
        if ( i != ( UNBOMB_ACTION - 1 ) ) [NSThread sleepForTimeInterval:((float) UNBOMB_SEC/UNBOMB_ACTION)];
    } // for
  
    [self startbomb];
    
    
}

- (void) startbomb{
    isKilling = true ;
    for ( int i = 0 ; i < BOMB_ANTION_NUM  ; i++ ) {
        imgIndex = i ;
        [NSThread sleepForTimeInterval:((float)BOMB_SEC /BOMB_ANTION_NUM)];
    } // for
    imgIndex = BOMB_ANTION_NUM ; // 使炸彈消失
    
    // 把圖片往前面推一個讓他消失
    
    // bombevent
    NSLog(@"BombEvent");
    
    [ self fireBomb ] ;
    
}



- ( void ) fireBomb { 
    isKill  = true ;
    
    [ bombEvent reflashMapData : fireColumn : local ] ;
   
}


- (void) setBombEvent:(id<BombEvent>)inBombEvent {
   
    bombEvent = inBombEvent ;
}





@end
