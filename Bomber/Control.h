//
//  Control.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Control : NSObject{
    // TODO 這樣應該可以限制他權限吧...
@private
    CGPoint   moveUIPoint  ;
    CGPoint   lastTouch    ;
    CGPoint   bombUIPoint  ;
    UIImage * controlImage ;
    bool      canMove      ;
    
}

<<<<<<< HEAD
@property (nonatomic)         CGPoint   moveUIPoint  ;
@property (nonatomic)         CGPoint   lastTouch    ;
@property (nonatomic)         CGPoint   bombUIPoint  ;
@property (nonatomic, strong) UIImage * controlImage ;
@property (nonatomic)         bool      canMove      ;
=======
@property (nonatomic)         CGPoint firstTouch ;
@property (nonatomic)         CGPoint lastTouch ;
@property (strong, nonatomic) UIColor * currentColor;
@property (nonatomic)         bool canMove ;
>>>>>>> origin/Jin-Yuan


- (void) touchesBegan    :(CGPoint *)touches ;
- (void) touchesCancelled:(CGPoint *)touches ;
- (void) touchesMoved    :(CGPoint *)touches ;
- (void) touchesEnded    :(CGPoint *)touches ;

- (void)    draw ;
- (CGPoint) getMove ;
@end
