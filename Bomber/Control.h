//
//  Control.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "MapData.h"

@interface Control : NSObject{
    // TODO 這樣應該可以限制他權限吧...
@private
    CGPoint   moveUIPoint  ;
    CGPoint   lastTouch    ;
    CGPoint   bombUIPoint  ;
    UIImage * controlImage ;
    bool      canMove      ;
    
    
}

@property (nonatomic)         CGPoint   firstTouch   ;
@property (nonatomic)         CGPoint   lastTouch    ;
@property (nonatomic)         UIColor * currentColor ;
@property (nonatomic)         bool      canMove      ;
@property (nonatomic)         Player *  usrPlayer    ;

- (id)   initWithUsr:(Player *) usr          ;
- (void) touchesBegan    :(CGPoint *)touches ;
- (void) touchesCancelled:(CGPoint *)touches ;
- (void) touchesMoved    :(CGPoint *)touches ;
- (void) touchesEnded    :(CGPoint *)touches ;
- (void)    draw ;
- (CGPoint) getMove ;
@end
