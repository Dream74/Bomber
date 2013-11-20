//
//  BomberFunView.m
//  Bomber
//
//  Created by dream on 2013/11/8.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "BomberFunView.h"
#include "kernel.h"

@implementation BomberFunView
@synthesize bomber_kernel ;



- (id)initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
        bomber_kernel = [ [ Kernel alloc ] init ] ;
        
        [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];

    }
    return self;
}

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    [bomber_kernel touchesBegan:&_lastTouch] ;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    [bomber_kernel touchesEnded:&_lastTouch] ;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    [bomber_kernel touchesMoved:&_lastTouch] ;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    [bomber_kernel touchesCancelled:&_lastTouch] ;
}

- (void)drawRect:(CGRect)rect {
   // NSLog(@"drawRect X:%f Y:%f", rect.size.width, rect.size.height) ;
    [bomber_kernel draw];
}


@end
