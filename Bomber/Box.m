//
//  Box.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Box.h"

@implementation Box

@synthesize DataLoca ;
@synthesize local ;
@synthesize canBomb ;
@synthesize canPass ;



-(void) initalLocation : (CGPoint) local  :(bool) CanBomb : (bool) CanPass ; {
    
    canBomb = CanBomb ;
    canPass = CanPass ;
 
}


@end
