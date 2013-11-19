//
//  MapData.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "MapData.h"
#import "Kernel.h"
#import "Bomber.h"

@implementation MapData
@synthesize groundImages;
@synthesize originalImg;

#define MAP_WIDTH_NUM IPATHON_WIDTH / MAP_SIZE
#define MAP_HIGHT_NUM IPAD_HIGHT / MAP_SIZE



int backgroud[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;

//  bomb, box
int objgroupd[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;

- (id) init{
    self = [super init] ;
    _local.x = 0 ;
    _local.y = 0 ;
    
    originalImg = [UIImage imageNamed:@"tileset_12_31.png"] ;
    groundImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 8; i++) {
        [groundImages addObject:[[Kernel class] subImage:originalImg offsetWidth:i*32 offsetHeight:0 imgWidth:32 imgHeight:32]];
    } // for
    
    for ( int i = 0 ; i < 5 ; i++ ) {
        [groundImages addObject:[[Kernel class] subImage:originalImg offsetWidth:i*32 offsetHeight:38 imgWidth:32 imgHeight:32]];
    } // for


    return self ;
}

- (void) draw {
    for( int i = 0 ; i < MAP_HIGHT_NUM ; i++ ){
        for (int j = 0 ; j < MAP_WIDTH_NUM ; j++ ) {
            [[groundImages objectAtIndex:arc4random() % 13] drawAtPoint: CGPointMake(i*32+_local.x,j*32+_local.y)]  ;
        }
    }
}

@end
