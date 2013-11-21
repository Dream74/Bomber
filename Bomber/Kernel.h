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

@interface Kernel : NSObject {
@public
    
}

+ (UIImage *) subImage      :(UIImage *)  img     offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height ;
+ (void)      drawText      :(NSString *) strText offsetWidth:(int)x offsetHeight:(int)y textSize:(int)size  ;
+ (UIImage *) subImageRotate:(UIImage *)  img     offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height :(int) degree :(float) scale;


// readonly－唯讀，只能讀取而不能設定值（不能用setXXXX的函式）。
// readwrite－可讀可寫（預設）。
// assign－在設值時替換新舊資料（預設）。
// retain－在設值時retain新的資料，release舊資料。
// copy－在設值時copy一份新資料，release舊資料。
// nonatomic－預設為atomic。
@property (nonatomic, strong) NSMutableArray * bombCollect;


- (void)touchesBegan    :(CGPoint *)location ;
- (void)touchesCancelled:(CGPoint *)location ;
- (void)touchesMoved    :(CGPoint *)location ;
- (void)touchesEnded    :(CGPoint *)location ;
- (void)start ;
- (void)stop  ;
- (void)draw  ;

@property (nonatomic) Control *  ctrlUI  ;
@property (nonatomic) Player  *  onePlayer ;
@property (nonatomic) MapData *  map ;
@end
