//
//  Control.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Control.h"

@implementation Control
@synthesize lastTouch    ;
@synthesize currentColor ;
@synthesize canMove      ;

#define MOVE_UI_REDIUS   50
#define MOVE_UI_DIAMETER MOVE_UI_REDIUS * 2

#define TOUCH_REDIUS 10
#define TOUCH_DIAMETER TOUCH_REDIUS * 2

#define BOMB_UI_REDIUS 30
#define BOMB_UI_DIAMETER BOMB_UI_REDIUS * 2
#undef DEBUG

- (id) init{
    self = [super init] ;
    
    moveUIPoint.x = 80 ;
    moveUIPoint.y = 250 ;
    bombUIPoint.x = 500 ;
    bombUIPoint.y = 250 ;
    /* 可以利用這樣設定半透明度
     UIColor *theColor=[UIColor
     colorWithRed:1.0
     green:0.0
     blue:0.0
     alpha:1.0]; */
    canMove       = false ;
    return self ;
}

-(void) draw {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake (moveUIPoint.x - MOVE_UI_REDIUS ,
                                                   moveUIPoint.y - MOVE_UI_REDIUS ,
                                                   MOVE_UI_DIAMETER,
                                                   MOVE_UI_DIAMETER));
    const CGPoint touchMove = [self getMove];
    CGContextAddEllipseInRect(context, CGRectMake (moveUIPoint.x - TOUCH_REDIUS + touchMove.x,
                                                   moveUIPoint.y - TOUCH_REDIUS + touchMove.y,
                                                   TOUCH_DIAMETER,
                                                   TOUCH_DIAMETER));
    
    CGContextAddEllipseInRect(context, CGRectMake (bombUIPoint.x - BOMB_UI_REDIUS ,
                                                   bombUIPoint.y - BOMB_UI_REDIUS ,
                                                   BOMB_UI_DIAMETER,
                                                   BOMB_UI_DIAMETER));
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

-(CGPoint) getMove{
    if ( canMove ) {
        const CGPoint diff = { lastTouch.x - moveUIPoint.x , lastTouch.y - moveUIPoint.y };
        const float diffLen = sqrtf(diff.x * diff.x + diff.y * diff.y) ;
        if ( ( diffLen <= MOVE_UI_REDIUS )  ) {
            return diff ;
        }
        else {
            const CGPoint move = {  diff.x / ( diffLen / MOVE_UI_REDIUS ) ,
                                    diff.y / ( diffLen / MOVE_UI_REDIUS ) };
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

    lastTouch  = *touches ;
    
    const CGPoint diff = { lastTouch.x - moveUIPoint.x , lastTouch.y - moveUIPoint.y };
    const float diffLen = sqrtf(diff.x * diff.x + diff.y * diff.y) ;

    canMove = ( diffLen <= MOVE_UI_REDIUS ) ? true : false ;
}


- (void)touchesCancelled:(CGPoint *) touches{
#ifdef DEBUG
    NSLog(@"touchesCancelled X:%f Y:%f", touches->x, touches->y) ;
#endif
}


- (void)touchesMoved:(CGPoint *) touches{
#ifdef DEBUG
    NSLog(@"touchesMoved X:%f Y:%f", touches->x, touches->y) ;
#endif
    lastTouch = CGPointMake(touches->x, touches->y) ;
}


- (void)touchesEnded:(CGPoint *) touches{
#ifdef DEBUG
    NSLog(@"touchesEnded X:%f Y:%f", touches->x, touches->y) ;
#endif
    lastTouch = CGPointMake(touches->x, touches->y) ;
    canMove = false ;
}
@end
