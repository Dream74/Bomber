//
//  Control.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Control.h"
#undef DEBUG

@implementation Control
@synthesize lastTouch ;
@synthesize location ;
@synthesize controlImage ;

int controlRadius ;
bool canMove ;
- (id) init{
    self = [super init] ;
    location.x = 50 ;
    location.y = 250 ;
    controlImage = [UIImage imageNamed:@"controlbut.png"] ;
    controlRadius =  controlImage.size.width / 2; ;
    canMove = false ;
    return self ;
}

-(void) draw{
    [controlImage drawAtPoint:CGPointMake(location.x - controlRadius, location.y - controlRadius)] ;
}

-(CGPoint) getMove{
    static CGPoint move ;
    if ( canMove ) {
        const CGPoint diff = { lastTouch.x - location.x , lastTouch.y - location.y };
        if ( ( diff.x <= controlRadius && diff.y <= controlRadius )  ) {
            move = diff ;
            return diff ;
        }
        else {
            return move ;
        }
    }
    else
    {
        return CGPointMake(0, 0);
    }
}

- (void)touchesBegan:(CGPoint *) touches{
#ifdef DEBUG
    NSLog(@"touchesBegan X:%f Y:%f", touches->x, touches->y) ;
#endif
    lastTouch = CGPointMake(touches->x, touches->y) ;
    const CGPoint diff = { touches->x - location.x , touches->y - location.y };
    
    canMove = ( diff.x <= controlRadius && diff.y <= controlRadius ) ? true : false ;
}

- (void)touchesCancelled:(CGPoint *) touches{
#ifdef DEBUG
    NSLog(@"touchesBegan X:%f Y:%f", touches->x, touches->y) ;
#endif
}

- (void)touchesMoved:(CGPoint *) touches{
#ifdef DEBUG
    NSLog(@"touchesBegan X:%f Y:%f", touches->x, touches->y) ;
#endif
    lastTouch = CGPointMake(touches->x, touches->y) ;
    
}

- (void)touchesEnded:(CGPoint *) touches{
#ifdef DEBUG
    NSLog(@"touchesBegan X:%f Y:%f", touches->x, touches->y) ;
#endif
    lastTouch = CGPointMake(touches->x, touches->y) ;
    canMove = false ;
}
@end
