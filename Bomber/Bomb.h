//
//  Bomb.h
//  Bomber
//
//  Created by dream on 11/20/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Box.h"

#define MAP_WIDTH_NUM 50
#define MAP_HIGHT_NUM 50

@protocol BombEvent <NSObject>

-(void) reflashMapData:(int)fireCloumn : (CGPoint) bombLoc ;

@end

@interface Bomb : Box {
@private
    int imgIndex ;
@public
    bool bombState ;
   
   
}


enum BOMB_COLOR{ RANDOM_BOMB_COLOR = 0,
                 RED , ORANGE, YEALLOW,
                 GREEN, AQUAMANINE, BLUE,
                 PURPLE, BLOCK, GRAY,
                 BOMB_COLOR_LENGTH } ;

enum FireDirect { NONE = 0, CENTER, HORIZON, VERTICAL };

// @property (nonatomic) int bomb    ;
@property (nonatomic) int  imgIndex  ;
@property (nonatomic) int  bombColor ;
@property (nonatomic) bool isKilling ;
@property (nonatomic) bool isKill    ;
@property (nonatomic) bool finish ;
@property (nonatomic) int  fireColumn ;
@property (nonatomic, strong ) id   <BombEvent> bombEvent ;


// TODO 新增炸彈時需要所在格子位置資訊 pixal loca由mapdata 計算可得


+ (Bomb *) putBomb:(CGPoint)point :(int) bombColor :(int) FireColumn ;


+ (void) initialImage ;
- (void) draw: (int)x : (int) y ;
- (bool) isKill;
- (void) fireBomb ;
- (void) setBombEvent:(id<BombEvent>)inBombEvent ;
+ ( void)  drawFire :(int) type :(int) x : (int)y ;

@end
