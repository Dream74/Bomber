//
//  Player.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject{
@private
    CGPoint local ;
    UIImage * originalImg;
    NSMutableArray * playerImages;
    
    int state    ;
    int speed    ;
    int fire     ;
    int bombNum  ;
}

@property (nonatomic) CGPoint local ;
@property (nonatomic, strong) UIImage * originalImg;
@property (nonatomic, strong) NSMutableArray * playerImages;

@property (nonatomic) int state    ;
@property (nonatomic) int speed    ;
@property (nonatomic) int fire     ;
@property (nonatomic) int bombNum  ;

-(void) draw ;
-(void) doMove:(CGPoint) move ;
-(CGPoint) getLocalPoint;
@end
