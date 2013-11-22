//
//  Block.m
//  Bomber
//
//  Created by Lin on 13/11/21.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "Block.h"
#import "Kernel.h"
#import "Resource.h"

@implementation Block


@synthesize originalImg;
@synthesize blockImages;

static NSMutableArray * blockImages;


-(id) init{
    self = [super init] ;
    return self;
}

+ (void) initializeAllImage {
    blockImages = [[NSMutableArray alloc] init];
    
    for( int i = 0 ; i < 4 ; i++ ) {
        [blockImages addObject:[[Kernel class] subImage:[[Resource class] tileset] offsetWidth:(4+i)*BLOCK_METERIAL_SIZE offsetHeight:5*BLOCK_METERIAL_SIZE imgWidth:BLOCK_METERIAL_SIZE imgHeight:BLOCK_METERIAL_SIZE]];
    } // for...截取加速板塊
    
    [ blockImages addObject:[[Kernel class] subImage:[[Resource class] tileset]  offsetWidth:3*BLOCK_METERIAL_SIZE offsetHeight:6*BLOCK_METERIAL_SIZE imgWidth:BLOCK_METERIAL_SIZE imgHeight:BLOCK_METERIAL_SIZE]];
    // 截取冰
    
    for( int i = 0 ; i < 7 ; i++ ) {
        for( int j = 0 ; j < 8 ; j++ ) {
            [ blockImages addObject:[[Kernel class] subImage:[[Resource class] tileset]  offsetWidth:j*BLOCK_METERIAL_SIZE offsetHeight:(8+i)*BLOCK_METERIAL_SIZE imgWidth:BLOCK_METERIAL_SIZE imgHeight:BLOCK_METERIAL_SIZE]];
        } // for...        
    } // for...
}


+(void) draw:(int) block_material imgPoint:(CGPoint) point {
    [[blockImages objectAtIndex:block_material] drawAtPoint: point];
}

+(void) draw:(int) block_material offsetX:(int)x offsetY:(int)y {
    [[Block class] draw:block_material imgPoint:CGPointMake(x,y)] ;
}

+(void) draw:(int *) block_array : (int) total_length : (int) total_width  {
    for( int i = 0 ; i < total_length ; i++ ){
        for( int j = 0 ; j < total_width ; j++ ){
            // [ one_block draw : 0 : CGPointMake(3*32, 3*32) ];
            [[Block class] draw:*block_array imgPoint:CGPointMake( i*BLOCK_METERIAL_SIZE, j*BLOCK_METERIAL_SIZE) ];
            block_array++;
        } //
    } //
}

@end


