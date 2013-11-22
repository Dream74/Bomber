//
//  Square.h
//  Bomber
//
//  Created by luoboy on 13/11/22.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Square : NSObject

enum OBJ_TYPE { NOTHING = 0 ,  ITEM, PLAYER , BOMB , BRICK, LENGTH } ;

@property (nonatomic ) int x ;
@property (nonatomic ) int y ;

@property (nonatomic ) int pixal_x ;
@property (nonatomic ) int pixal_y ;

@property (nonatomic ) int pixal_x_max ;
@property (nonatomic ) int pixal_y_max ;

@property (nonatomic ) int exsitObj ; // use enum to control

@property (nonatomic ) NSMutableArray * objList ;  // the square exsit what

@property (nonatomic ) bool canIn ;

+(CGPoint) existWhichSquare :(int) X : (int) Y ;
-(void) initalLacation : (int) X : (int) Y ;

-(void) putThingInSquare : (int) type PutObject : (id) obj ;
-(void) removeThingFromSquare ;


@end
