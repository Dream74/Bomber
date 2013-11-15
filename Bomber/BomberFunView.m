//
//  BomberFunView.m
//  Bomber
//
//  Created by dream on 2013/11/8.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "BomberFunView.h"

@implementation BomberFunView


int controlRadius ;
bool canMove ;



- (CGRect)currentRect {
    return CGRectMake (_firstTouch.x,
                       _firstTouch.y,
                       _lastTouch.x - _firstTouch.x,
                       _lastTouch.y - _firstTouch.y);
}


+ (UIImage *) subImage:(UIImage *) img offsetWidth:(int)x offsetHeight:(int)y imgWidth:(int)width imgHeight:(int)height {
    CGRect rect = CGRectMake(x, y, width, height);
    
    CGImageRef drawImage = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage * _outImage = [UIImage imageWithCGImage:drawImage];
    CGImageRelease(drawImage);
    return _outImage ;
}

- (id)initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
        _currentColor = [UIColor redColor];
        // _useRandomColor = NO;
        _bomber.x = 160 ;
        _bomber.y = 200 ;
        _control.x = 50 ;
        _control.y = 250 ;
        UIImage * player = [UIImage imageNamed:@"character_gold.png"] ;
        _drawImage = [[self class] subImage:player offsetWidth:0 offsetHeight:30 imgWidth:30 imgHeight:60];

        _controlImage = [UIImage imageNamed:@"controlbut.png"] ;

        controlRadius =  _controlImage.size.width / 2; ;
        canMove = false ;
        
        [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
        
    }
    
    
    return self;
}

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    _firstTouch = [touch locationInView:self];
    _lastTouch = [touch locationInView:self];
    
    NSLog(@"touchesBegan X:%f Y:%f", _firstTouch.x, _firstTouch.y) ;
    const CGPoint diff = { _lastTouch.x - _control.x , _lastTouch.y - _control.y };
    
    canMove = ( diff.x <= controlRadius && diff.y <= controlRadius ) ? true : false ;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    
    NSLog(@"touchesEnded X:%f Y:%f", _lastTouch.x, _lastTouch.y) ;
    
    canMove = false ;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    NSLog(@"touchesMoved X:%f Y:%f", _lastTouch.x, _lastTouch.y) ;
    
    
    // 目前不曉得這邊差異未來研究
    /*
     CGFloat horizontalOffset = _drawImage.size.width / 2;
     CGFloat verticalOffset = _drawImage.size.height / 2;
     _redrawRect = CGRectUnion(_redrawRect,
     CGRectMake(_lastTouch.x - horizontalOffset,
     _lastTouch.y - verticalOffset,
     _drawImage.size.width,
     _drawImage.size.height));
     _redrawRect = CGRectUnion(_redrawRect, self.currentRect);
     // 只重新畫 rederawRect 這區畫
     [self setNeedsDisplayInRect:_redrawRect];*/
    // 整個畫面重新畫
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesCancelled ") ;
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"DrawRect Touch X:%f Y:%f _bomber X:%f Y:%f", _lastTouch.x, _lastTouch.y, _bomber.x , _bomber.y) ;
    
    // 畫圈  我們拿來操控用
    /*
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetLineWidth(context, 0.5);
     CGContextSetStrokeColorWithColor(context, _currentColor.CGColor);
     // 中心背景 找個透明的或者未來可能是貼圖
     CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
     
     // 因為他是從 圓的 想成是一個正方形，他是從方形的左上角任定的座標開始畫
     // 所以先把座標扣除掉半徑，就可以把我們想要的座標拉到圓中心
     // 後面兩個參數是直徑所以 * 2
     CGContextAddEllipseInRect(context, CGRectMake (_control.x - controlRadius,
     _control.y - controlRadius,
     controlRadius*2,
     controlRadius*2));
     CGContextDrawPath(context, kCGPathFillStroke);
    */
    
    CGPoint controldrawPoint = CGPointMake( _control.x - controlRadius, _control.y - controlRadius);
    // CGPoint controldrawPoint = CGPointMake( 50, 350);
    [_controlImage drawAtPoint:controldrawPoint];
    
    if ( canMove) {
        
        const CGPoint diff = {
            (_lastTouch.x - _control.x) > controlRadius? controlRadius : (_lastTouch.x - _control.x)
            , (_lastTouch.y - _control.y) > controlRadius? controlRadius : (_lastTouch.y - _control.y)} ;
        
        _bomber.x += diff.x /50 ;
        _bomber.y += diff.y /50 ;
    }
    // 畫 圖片上去
    CGFloat horizontalOffset = _drawImage.size.width / 2;
    CGFloat verticalOffset = _drawImage.size.height / 2;
    CGPoint drawPoint = CGPointMake(_bomber.x - horizontalOffset, _bomber.y - verticalOffset);
    
    
    [_drawImage drawAtPoint:drawPoint];
    
    
    
}

@end
