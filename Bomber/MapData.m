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


@synthesize mapDataStruct ;

#define SPEED 20

int backGround[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;
int objGround[MAP_HIGHT_NUM][MAP_WIDTH_NUM] ;



+ (CGPoint) dataFormal:(CGPoint) data {
    if ( data.x >= MAP_HIGHT_NUM ) data.x -= ( MAP_HIGHT_NUM ) ;
    if ( data.x < 0 )              data.x += ( MAP_HIGHT_NUM ) ;
    
    if ( data.y >= MAP_WIDTH_NUM ) data.y -= ( MAP_WIDTH_NUM ) ;
    if ( data.y < 0 )              data.y += ( MAP_WIDTH_NUM ) ;
    assert( data.x < MAP_HIGHT_NUM && data.x >= 0 ) ;
    assert( data.y < MAP_WIDTH_NUM && data.y >= 0 ) ;
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

-(void) initialmapData {
    mapDataStruct = [ NSMutableArray arrayWithCapacity:MAP_WIDTH_NUM] ;
    
    for ( int i = 0 ; i < MAP_WIDTH_NUM ; i++ ) {
        [mapDataStruct addObject: [ NSMutableArray arrayWithCapacity:MAP_HIGHT_NUM]] ;
        for ( int j = 0 ; j < MAP_HIGHT_NUM ; j++ ) {
            Square * temp = [[ Square alloc ] init] ;
            [temp setDelegate: self ] ;
            [ temp initalLacation :i :j ] ;
            [[ mapDataStruct objectAtIndex:i] addObject: temp ] ;
        } // for
    }  // for
}



- (MapData *) initWithUsr:(Player *)usr mapPoint:(CGPoint)startMapPoint startScreen:(CGPoint)startScreenPoint{
    self = [super init] ;
  
    [ self initialmapData] ;
    roleScreenPoint = startScreenPoint ;
    roleXYPoint     = startMapPoint    ;
    usrPlayer       = usr ;
    [[[mapDataStruct objectAtIndex:roleXYPoint.x] objectAtIndex:roleXYPoint.y] peopleInSquare:usrPlayer ];
    
    screenStartXYPoint = CGPointMake(roleXYPoint.x - (( (int)roleScreenPoint.x / IMG_MAP_SIZE ) + 1 ) ,
                                     roleXYPoint.y - (( (int)roleScreenPoint.y / IMG_MAP_SIZE ) + 1 ) ) ;
    
    //  FIMEX +3  +9 是為了計算角色稍微篇移多少比較像在格子中 未來一定還要修改
    //screenoffsetPoint  = CGPointMake( ((int)roleScreenPoint.x % IMG_MAP_SIZE ) - IMG_MAP_SIZE + 3,
    //                                  ((int)roleScreenPoint.y % IMG_MAP_SIZE ) - IMG_MAP_SIZE + 9) ;
    screenoffsetPoint  = CGPointMake( ((int)roleScreenPoint.x % IMG_MAP_SIZE ) - IMG_MAP_SIZE + 3,
                                     ((int)roleScreenPoint.y % IMG_MAP_SIZE ) - IMG_MAP_SIZE + 9) ;
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
    
    CGPoint recentPoint = roleXYPoint ;
    bool isMoveTonotherSquare = false ;
    bool domove = false ;
    
    if ( shiftMove.x >= IMG_MAP_SIZE ){
        roleXYPoint.x += 1 ;
        domove = true ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
        if ( [[[mapDataStruct objectAtIndex:roleXYPoint.x] objectAtIndex:roleXYPoint.y] canIn]) {
             shiftMove.x -= IMG_MAP_SIZE ;
          isMoveTonotherSquare = true ;
        } // if
        else {
             roleXYPoint = recentPoint  ;
        } //else
    } else if ( shiftMove.x <= (IMG_MAP_SIZE * -1 )){
        roleXYPoint.x -= 1 ;
        domove = true ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
        if ( [[[mapDataStruct objectAtIndex:roleXYPoint.x] objectAtIndex:roleXYPoint.y] canIn] ) {
             shiftMove.x += IMG_MAP_SIZE ;
            isMoveTonotherSquare = true ;
        } // if
        else {
            roleXYPoint = recentPoint  ;
        } //else
    }
    
    if ( shiftMove.y >= IMG_MAP_SIZE ){
        roleXYPoint.y += 1 ;
        domove = true ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
        if ( [[[mapDataStruct objectAtIndex:roleXYPoint.x] objectAtIndex:roleXYPoint.y] canIn] ) {
            shiftMove.y -= IMG_MAP_SIZE ;
            isMoveTonotherSquare = true ;
        } // if
        else {
            roleXYPoint = recentPoint  ;
        } //else
    } else if ( shiftMove.y <= (IMG_MAP_SIZE * -1 )){
        roleXYPoint.y -= 1 ;
        domove = true ;
        roleXYPoint = [[MapData class] dataFormal:roleXYPoint] ;
        if ( [[[mapDataStruct objectAtIndex:roleXYPoint.x] objectAtIndex:roleXYPoint.y] canIn] ) {
             shiftMove.y += IMG_MAP_SIZE ;
            isMoveTonotherSquare = true ;
        } // if
        else {
            roleXYPoint = recentPoint  ;
        } //else
    }
    if ( isMoveTonotherSquare ) {
      [[[mapDataStruct objectAtIndex:roleXYPoint.x] objectAtIndex:roleXYPoint.y] peopleInSquare:usrPlayer ];
      [[[mapDataStruct objectAtIndex:recentPoint.x] objectAtIndex:recentPoint.y] peopleleaveSquare ] ;
        NSLog(@"pass") ;
    } // if
    
    if ( domove && !isMoveTonotherSquare ){
        NSLog(@"here") ;
      
        
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
    //NSLog(@"User Location Point X :%d Y:%d", (int)roleXYPoint.x, (int)roleXYPoint.y ) ;
    
    
    
    // 要從 -1 開始畫，不然假如畫面是剛剛好 0,0 位置就是剛剛好切其螢幕最左邊，接下來往左偏移會無法預先先畫
    for( int i = -1 ; i < SCREEN_HIGHT_NUM ; i++ ){
        for (int j = -1 ; j < SCREEN_WIDTH_NUM ; j++ ) {
             /*to draw map idea!!! center start
             1. 資料結構 抓到中間那格的地層陣列的位置 //  example : (5,3)
             2. 取得該格 之 背景地圖 繪製於  視窗內的中心 pixal 點, 可由 解析度除以２ 取得
             3. 之後在 取得 ( 4,3) 將中心pixal 減 32 不斷畫到超越 邊框 為止 , 上下左右依此類推
             完成地圖
            */
            
            
            CGPoint data = CGPointMake(screenStartXYPoint.x+i, screenStartXYPoint.y+j);
            data = [[MapData class] dataFormal:data] ;
            
            // 每隔的背景
           [[groundImages objectAtIndex:backGround[(int)data.x][(int)data.y]]
             drawAtPoint:CGPointMake(i*IMG_MAP_SIZE+screenoffsetPoint.x,j*IMG_MAP_SIZE+screenoffsetPoint.y)]  ;
#ifdef DEBUG
            
            // 畫最外層框框
   /*     [[Kernel class] drawGrid:CGRectMake((i)*IMG_MAP_SIZE+screenoffsetPoint.x,
                                                (j)*IMG_MAP_SIZE+screenoffsetPoint.y,
                                                IMG_MAP_SIZE ,
                                                IMG_MAP_SIZE)  lineWidth:1.0] ;
            
            // 這格名稱
            NSString * text = [NSString stringWithFormat:@"%d,%d", (int)data.x, (int)data.y  ] ;
            [[Kernel class] drawText:text offsetWidth:(i)*IMG_MAP_SIZE+screenoffsetPoint.x offsetHeight:(j)*IMG_MAP_SIZE+screenoffsetPoint.y textSize:10] ;*/
#endif
             
            
            /* TODO 把每隔資訊畫上去
               例如這格式炸彈，或者是磚塊
               example idea :
               DSGround[(int)data.x][(int)data.y].draw() ;
             */
        
            Square * tempSquare = [[ mapDataStruct objectAtIndex: (int)data.x ] objectAtIndex: (int)data.y ] ;
            
            if ( [tempSquare exsitObj] == BOMB ) {
                [[tempSquare bomb] draw:i*IMG_MAP_SIZE+screenoffsetPoint.x :j*IMG_MAP_SIZE+screenoffsetPoint.y] ;
            }
 
            if ( [tempSquare fireType] != NOTHING ) {
                [[Bomb class ] drawFire:[tempSquare fireType] :i*IMG_MAP_SIZE+screenoffsetPoint.x :j*IMG_MAP_SIZE+screenoffsetPoint.y] ;
                tempSquare.fireType= NOTHING ;
            }
        }
    }
}


- (void) putBomb {
    // TODO 把炸彈放到 底下資料
    /* example idea : 
       roelXYPoint -> 玩家腳底下 位置 ex : (3,4)
       1. DSGround[ (int)roleXYPoint.x ][ (int)roleXYPoint.y ]  是可以放炸彈
       2. usrPlayer 可以放炸彈 { isHaveBomb }
       3. if usrPlayer.isHaveBomb :
             if usrPlayer.putBomb :
               // It's OK putBomb 
               // DSGround[ (int) roleXYPoint.x)][ (int) roleXYPoint.y] = SET_BOMB ; ??
     */
    
    
    Square * tempSquare = [[ mapDataStruct objectAtIndex:roleXYPoint.x] objectAtIndex:roleXYPoint.y ] ;
   if ( tempSquare.canPutBomb ) {
     if ( usrPlayer.bombNum > 0 ) {
         
         
          tempSquare.canPutBomb = false ;
          Bomb * bomb = [[ Bomb class ] putBomb:roleXYPoint : 0 : usrPlayer.fire  ] ;
          [bomb setBombEvent:self] ;
          [tempSquare putThingInSquare:BOMB PutObject: bomb ] ;
          [usrPlayer putBomb ] ;
          
      } // if
    } // if
    
}

-(void) putBlock : (int) x : (int) y {
    
    
    
}

// implement BomEvent


-(void) reflashMapData: (int)fireCloumn : (CGPoint) bombLoc {
    NSLog(@"%f,%f",bombLoc.x,bombLoc.y);
    int top = bombLoc.y-1, down= bombLoc.y+1, left = bombLoc.x-1, right = bombLoc.x+1;
    
    Square * tempSquare = [[ mapDataStruct objectAtIndex: bombLoc.x] objectAtIndex:bombLoc.y]  ;
    [tempSquare removeThingFromSquare : CENTER ] ;
    for ( int i = 0 ; i < fireCloumn ; i++, top = top-1, down = down+1, left = left-1, right = right+1 ) {
      if ( top < 0 ) top += 50 ;
      if ( down >= 50 ) down -= 50 ;
      if ( left < 0 ) left += 50 ;
      if ( right >= 50 ) right -= 50 ;
        
        [[[ mapDataStruct objectAtIndex: bombLoc.x ] objectAtIndex:top] removeThingFromSquare : VERTICAL] ;
        [[[ mapDataStruct objectAtIndex: bombLoc.x ] objectAtIndex:down] removeThingFromSquare : VERTICAL] ;
        [[[ mapDataStruct objectAtIndex: left] objectAtIndex:bombLoc.y] removeThingFromSquare : HORIZON] ;
        [[[ mapDataStruct objectAtIndex: right] objectAtIndex:bombLoc.y] removeThingFromSquare : HORIZON] ;
    } // for
    
      
    
    
    [usrPlayer addBombNum];
    
}

// implement callback

-(void) resetPlayerLoc {

    [ usrPlayer resetLocation: CGPointMake(rand()%45,rand()%45) ] ;
    roleXYPoint = usrPlayer.dataLoc ;
    screenStartXYPoint = CGPointMake(roleXYPoint.x - (( (int)roleScreenPoint.x / IMG_MAP_SIZE ) + 1 ) ,
                                     roleXYPoint.y - (( (int)roleScreenPoint.y / IMG_MAP_SIZE ) + 1 ) ) ;
    
    //  FIMEX +3  +9 是為了計算角色稍微篇移多少比較像在格子中 未來一定還要修改
    screenoffsetPoint  = CGPointMake(((int)roleScreenPoint.x % IMG_MAP_SIZE ) - IMG_MAP_SIZE + 3,
                                     ((int)roleScreenPoint.y % IMG_MAP_SIZE ) - IMG_MAP_SIZE + 9) ;
    
}



@end
