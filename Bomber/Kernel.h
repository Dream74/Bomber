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

@interface Kernel : NSObject {
@public
    
}

+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height ;
+ (UIImage *) subImageRotate:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height :(int) degree;

@property (nonatomic, strong) NSMutableArray * bombCollect;
- (void)touchesBegan    :(CGPoint *)location ;
- (void)touchesCancelled:(CGPoint *)location ;
- (void)touchesMoved    :(CGPoint *)location ;
- (void)touchesEnded    :(CGPoint *)location ;
- (void)start ;
- (void)stop  ;
- (void)draw  ;

@property (nonatomic) Control * ctrlUI  ;
@property (nonatomic) Player  * onePlayer ;
@property (nonatomic) MapData * map ;
@end
