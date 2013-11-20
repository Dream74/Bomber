//
//  Bomb.h
//  Bomber
//
//  Created by dream on 11/20/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Box.h"

@interface Bomb : Box

enum BOMB_COLOR{ RED = 0, ORANGE, YEALLOW, GREEN, AQUAMANINE, BLUE, PURPLE, BLOCK, GRAY, LENGTH} ;

@property (nonatomic) CGPoint local ;
@property (nonatomic, strong) UIImage * originalImg;
@property (nonatomic, strong) NSMutableArray * bombImages;
@property (nonatomic) int color    ;
@property (nonatomic) int imgIndex ;
+ (Bomb *) putBomb:(CGPoint)point :(int) bombColor;
+ (Bomb *) putBomb:(int)x :(int)y :(int) bombColor;
- (void) draw ;
@end
