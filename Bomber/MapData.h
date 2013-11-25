//
//  MapData.h
//  Bomber
//
//  Created by dream on 11/19/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bomber.h"
#import "Player.h"
#import "Square.h"

#define IMG_MAP_SIZE 32

#define SCREEN_WIDTH_NUM SCREEN_WIDTH / IMG_MAP_SIZE + 2
#define SCREEN_HIGHT_NUM SCREEN_HIGHT / IMG_MAP_SIZE + 2

#define MAP_WIDTH_NUM 50
#define MAP_HIGHT_NUM 50

#define IMG_MAP_OFFSET_WIDTH 32
#define IMG_MAP_OFFSET_HIGHT 40

@interface MapData : NSObject{
@private
    CGPoint offsetPoint ;
}

@property (nonatomic) CGPoint screenoffsetPoint    ;  // 螢幕畫的時候要位移多少
@property (nonatomic) CGPoint screenStartXYPoint   ;  // 螢幕最左上角的位置

@property (nonatomic) CGPoint roleScreenPoint      ;  // 玩家螢幕的位置  ex: (100,300)
@property (nonatomic) CGPoint roleXYPoint          ;  // 玩家腳底下的位置 ex: (3,4)

@property (nonatomic) Player * usrPlayer           ;  // 使用者自己

/* TODO 以前作法是，把炸彈都收集到這，在到時候要畫在畫
   但是現在炸彈是由，地圖上顯示的而不是，看炸彈的螢幕上位置才畫
   所以要在思考怎實作
   
   假如 
     1. 炸彈本身已經爆炸了，這個事情可以回報給 mapData
     2. 炸彈 kill 要回收
   能做到的話就不需要這個東西
*/
@property (nonatomic) NSMutableArray * bombCollect ;  // 收集炸彈用 ..

+ (void) initialDSGroung ;
+ (void) initialImage    ;
+ (Square *) getDSGround : (int) x : (int) y ;

- (MapData *) initWithUsr:(Player *)usr mapPoint:(CGPoint)startMapPoint startScreen:(CGPoint)startScreenPoint ;

- (void) draw ;
- (void) doMove:(CGPoint) move ;
- (void) putBomb ;

@end
