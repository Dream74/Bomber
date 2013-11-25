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
    
    pixal_x = x * IMG_MAP_SIZE  ;
    pixal_y = y * IMG_MAP_SIZE  ;
    
    pixal_x_max = pixal_x + IMG_MAP_SIZE ;
    pixal_y_max = pixal_y + IMG_MAP_SIZE  ;
    
    exsitObj = NOTHING ;
    
    objList = [[NSMutableArray alloc] init ] ;
    
    canIn = true ;
    
}

+(CGPoint) existWhichSquare : (int) X : (int) Y {
    int x = X / IMG_MAP_SIZE ;
    int y = Y / IMG_MAP_SIZE  ;
    return CGPointMake(x, y) ;
}


-(void) putThingInSquare :(int) type PutObject : (id) obj {
    exsitObj = type ;
    [ objList addObject:obj ] ;
    if ( type <= PLAYER ) canIn = true ;
    else canIn = false ;
    
}

-(void) removeThingFromSquare {
    // TODO Obj need to release from here ;
    // Include ( bomb , item, brick )
    
    exsitObj = NOTHING ;
    objList = [[NSMutableArray alloc] init ] ;
    canIn = true ;
}





@end
