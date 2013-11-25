//
//  Bomb.h
//  Bomber
//
//  Created by dream on 11/20/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Box.h"

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

// @property (nonatomic) int bomb    ;
@property (nonatomic) int  imgIndex  ;
@property (nonatomic) int  bombColor ;
@property (nonatomic) bool isKilling ;
@property (nonatomic) bool isKill    ;

// TODO 新增炸彈時需要所在格子位置資訊 pixal loca由mapdata 計算可得


+ (Bomb *) putBomb:(CGPoint)point :(int) bombColor : (bool) CanBomb : (bool) CanPass ;


+ (void) initialImage ;
- (void) draw: (int)x : (int) y ;
- (bool) isKill;
@end
