//
//  BomberFunView.h
//  Bomber
//
//  Created by dream on 2013/11/8.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BomberFunView : UIView

@property (nonatomic) CGPoint firstTouch;
@property (nonatomic) CGPoint lastTouch;
@property (nonatomic) CGPoint bomber ;
@property (nonatomic) CGPoint control ;

@property (strong, nonatomic) UIColor *currentColor;
@property (nonatomic, strong) UIImage *drawImage;
@property (nonatomic, strong) UIImage *controlImage;

@property CGRect redrawRect;

@end
