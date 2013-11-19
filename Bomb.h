//
//  Bomb.h
//  Bomber
//
//  Created by dream on 11/20/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Box.h"

@interface Bomb : Box

@property (nonatomic) CGPoint local ;
@property (nonatomic, strong) UIImage * originalImg;
@property (nonatomic, strong) NSMutableArray * bombImages;
@end
