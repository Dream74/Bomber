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
@synthesize canBomb   ;
@synthesize canPass   ;
@synthesize bombColor ;
@synthesize isKill ;

#define BOMB_ANTION_NUM 9
#define UNBOMB_ACTION   14
#define BOMB_SEC        1
#define UNBOMB_SEC      5

#define BOMB_IMG_SIZE   32

-(id)initWithLocation:(CGPoint) localPoint BOMB_COLOR:(int)bombcolor : (bool) CanBomb : (bool) CanPass {
    self = [super init] ;
    local = localPoint ;
    
    // Bombcolor index : 0 ==> Random Color
    bombColor = ( bombcolor == 0 ) ? random() % 9 + 1 : bombcolor ;
    
    canBomb   = CanBomb ;
    canPass   = CanPass ;
    isKill    = false   ;
    return self ;
}


+ (Bomb *) putBomb:(CGPoint)point :(int) bombColor : (bool) CanBomb : (bool) CanPass{
    Bomb * bomb = [[Bomb alloc] initWithLocation:point BOMB_COLOR:bombColor :CanBomb :CanPass ] ;
    [bomb start] ;
    return bomb ;
}

+ (Bomb *) putBomb:(int)x :(int)y :(int) bombColor : (bool) CanBomb : (bool) CanPass {
    return [[Bomb class] putBomb:CGPointMake(x, y) :bombColor :CanBomb :CanPass ] ;
}

-(void) draw{
    NSLog(@"Bomb State :%d", imgIndex) ;
    if ( !isKill) {
        assert( imgIndex < UNBOMB_ACTION ) ;
        [ [ [ bombImages objectAtIndex:0 ] objectAtIndex:imgIndex] drawAtPoint:local]  ;
    } else if ( isKill && imgIndex < BOMB_ANTION_NUM ) {
        assert( imgIndex < BOMB_ANTION_NUM ) ;
        assert( bombColor < BOMB_COLOR_LENGTH  ) ;
        [ [ [ bombImages objectAtIndex:bombColor ] objectAtIndex:imgIndex] drawAtPoint:local]  ;
        // ( bomb != 10 && imgIndex < 9 )
        // [ [ [ bombImages objectAtIndex:bomb ] objectAtIndex:imgIndex] drawAtPoint: local]  ;
    }
}

-(void) start{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

-(bool) isKill{
    return isKill ;
}

-(void) run{
    for (int i = 0 ; i < UNBOMB_ACTION ; i++) {
        imgIndex = i ;
        if ( i != ( UNBOMB_ACTION - 1 ) ) [NSThread sleepForTimeInterval:((float) UNBOMB_SEC/UNBOMB_ACTION)];
    } // for
    
    [self startbomb];
}

- (void) startbomb{
    isKill = true ;
    for ( int i = 0 ; i < BOMB_ANTION_NUM  ; i++ ) {
        imgIndex = i ;
        [NSThread sleepForTimeInterval:((float)BOMB_SEC /BOMB_ANTION_NUM)];
    } // for
    
    // 把圖片往前面推一個讓他消失
    // TODO 正常應該這邊要接 火焰的事情
    imgIndex++ ;
    
    
    NSLog(@"BOMB!!") ;
}

+(void) initialImage {
    
    
    bombImages = [[NSMutableArray alloc] init ];
    
    // 炸彈
    [ bombImages addObject: [[NSMutableArray alloc] init ] ];
    for ( int i = 0 ; i < UNBOMB_ACTION ; i++ ) {
        if ( i % 2 == 1 )
            [ [ bombImages objectAtIndex: 0 ] addObject:[[Kernel class] subImageRotate:[[Resource class] bomb_32x32_2] offsetWidth:0 offsetHeight:i*BOMB_IMG_SIZE imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE :0 :1.1]];
        else
            [ [ bombImages objectAtIndex: 0 ] addObject:[[Kernel class] subImageRotate:[[Resource class] bomb_32x32_2] offsetWidth:0 offsetHeight:i*BOMB_IMG_SIZE imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE :0 :1.0]];
    } // for

    
    // 炸彈消失圖片
    for ( int j = 1 ; j < BOMB_COLOR_LENGTH ; j++ ) {
        [ bombImages addObject: [[NSMutableArray alloc] init ] ];
        for ( int i = 0 ; i < BOMB_ANTION_NUM ; i++ ) {
            [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImage:[[Resource class] blast] offsetWidth:i*BOMB_IMG_SIZE offsetHeight:(j-1)*BOMB_IMG_SIZE imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE]];
        } // for
    } // for
    
    // add 火焰
    [ bombImages addObject: [[NSMutableArray alloc] init ] ];
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:0 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE]];
    // normal
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImage:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE]];
    // right
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE :0:1.0]] ;
    // top
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE :-90:1.0]] ;
    // left
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE :180:1.0]] ;
    // down
    [ [ bombImages objectAtIndex: 10 ] addObject:[[Kernel class] subImageRotate:[[Resource class] explosion ] offsetWidth:BOMB_IMG_SIZE * 2 offsetHeight:0 imgWidth:BOMB_IMG_SIZE imgHeight:BOMB_IMG_SIZE :90:1.0]] ;
}

@end
