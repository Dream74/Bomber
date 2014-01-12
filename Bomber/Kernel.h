//
//  Kernel.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Control.h"
#import "Player.h"
#import "MapData.h"
#import "Resource.h"

#import "Block.h"


#define LIMIT_PLAYER_OFFSET_POINT_X 200.0
#define LIMIT_PLAYER_OFFSET_POINT_Y 150.0

#define LIMIT_PLAYER_POINT_X ( SCREEN_HIGHT - LIMIT_PLAYER_OFFSET_POINT_X )
#define LIMIT_PLAYER_POINT_Y ( SCREEN_WIDTH  - LIMIT_PLAYER_OFFSET_POINT_Y )

@interface Kernel : NSObject {
@public
    
}

+ (UIImage *) subImage:(UIImage *) img getImgRect :(CGRect)rect ;
+ (UIImage *) subImage:(UIImage *) img getImgRect :(CGRect)rect imgScale:(float)scale ;
+ (UIImage *) subImage:(UIImage *) img getImgRect :(CGRect)rect imgTurn:(NSInteger)degree ;
+ (UIImage *) subImage:(UIImage *) img getImgRect :(CGRect)rect imgTurn:(NSInteger)degree imgScale:(float)scale ;
+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height ;
+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height imgScale:(float)scale ;
+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height imgTurn:(NSInteger)degree ;
+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height imgTurn:(NSInteger) degree imgScale:(float) scale;

+ (void) drawText:(NSString *) strText offsetWidth:(int)x offsetHeight:(int)y textSize:(int)size  ;
+ (void) drawGrid:(CGRect)rect lineWidth:(float)line ;

// readonly－唯讀，只能讀取而不能設定值（不能用setXXXX的函式）。
// readwrite－可讀可寫（預設）。
// assign－在設值時替換新舊資料（預設）。
// retain－在設值時retain新的資料，release舊資料。
// copy－在設值時copy一份新資料，release舊資料。
// nonatomic－預設為atomic。
// strong -

@property (nonatomic) Control *  ctrlUI  ;
@property (nonatomic) Player  *  onePlayer ;
@property (nonatomic) Player  *  twoPlayer ;

@property (nonatomic) MapData *  map ;
@property (nonatomic) Block   * one_block ;

- (void)touchesBegan    :(CGPoint *)location ;
- (void)touchesCancelled:(CGPoint *)location ;
- (void)touchesMoved    :(CGPoint *)location ;
- (void)touchesEnded    :(CGPoint *)location ;
- (void)start ;
- (void)stop  ;
- (void)draw  ;

@end
