//
//  Control.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Control : NSObject

@property (nonatomic)         CGPoint firstTouch ;
@property (nonatomic)         CGPoint lastTouch ;
@property (strong, nonatomic) UIColor * currentColor;
@property (nonatomic, strong) UIImage * controlImage;
@property (nonatomic)         bool canMove ;


- (void) touchesBegan    :(CGPoint *)touches ;
- (void) touchesCancelled:(CGPoint *)touches ;
- (void) touchesMoved    :(CGPoint *)touches ;
- (void) touchesEnded    :(CGPoint *)touches ;

- (void)    draw ;
- (CGPoint) getMove ;
@end
