//
//  Box.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Box : NSObject

@property (nonatomic) CGPoint DataLoca ; // 格數 坐標
@property (nonatomic) CGPoint local ; // pixal坐標
@property ( nonatomic ) bool canBomb ;
@property ( nonatomic ) bool canPass ;



-(void) initalLocation : (CGPoint) local :(bool) CanBomb : (bool) CanPass ;


@end
