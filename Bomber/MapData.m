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
@synthesize originalImg;

int backgroud[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;
int objgroupd[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;

- (id) init{
    self = [super init] ;
    _local.x = 0 ;
    _local.y = 0 ;
    
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

- (void) draw {
    for( int i = 0 ; i < MAP_HIGHT_NUM ; i++ ){
        for (int j = 0 ; j < MAP_WIDTH_NUM ; j++ ) {
            [[groundImages objectAtIndex:backgroud[j][i]] drawAtPoint: CGPointMake(i*IMG_MAP_SIZE+_local.x,j*IMG_MAP_SIZE+_local.y)]  ;
        }
    }
}

@end
