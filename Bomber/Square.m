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
@synthesize playerList ;

@synthesize canIn ;
@synthesize delegate ;
@synthesize bomb ;
@synthesize canPutBomb ;
@synthesize exsitPeople ;
@synthesize fireType ;

-(void) setDelegate:(id<Square_call_MapData>)inDelegate {
    
    delegate = inDelegate ;
    
}

-(void) initalLacation: (int) X : (int) Y {
    bomb = NULL ;
    fireType = 0 ;
    
    x = X ;
    y = Y ;
    
    pixal_x = x * IMG_MAP_SIZE  ;
    pixal_y = y * IMG_MAP_SIZE  ;
    
    pixal_x_max = pixal_x + IMG_MAP_SIZE ;
    pixal_y_max = pixal_y + IMG_MAP_SIZE  ;
    
    exsitObj = NOTHING ;
    exsitPeople = false ;
    playerList = [[NSMutableArray alloc] init ] ;
    
    canIn = true ;
    canPutBomb = true ;
    
}

+(CGPoint) existWhichSquare : (int) X : (int) Y {
    int x = X / IMG_MAP_SIZE ;
    int y = Y / IMG_MAP_SIZE  ;
    return CGPointMake(x, y) ;
}

-(void) peopleInSquare : (id) peopleObj {
    exsitPeople = true ;
    [ playerList addObject:peopleObj ] ;
    
}

-(void) peopleleaveSquare {
    exsitPeople = false ;
    playerList = [[NSMutableArray alloc] init ] ;
    
}

-(void) putThingInSquare :(int) type PutObject : (id) obj {
    exsitObj = type ;
        
    if ( exsitObj == BOMB ) {
        bomb = obj ;
        canIn = false ;
        canPutBomb = false ;
    } // else if
    
    else if ( exsitObj == ITEM ) {
        
        
    } // else if
    
    else if ( exsitObj == BRICK ) {
        
        
    } // else if

}



-(void) removeThingFromSquare : (int) firetype {
    // TODO Obj need to release from here ;
    // Include ( item, brick )
    
    fireType =  firetype ;
    
   
    
    if ( exsitPeople ) {
       [NSThread sleepForTimeInterval:(float)0.5];
      [ delegate resetPlayerLoc ] ;
        [self peopleleaveSquare ] ;
    } // if
    
    if ( exsitObj == BOMB ) {       
        bomb = NULL ;
        canPutBomb = true ;
    } // else if
    
    
    
    
    exsitObj = NOTHING ;
    
    
    canIn = true ;
  
    
  
}





@end
