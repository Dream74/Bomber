//
//  Square.m
//  Bomber
//
//  Created by luoboy on 13/11/22.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "Square.h"

@implementation Square

@synthesize x ;
@synthesize y ;
@synthesize pixal_x ;
@synthesize pixal_y ;
@synthesize pixal_x_max ;
@synthesize pixal_y_max ;

@synthesize exsitObj ;
@synthesize objList ;

@synthesize canIn ;

-(void) initalLacation: (int) X : (int) Y {
    x = X ;
    y = Y ;
    
    pixal_x = x * 32 ;
    pixal_y = y * 32 ;
    
    pixal_x_max = pixal_x + 32 ;
    pixal_y_max = pixal_y + 32 ;
    
    exsitObj = NOTHING ;
    
    objList = [[NSMutableArray alloc] init ] ;
    
    canIn = true ;
    
}

+(CGPoint) existWhichSquare : (int) X : (int) Y {
    int x = X / 32 ;
    int y = Y / 32 ;
    return CGPointMake(x, y) ;
}


-(void) putThingInSquare :(int) type PutObject : (id) obj {
    exsitObj = type ;
    [ objList addObject:obj ] ;
    if ( type <= PLAYER ) canIn = true ;
    else canIn = false ;
    
}

-(void) removeThingFromSquare {
    exsitObj = NOTHING ;
    objList = [[NSMutableArray alloc] init ] ;
    canIn = true ;
}




@end
