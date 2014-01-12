//
//  BomberFunView.m
//  Bomber
//
//  Created by dream on 2013/11/8.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "BomberFunView.h"
#include "kernel.h"
#define TIME_INTERVAL ( 0.001 )

@implementation BomberFunView
@synthesize bomber_kernel  ;
@synthesize bThreadRunning ;

- (id)initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
        
        [self setMultipleTouchEnabled:YES] ;
        
        bomber_kernel = [ [ Kernel alloc ] init ] ;
        
        if ( self.multipleTouchEnabled ) {
            NSLog(@"multipleTouch is Enabled");
        }
        
        [self drawInit] ;
        [self start] ;
    }
    return self;
}


- (void)start{
    bThreadRunning = true ;
    [ bomber_kernel start ] ;
    [NSThread detachNewThreadSelector:@selector(sceneRun) toTarget:self withObject:nil];
}

- (void)stop{
    bThreadRunning = false;
    [ bomber_kernel stop ] ;
}

- (void)sceneRun{
    
    @autoreleasepool {
        while(bThreadRunning)
        {
            [self performSelectorOnMainThread:@selector(updateGUI)withObject:nil waitUntilDone:NO];
            [NSThread sleepForTimeInterval:TIME_INTERVAL];
        }
    }
}


- (void)updateGUI
{    [self setNeedsDisplay];    }

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

<<<<<<< HEAD
- (void)drawInit{
    NSLog(@"drawInit") ;
}
=======

>>>>>>> Dream

- (void)drawRect:(CGRect)rect {
    [bomber_kernel draw];
  
}




@end
