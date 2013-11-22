//
//  Block.h
//  Bomber
//
//  Created by Lin on 13/11/21.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

// #import <Foundation/Foundation.h>
#import "Box.h"

@interface Block : Box

enum Block_material{ Accelerate_left	= 0 , Accelerate_up , Accelerate_right , Accelerate_down , // 加速
            Ice ,  // 溜冰
            Soil_1 , Soil_2 , Soil_3 , Soil_4 , Soil_5 , Soil_6 , Soil_7 , Soil_8 ,
            Treasure_of_soil_1 , Treasure_of_soil_2 , // 埋藏寶箱
            Soil_9 , Soil_10 , Soil_11 , Soil_12 , Soil_13 , Soil_14 ,
            Marble_1 , Marble_2 ,  // 硬石頭
            Soil_15 , Soil_16 , Soil_17 , Soil_18 , Soil_19 , Soil_20 ,
            Marble_3 , Marble_4 ,
            Brick_1_1 , Brick_1_2 , Brick_1_3 , Brick_1_4 , Brick_1_5 , Brick_1_6 ,
            Iron ,
            Blank0 , // 這是空白的貼圖
            Brick_2_1 , Brick_2_2 ,
            Underbrush_1 , Underbrush_2 ,
            Crate , Wood , Cactus ,
            Blank1 , // 這是空白的貼圖
            Treasure_1 , Treasure_2 , Treasure_3 , Treasure_4 ,
            Blank2 , Blank3 , Blank4 , Blank5 // 這是空白的貼圖
          } ;


@property (nonatomic) CGPoint local ;
@property (nonatomic, strong) UIImage * originalImg;
@property (nonatomic, strong) NSMutableArray * blockImages;
-(void) draw:(int) block_material :(CGPoint) point;
-(void) draw : (int *) block_array : (int) total_length : (int) total_width ;




@end
