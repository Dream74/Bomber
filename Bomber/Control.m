//
//  Control.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Control.h"

@implementation Control
@synthesize firstTouch   ;
@synthesize lastTouch    ;
@synthesize controlImage ;
@synthesize currentColor ;
@synthesize canMove      ;

#define CONTROL_REDIUS   50
#define CONTROL_DIAMETER CONTROL_REDIUS * 2

#define TOUCH_REDIUS 10
#define TOUCH_DIAMETER TOUCH_REDIUS * 2

#undef DEBUG

- (id) init{
    self = [super init] ;
    controlImage = [UIImage imageNamed:@"controlbut.png"] ;
    
    /* 可以利用這樣設定半透明度
     UIColor *theColor=[UIColor
     colorWithRed:1.0
     green:0.0
     blue:0.0
     alpha:1.0]; */
    
    currentColor = [UIColor whiteColor];
    canMove      = false ;
    return self ;
}

-(void) draw{
    // [controlImage drawAtPoint:CGPointMake(location.x - controlRadius, location.y - controlRadius)] ;
    if ( canMove ) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextAddEllipseInRect(context, CGRectMake (firstTouch.x - CONTROL_REDIUS ,
                                                       firstTouch.y - CONTROL_REDIUS ,
                                                       CONTROL_DIAMETER,
                                                       CONTROL_DIAMETER));
        const CGPoint touchMove = [self getMove];
        CGContextAddEllipseInRect(context, CGRectMake (firstTouch.x - TOUCH_REDIUS + touchMove.x,
                                                       firstTouch.y - TOUCH_REDIUS + touchMove.y,
                                                       TOUCH_DIAMETER,
                                                       TOUCH_DIAMETER));
    
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

-(CGPoint) getMove{
    if ( canMove ) {
        const CGPoint diff = { lastTouch.x - firstTouch.x , lastTouch.y - firstTouch.y };
        const float diffLen = sqrtf(diff.x * diff.x + diff.y * diff.y) ;
        if ( ( diffLen <= CONTROL_REDIUS )  ) {
            return diff ;
        }
        else {
            const CGPoint move = {  diff.x / ( diffLen / CONTROL_REDIUS ) ,
                                    diff.y / ( diffLen / CONTROL_REDIUS ) };
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
    firstTouch = CGPointMake(touches->x, touches->y) ;
    lastTouch  = firstTouch ;
    
    const CGPoint diff = { lastTouch.x - firstTouch.x , lastTouch.y - firstTouch.y };
    
    canMove = ( diff.x <= CONTROL_REDIUS && diff.y <= CONTROL_REDIUS ) ? true : false ;
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
