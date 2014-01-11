//
//  Square.h
//  Bomber
//
//  Created by luoboy on 13/11/22.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bomb.h"
#import "Resource.h"
#import "Block.h"

@protocol Square_call_MapData <NSObject>

-(void) resetPlayerLoc ;

@end


@interface Square : NSObject

#define IMG_MAP_SIZE 32

enum OBJ_TYPE { NOTHING = 0 , ITEM, BOMB, BRICK, LENGTH } ;

@property (nonatomic ) int x ;
@property (nonatomic ) int y ;

@property (nonatomic ) int pixal_x ;
@property (nonatomic ) int pixal_y ;

@property (nonatomic ) int pixal_x_max ;
@property (nonatomic ) int pixal_y_max ;

@property (nonatomic ) int exsitObj ; // use enum to control
@property (nonatomic ) bool exsitPeople ;
@property (nonatomic ) NSMutableArray * playerList ;  // the square exsit what

@property (nonatomic ) bool canIn ;
@property (nonatomic ) bool canPutBomb;

@property (nonatomic ) id <Square_call_MapData> delegate ;
@property (nonatomic ) Bomb * bomb ;
@property (nonatomic ) int fireType ;

+(CGPoint) existWhichSquare :(int) X : (int) Y ;
-(void) initalLacation : (int) X : (int) Y ;

-(void) putThingInSquare : (int) type PutObject : (id) obj ;
-(void) removeThingFromSquare : (int) firetype ;

-(void) setDelegate:(id<Square_call_MapData>) inDelegate ;
-(void) peopleInSquare : (id) peopleObj ;
-(void) peopleleaveSquare ;


@end
