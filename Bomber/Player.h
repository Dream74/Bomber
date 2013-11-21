//
//  Player.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic) CGPoint local ;
+( NSMutableArray * ) playerImages;

@property (nonatomic) int state    ;
@property (nonatomic) int speed    ;
@property (nonatomic) int fire     ;
@property (nonatomic) int bombNum  ;

-(void) draw ;
-(void) doMove:(CGPoint) move ;
@end
