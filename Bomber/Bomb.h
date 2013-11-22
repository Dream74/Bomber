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
@property (nonatomic) bool isKill    ;

+ (Bomb *) putBomb:(CGPoint)point :(int) bombColor : (bool) CanBomb : (bool) CanPass ;
+ (Bomb *) putBomb:(int)x :(int)y :(int) bombColor : (bool) CanBomb : (bool) CanPass ;
+ (void) initialImage ;

- (void) draw ;
- (bool) isKill;
@end
