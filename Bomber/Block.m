//
//  Block.m
//  Bomber
//
//  Created by Lin on 13/11/21.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "Block.h"
#import "Kernel.h"

@implementation Block


@synthesize originalImg;

@synthesize blockImages;


#define side_length 32


-(id) init{
    self = [super init] ;

    
    
    originalImg = [UIImage imageNamed:@"tileset.png"] ;
    
    blockImages = [[NSMutableArray alloc] init];
    
    
    for( int i = 0 ; i < 4 ; i++ ){
        [ blockImages addObject:[[Kernel class] subImage:originalImg offsetWidth:(4+i)*side_length offsetHeight:5*side_length imgWidth:side_length imgHeight:side_length]];
    } // for...截取加速板塊

    
    [ blockImages addObject:[[Kernel class] subImage:originalImg offsetWidth:3*side_length offsetHeight:6*side_length imgWidth:side_length imgHeight:side_length]];
     // 截取冰
    
    
    for( int i = 0 ; i < 7 ; i++ ){
        for( int j = 0 ; j < 8 ; j++ ){
            [ blockImages addObject:[[Kernel class] subImage:originalImg offsetWidth:j*side_length offsetHeight:(8+i)*side_length imgWidth:side_length imgHeight:side_length]];
        } // for...
        
    } // for...
     
    
    // [ blockImages addObject:[[Kernel class] subImage:originalImg offsetWidth:0 offsetHeight:8*32 imgWidth:32 imgHeight:32]];
   
    
     // NSLog(@"------------%d--------------" , [blockImages count] ) ;
    
    
    return self;
}



-(void) draw:(int) block_material :(CGPoint) point {
    
    
    [[blockImages objectAtIndex:block_material] drawAtPoint: point];
    
    
    
    
    // [blockImages count]
    // [[blockImages objectAtIndex:i+j] drawAtPoint: CGPointMake(i*32,j*32)];
    
    /*
    int print_num = 0;
    
    for( int i = 0; i < 8 && print_num < [blockImages count] ; i++ ) {
        
        for( int j = 0; j < 8 && print_num < [blockImages count] ; j++ ){
            
            
            [[blockImages objectAtIndex:print_num] drawAtPoint: CGPointMake(j*32,i*32)];
            print_num++;
            
        } // for...
        
        
    } // for...

    
    測試整張圖有沒有讀近來用的
     */
}



-(void) draw : (int *) block_array : (int) total_length : (int) total_width  {
    
    for( int i = 0 ; i < total_length ; i++ ){
        
        for( int j = 0 ; j < total_width ; j++ ){
            
            // int x = block_array[i][j];
            
            // [ one_block draw : 0 : CGPointMake(3*32, 3*32) ];
            [self draw : *block_array : CGPointMake( i*side_length, j*side_length) ];
            block_array++;
            
        } //
        
        
    } //
    

}



@end


