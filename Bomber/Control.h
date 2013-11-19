//
//  Control.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Control : NSObject

@property (nonatomic) CGPoint location ;
@property (nonatomic) CGPoint lastTouch ;

@property (nonatomic, strong) UIImage * controlImage;

- (void) touchesBegan    :(CGPoint *)touches ;
- (void) touchesCancelled:(CGPoint *)touches ;
- (void) touchesMoved    :(CGPoint *)touches ;
- (void) touchesEnded    :(CGPoint *)touches ;
- (void) draw ;

-(CGPoint) getMove ;
@end
