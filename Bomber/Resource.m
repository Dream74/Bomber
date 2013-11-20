//
//  Resource.m
//  Bomber
//
//  Created by luoboy on 13/11/21.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "Resource.h"

@implementation Resource

@synthesize bomb_32x32_2 ;
@synthesize blast ;
@synthesize character_crawling ;
@synthesize character_flying ;
@synthesize character_gold ;
@synthesize character_jetpack ;
@synthesize character_silver ;
@synthesize explosion ;
@synthesize items ;
@synthesize perks ;
@synthesize tileset ;
@synthesize tileset_12_31 ;

-(void) InitalResource {
    
    bomb_32x32_2 = [UIImage imageNamed:@"bomb_32x32_2.png"] ;
    blast = [UIImage imageNamed:@"blast.png"] ;
    character_crawling = [UIImage imageNamed:@"character_crawling.png"] ;
    character_flying = [UIImage imageNamed:@"character_flying.png"] ;
    character_gold = [UIImage imageNamed:@"character_gold.png"] ;
    character_jetpack = [UIImage imageNamed:@"character_jetpack .png"] ;
    character_silver = [UIImage imageNamed:@"character_silver.png"] ;
    explosion = [UIImage imageNamed:@"explosion.png"] ;
    items = [UIImage imageNamed:@"items.png"] ;
    perks = [UIImage imageNamed:@"perks.png"] ;
    tileset = [UIImage imageNamed:@"tileset.png"] ;
    tileset_12_31 = [UIImage imageNamed:@"tileset_12_31.png"] ;
    
    // TODO
    
    // new istance, inital resource , at kernal
   
}

@end
