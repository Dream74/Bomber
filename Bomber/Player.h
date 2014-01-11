//
//  Player.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject {
@private
    CGPoint local ;
    UIImage * originalImg;
    NSMutableArray * playerImages;
    
    int state    ;
    int speed    ;
    int fire     ;
    int bombNum  ;
}

enum CH_TYPE { FLY = 0, GOLD, CRAWLING, MARIO_RPG, CH_TYPE_LENGTH } ;

@property (nonatomic) CGPoint local ;
@property (nonatomic) CGPoint dataLoc ;
@property (nonatomic) NSMutableArray * playerImages ;

@property (nonatomic) int state    ;
@property (nonatomic) int speed    ;
@property (nonatomic) int fire     ;
@property (nonatomic) int bombNum  ;
@property (nonatomic) int ChImage  ;

@property (nonatomic) int imgIndex_count  ;

+ (void)    initializeAllImage ;

- (CGPoint) getLocalPoint;
- (id)      initial : (int) chartype startPoint:(CGPoint) localPoint ;
- (void)    doMove:(CGPoint)  move ;
- (void)    setTurn:(CGPoint) move ;
- (void)    draw       ;
- (void)    removeBomb ;
- (bool)    putBomb    ;
- (bool)    isHaveBomb ;
- (void)    resetLocation : (CGPoint) localPoint ;
- (void)    addBombNum;
@end
