//
//  Kernel.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Kernel : NSObject
+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height ;
- (void)touchesBegan    :(CGPoint *)location ;
- (void)touchesCancelled:(CGPoint *)location ;
- (void)touchesMoved    :(CGPoint *)location ;
- (void)touchesEnded    :(CGPoint *)location ;
- (void)start ;
- (void)stop  ;
- (void)draw  ;
@end
