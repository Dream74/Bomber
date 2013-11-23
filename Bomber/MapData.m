//
//  MapData.m
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "MapData.h"
#import "Kernel.h"

@implementation MapData

static NSMutableArray * groundImages;

@synthesize screenoffsetPoint  ;
@synthesize screenStartXYPoint ;

@synthesize roleScreenPoint    ;
@synthesize roleXYPoint        ;
@synthesize usrPlayer    ;

#define SPEED 10

#define LIMIT_PLAYER_OFFSET_POINT_X 100.0
#define LIMIT_PLAYER_OFFSET_POINT_Y 80.0

#define LIMIT_PLAYER_POINT_X ( SCREEN_HIGHT - LIMIT_PLAYER_OFFSET_POINT_X )
#define LIMIT_PLAYER_POINT_Y ( SCREEN_WIDTH  - LIMIT_PLAYER_OFFSET_POINT_Y )

int backGround[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;
int objGround[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;

static Square * DSGround [MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;

+ (Square *) getDSGround : (int) x : (int) y {
    return DSGround [x][y] ;
    
}



+ (CGPoint) dataFormal:(CGPoint) data {
    if ( data.x > MAP_HIGHT_NUM ) data.x -= ( MAP_HIGHT_NUM + 1 ) ;
    if ( data.x < 0 )             data.x += ( MAP_HIGHT_NUM + 1 ) ;
    
    if ( data.y > MAP_WIDTH_NUM ) data.y -= ( MAP_WIDTH_NUM + 1 ) ;
    if ( data.y < 0 )             data.y += ( MAP_WIDTH_NUM + 1 ) ;
    assert( data.x <= MAP_HIGHT_NUM && data.x >= 0 ) ;
    assert( data.y <= MAP_WIDTH_NUM && data.y >= 0 ) ;
    return data ;
}


+ (void) initialImage {
    groundImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8 ; i++) {
        [groundImages addObject:[[Kernel class] subImage:[[Resource class] tileset_12_31 ] offsetWidth:i*IMG_MAP_OFFSET_WIDTH offsetHeight:0 imgWidth:IMG_MAP_SIZE imgHeight:IMG_MAP_SIZE]];
    } // for
    
    for ( int i = 0 ; i < 5 ; i++ ) {
        [groundImages addObject:[[Kernel class] subImage:[[Resource class] tileset_12_31 ] offsetWidth:i*IMG_MAP_OFFSET_WIDTH offsetHeight:IMG_MAP_OFFSET_HIGHT imgWidth:IMG_MAP_SIZE imgHeight:IMG_MAP_SIZE]];
    } // for
    
    for( int i = 0; i < MAP_WIDTH_NUM ; i++){
        for (int j = 0; j < MAP_HIGHT_NUM; j++) {
            backGround[j][i] = arc4random() % 13 ;
        }
    }
    
    for( int i = 0; i < MAP_WIDTH_NUM ; i++){
        for (int j = 0; j < MAP_HIGHT_NUM; j++) {
            objGround[j][i] = arc4random() % 2 ;
        }
    }
}


- (MapData *) initWithUsr:(Player *)usr mapPoint:(CGPoint)startMapPoint startScreen:(CGPoint)startScreenPoint{
    self = [super init] ;
    roleScreenPoint = startScreenPoint ;
    roleXYPoint     = startMapPoint    ;
    usrPlayer       = usr ;
    
    screenStartXYPoint = CGPointMake(startMapPoint.x - (( (int)roleScreenPoint.x / IMG_MAP_SIZE ) + 1 ) ,
                                     startMapPoint.y - (( (int)roleScreenPoint.y / IMG_MAP_SIZE ) + 1 ) ) ;
    
    screenoffsetPoint  = CGPointMake( ((int)roleScreenPoint.x % IMG_MAP_SIZE ) - IMG_MAP_SIZE,
                                      ((int)roleScreenPoint.y % IMG_MAP_SIZE ) - IMG_MAP_SIZE) ;
    
    NSLog(@"MAP_HIGHT_NUM :%d   MAP_WIDTH_NUM:%d", MAP_HIGHT_NUM , MAP_WIDTH_NUM ) ;
    

    return self ;
}


- (void) doMove:(CGPoint) move{
    static CGPoint shiftMove = {0,0} ;
    //    NSLog(@"Location X: %d Y :%d", (int)mapPoint.x, (int)mapPoint.y ) ;
    move.x = move.x * SPEED / 100 ;
    move.y = move.y * SPEED / 100 ;
    
    [usrPlayer setTurn:move]  ;
    shiftMove.x += move.x ;
    shiftMove.y += move.y ;
    
    if ( shiftMove.x >= IMG_MAP_SIZE ){
        roleXYPoint.x += 1 ;
        shiftMove.x -= IMG_MAP_SIZE ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
    } else if ( shiftMove.x <= (IMG_MAP_SIZE * -1 )){
        roleXYPoint.x -= 1 ;
        shiftMove.x += IMG_MAP_SIZE ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
    }
    
    if ( shiftMove.y >= IMG_MAP_SIZE ){
        roleXYPoint.y += 1 ;
        shiftMove.y -= IMG_MAP_SIZE ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
    } else if ( shiftMove.y <= (IMG_MAP_SIZE * -1 )){
        roleXYPoint.y -= 1 ;
        shiftMove.y += IMG_MAP_SIZE ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
    }
    
    
    // 玩家原始位置
    const CGPoint playerPoint = roleScreenPoint ;
    // 移動過後位置
    const CGPoint playerAfterMovePoint = CGPointMake( playerPoint.x + move.x, playerPoint.y + move.y );
    // 利用上面已知的三個值，算出 地圖要移動多少，與玩家要移動多少
    CGPoint playerMove = {0,0} ;
    
    if ( playerAfterMovePoint.x > LIMIT_PLAYER_POINT_X ||  playerAfterMovePoint.x < LIMIT_PLAYER_OFFSET_POINT_X) {
        screenoffsetPoint.x-= move.x ;
        
        if ( screenoffsetPoint.x >= IMG_MAP_SIZE ){
            screenStartXYPoint.x -= 1 ;
            screenoffsetPoint.x -= IMG_MAP_SIZE ;
            screenStartXYPoint = [[MapData class] dataFormal:screenStartXYPoint] ;
        } else if ( screenoffsetPoint.x <= (IMG_MAP_SIZE * -1 )){
            screenStartXYPoint.x += 1 ;
            screenoffsetPoint.x += IMG_MAP_SIZE ;
            screenStartXYPoint = [[MapData class] dataFormal:screenStartXYPoint] ;
        }
    } else {
        playerMove.x      += move.x ;
        roleScreenPoint.x += move.x ;
    }
    
    
    if ( playerAfterMovePoint.y > LIMIT_PLAYER_POINT_Y ||  playerAfterMovePoint.y < LIMIT_PLAYER_OFFSET_POINT_Y) {
        screenoffsetPoint.y-= move.y ;
        
        if ( screenoffsetPoint.y >= IMG_MAP_SIZE ){
            screenStartXYPoint.y -= 1 ;
            screenoffsetPoint.y -= IMG_MAP_SIZE ;
            screenStartXYPoint = [[MapData class] dataFormal:screenStartXYPoint] ;
        } else if ( screenoffsetPoint.y <= (IMG_MAP_SIZE * -1 )){
            screenStartXYPoint.y += 1 ;
            screenoffsetPoint.y += IMG_MAP_SIZE ;
            screenStartXYPoint = [[MapData class] dataFormal:screenStartXYPoint] ;
        }
    } else {
        playerMove.y       += move.y ;
        roleScreenPoint.y  += move.y ;
    }
    
    [ usrPlayer doMove:playerMove] ;
    
}


- (void) draw {
    // TODO 人物目前，在哪個座標，這個狀況好像要微調一下，不然位置怪怪的
    NSLog(@"User Location Point X :%d Y:%d", (int)roleXYPoint.x, (int)roleXYPoint.y ) ;
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 要從 -1 開始畫，不然假如畫面是剛剛好 0,0 位置就是剛剛好切其螢幕最左邊，接下來往左偏移會無法預先先畫
    for( int i = -1 ; i < SCREEN_HIGHT_NUM ; i++ ){
        for (int j = -1 ; j < SCREEN_WIDTH_NUM ; j++ ) {
             /*to draw map idea!!! center start
             1. 資料結構 抓到中間那格的地層陣列的位置 //  example : (5,3)
             2. 取得該格 之 背景地圖 繪製於  視窗內的中心 pixal 點, 可由 解析度除以２ 取得
             3. 之後在 取得 ( 4,3) 將中心pixal 減 32 不斷畫到超越 邊框 為止 , 上下左右依此類推
             完成地圖
            */
#ifdef DEBUG
            CGPoint data = CGPointMake(screenStartXYPoint.x+i, screenStartXYPoint.y+j);
            data = [[MapData class] dataFormal:data] ;
            
            CGRect redRect = CGRectMake((i)*IMG_MAP_SIZE+screenoffsetPoint.x,
                                        (j)*IMG_MAP_SIZE+screenoffsetPoint.y,
                                        IMG_MAP_SIZE ,
                                        IMG_MAP_SIZE) ;
            
            
            CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
            //设置画笔颜色：黑色
            CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
            //设置画笔线条粗细
            CGContextSetLineWidth(ctx, 1.0);
            //填充矩形
            CGContextFillRect(ctx, redRect);
            //画矩形边框
            CGContextAddRect(ctx,redRect);
            //执行绘画
            CGContextStrokePath(ctx);
#endif
            // [[Block class] draw:(i%BLOCK_METERIAL_LENGTH) offsetX:i*BLOCK_METERIAL_SIZE offsetY:j*BLOCK_METERIAL_SIZE  ] ;
            [[groundImages objectAtIndex:backGround[(int)data.x][(int)data.y]]
                                         drawAtPoint:CGPointMake(i*IMG_MAP_SIZE+screenoffsetPoint.x,j*IMG_MAP_SIZE+screenoffsetPoint.y)]  ;
            
            NSString * text = [NSString stringWithFormat:@"%d,%d", (int)data.x, (int)data.y  ] ;
            [[Kernel class] drawText:text offsetWidth:(i)*IMG_MAP_SIZE+screenoffsetPoint.x offsetHeight:(j)*IMG_MAP_SIZE+screenoffsetPoint.y textSize:10] ;
        }
    }
}

+ (void) initialDSGroung ; {
    for ( int i = 0 ; i < MAP_HIGHT_NUM ; i++ ) {
        for ( int j = 0 ; j < MAP_WIDTH_NUM ; j ++ ) {
            DSGround [i][j] = [[ Square alloc] init ] ;
            [DSGround [i][j] initalLacation:i :j ] ;
        }
    }

}

@end
