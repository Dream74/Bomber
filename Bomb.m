//
//  Bomb.m
//  Bomber
//
//  Created by dream on 11/20/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Bomb.h"
#import "Kernel.h"

@implementation Bomb
@synthesize originalImg;
@synthesize bombImages;

#define ANTION_NUM 9
#define BOMB_SEC   3

enum BOMB_COLOR{ RED = 0, ORANGE, YEALLOW, GREEN, AQUAMANINE, BLUE, PURPLE, BLOCK, GRAY,LENGTH} ;
int state ;
-(id)init{
    self = [super init] ;
    originalImg = [UIImage imageNamed:@"blast.png"] ;
    
    bombImages = [[NSMutableArray alloc] init ];
    for ( int j = 0 ; j < 9 ; j++ ) {
        [ bombImages addObject: [[NSMutableArray alloc] init ] ];
        for ( int i = 0 ; i < 9 ; i++ ) {
            [ [ bombImages objectAtIndex: j ] addObject:[[Kernel class] subImage:originalImg offsetWidth:i*32 offsetHeight:j*32 imgWidth:32 imgHeight:32]];
        } // for
    } // for
    return self ;
}
@end
