//
//  Block.h
//  Bomber
//
//  Created by Lin on 13/11/21.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

// #import <Foundation/Foundation.h>
#import "Box.h"

#define BLOCK_METERIAL_SIZE 32

@interface Block : Box


enum BLOCK_METERIAL { ACCLERATE_LEFT = 0, ACCELERATE_UP, ACCLERATE_RIGHT, ACCELERATE_DOWN,   // 加速
                      ICE,                                                                   // 溜冰
                      SOIL1, SOIL2, SOIL3, SOIL4, SOIL5, SOIL6, SOIL7, SOIL8,
                      TREASURE_OF_SOIL1, TREASIRE_OF_SOIL2,                                  // 埋藏寶箱
                      SOIL9, SOIL10, SOIL11, SOIL12, SOIL_13, SOIL14,
                      MARBLE1, MARBLE2,                                                      // 這是空白的貼圖
                      BRICK_1_1, BRICK_1_2, BRICK_1_3, BRICK_1_4, BRICK_1_5, BRICK_1_6,
                      IRON,
                      BLANK0,                                                                // 這是空白的貼圖
                      BRICK_2_1, BRICK_2_2,
                      UNDERBRUSH1, UNDERBRUSH2,
                      CRATE, WOOD, CACTUS,
                      BLANK1,                                                                // 這是空白的貼圖
                      TREASURE1, TREASURE2, TREASURE3, TREASURE4,
                      BLANK2, BLANK3, BLANK4, BLANK5,
                      BLOCK_METERIAL_LENGTH } ;                                     // 這是空白的貼圖

@property (nonatomic) CGPoint local ;
@property (nonatomic, strong) UIImage * originalImg;
@property (nonatomic, strong) NSMutableArray * blockImages;
+(void) draw:(int)block_material imgPoint:(CGPoint)point                ;
+(void) draw:(int)block_material offsetX:(int)x offsetY:(int)y           ;
// +(void) draw:(int *)block_array :(int)total_length :(int)total_width ;




@end
