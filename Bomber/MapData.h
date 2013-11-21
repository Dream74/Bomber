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

#define MAP_WIDTH_NUM SCREEN_WIDTH / IMG_MAP_SIZE + 4
#define MAP_HIGHT_NUM SCREEN_HIGHT / IMG_MAP_SIZE + 4

#define IMG_MAP_OFFSET_WIDTH 32
#define IMG_MAP_OFFSET_HIGHT 40

@interface MapData : NSObject


@property (atomic) CGPoint local ;
@property (nonatomic, strong) NSMutableArray * groundImages;
- (void) draw ;
@end
