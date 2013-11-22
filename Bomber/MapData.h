//
//  MapData.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bomber.h"


#define IMG_MAP_SIZE 32

#define SCREEN_WIDTH_NUM SCREEN_WIDTH / IMG_MAP_SIZE + 2
#define SCREEN_HIGHT_NUM SCREEN_HIGHT / IMG_MAP_SIZE + 2

#define MAP_WIDTH_NUM 50
#define MAP_HIGHT_NUM 50

#define IMG_MAP_OFFSET_WIDTH 32
#define IMG_MAP_OFFSET_HIGHT 40

@interface MapData : NSObject{
@private
    CGPoint offsetPoint ;
}

@property (nonatomic) CGPoint offsetPoint ;
@property (nonatomic) CGPoint mapPoint ;
@property (nonatomic) CGPoint rolePoint ;

- (void) draw ;
- (void) doMove:(CGPoint) move ;
+ (void) initialImage ;
- (MapData *) initWithPoint:(CGPoint) startMapPoint startScreen:(CGPoint)startScreenPoint ;

@end
