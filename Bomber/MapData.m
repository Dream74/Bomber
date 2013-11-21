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
@synthesize groundImages;
@synthesize originalImg ;
@synthesize offsetPoint  ;

int backgroud[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;
int objgroupd[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;

- (id) init{
    self = [super init] ;
    offsetPoint.x = IMG_MAP_SIZE * -1 ;
    offsetPoint.y = IMG_MAP_SIZE * -1 ;
    
    NSLog(@"MAP_HIGHT_NUM :%d   MAP_WIDTH_NUM:%d", MAP_HIGHT_NUM , MAP_WIDTH_NUM ) ;
    
    originalImg = [UIImage imageNamed:@"tileset_12_31.png"] ;
    groundImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 8; i++) {
        [groundImages addObject:[[Kernel class] subImage:originalImg offsetWidth:i*IMG_MAP_OFFSET_WIDTH offsetHeight:0 imgWidth:IMG_MAP_SIZE imgHeight:IMG_MAP_SIZE]];
    } // for
    
    for ( int i = 0 ; i < 5 ; i++ ) {
        [groundImages addObject:[[Kernel class] subImage:originalImg offsetWidth:i*IMG_MAP_OFFSET_WIDTH offsetHeight:IMG_MAP_OFFSET_HIGHT imgWidth:IMG_MAP_SIZE imgHeight:IMG_MAP_SIZE]];
    } // for

    for( int i = 0; i < MAP_WIDTH_NUM ; i++){
        for (int j = 0; j < MAP_HIGHT_NUM; j++) {
            backgroud[j][i] = arc4random() % 13 ;
        }
    }
    
    for( int i = 0; i < MAP_WIDTH_NUM ; i++){
        for (int j = 0; j < MAP_HIGHT_NUM; j++) {
            objgroupd[j][i] = arc4random() % 2 ;
        }
    }
    
    return self ;
}


-(void) doMove:(CGPoint) move{
    NSLog(@"MAP Start offsetMove X:%f Y:%f", offsetPoint.x, offsetPoint.y ) ;
    offsetPoint = CGPointMake( offsetPoint.x - move.x , offsetPoint.y - move.y  );
    NSLog(@"MAP END offsetMove X:%f Y:%f", offsetPoint.x, offsetPoint.y ) ;
}

- (void) draw {
    for( int i = 0 ; i < MAP_HIGHT_NUM ; i++ ){
        for (int j = 0 ; j < MAP_WIDTH_NUM ; j++ ) {
            // [[groundImages objectAtIndex:backgroud[j][i]] drawAtPoint: CGPointMake(i*IMG_MAP_SIZE+_local.x,j*IMG_MAP_SIZE+_local.y)]  ;
            NSString * text = [NSString stringWithFormat:@"%d,%d", i, j ] ;
            [[Kernel class] drawText:text offsetWidth:i*IMG_MAP_SIZE+offsetPoint.x offsetHeight:j*IMG_MAP_SIZE+offsetPoint.y textSize:10] ;
        }
    }
}

@end
