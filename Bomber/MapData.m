//
//  MapData.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "MapData.h"
#import "Kernel.h"

@implementation MapData

static NSMutableArray * groundImages;
@synthesize offsetPoint  ;
@synthesize screenPoint  ;
@synthesize mapPoint     ;

#define SPEED 3

int backGround[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;
int objGround[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;


- (MapData *) initWithPoint:(CGPoint) startMapPoint startScreen:(CGPoint)startScreenPoint{
    self = [super init] ;
    offsetPoint.x = IMG_MAP_SIZE * -1 ;
    offsetPoint.y = IMG_MAP_SIZE * -1 ;
    mapPoint.x = startMapPoint.x ;
    mapPoint.y = startMapPoint.y ;
    screenPoint.x = startScreenPoint.x ;
    screenPoint.y = startScreenPoint.y ;
    
    NSLog(@"MAP_HIGHT_NUM :%d   MAP_WIDTH_NUM:%d", MAP_HIGHT_NUM , MAP_WIDTH_NUM ) ;  
    return self ;
}


- (void) doMove:(CGPoint) move{
    offsetPoint.x -= move.x * SPEED / 100;
    offsetPoint.y -= move.y * SPEED / 100;
}

- (void) draw {
    // NSString * text = [NSString stringWithFormat:@"%f,%f", mapPoint.x, mapPoint.y ] ;
    // [[Kernel class] drawText:text offsetWidth:screenPoint.x offsetHeight:screenPoint.y textSize:10] ;
    
    for( int i = 0 ; i < SCREEN_HIGHT_NUM ; i++ ){
        for (int j = 0 ; j < SCREEN_WIDTH_NUM ; j++ ) {
            /* to draw map idea!!! center start
             1. 資料結構 抓到中間那格的地層陣列的位置 //  example : (5,3)
             2. 取得該格 之 背景地圖 繪製於  視窗內的中心 pixal 點, 可由 解析度除以２ 取得
             3. 之後在 取得 ( 4,3) 將中心pixal 減 32 不斷畫到超越 邊框 為止 , 上下左右依此類推
             完成地圖
             */
            
            // [[Block class] draw:(i%BLOCK_METERIAL_LENGTH) offsetX:i*BLOCK_METERIAL_SIZE offsetY:j*BLOCK_METERIAL_SIZE  ] ;
            
            // [[groundImages objectAtIndex:backgroud[j][i]] drawAtPoint: CGPointMake(i*IMG_MAP_SIZE+offsetPoint.x,j*IMG_MAP_SIZE+offsetPoint.y)]  ;
            // NSString * text = [NSString stringWithFormat:@"%d,%d", i, j ] ;
            // [[Kernel class] drawText:text offsetWidth:(i+1)*IMG_MAP_SIZE+offsetPoint.x offsetHeight:(j+1)*IMG_MAP_SIZE+offsetPoint.y textSize:10] ;
        }
    }
}

+ (void) initialImage {
    groundImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 8 ; i++) {
        [groundImages addObject:[[Kernel class] subImage:[[Resource class] tileset_12_31 ] offsetWidth:i*IMG_MAP_OFFSET_WIDTH offsetHeight:0 imgWidth:IMG_MAP_SIZE imgHeight:IMG_MAP_SIZE]];
    } // for
    
    for ( int i = 0 ; i < 5 ; i++ ) {
        [groundImages addObject:[[Kernel class] subImage:[[Resource class] tileset_12_31 ] offsetWidth:i*IMG_MAP_OFFSET_WIDTH offsetHeight:IMG_MAP_OFFSET_HIGHT imgWidth:IMG_MAP_SIZE imgHeight:IMG_MAP_SIZE]];
    } // for
    
    for( int i = 0; i < MAP_WIDTH_NUM ; i++){
        for (int j = 0; j < MAP_HIGHT_NUM; j++) {
            backGround[j][i] = arc4random() % 13 ;
        }
    }
    
    for( int i = 0; i < MAP_WIDTH_NUM ; i++){
        for (int j = 0; j < MAP_HIGHT_NUM; j++) {
            objGround[j][i] = arc4random() % 2 ;
        }
    }

}

@end
