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

@interface MapData : NSObject <BombEvent, Square_call_MapData > {
@private
    CGPoint offsetPoint ;
}
/* TODO  以下四個loca vairiable luoboy認為 應該存在player class 裡面
         但是目前先放在這邊 之後 下一版再修進去
*/

@property (nonatomic) CGPoint screenoffsetPoint    ;  // 螢幕畫的時候要位移多少
@property (nonatomic) CGPoint screenStartXYPoint   ;  // 螢幕最左上角的位置

@property (nonatomic) CGPoint roleScreenPoint      ;  // 玩家螢幕的位置  ex: (100,300)
@property (nonatomic) CGPoint roleXYPoint          ;  // 玩家腳底下的位置 ex: (3,4)

@property (nonatomic) Player * usrPlayer           ;  // 使用者自己


@property (nonatomic) NSMutableArray *  mapDataStruct ;



+ (void) initialImage    ;

- (void) initialmapData ;
- (MapData *) initWithUsr:(Player *)usr  mapPoint:  (CGPoint)startMapPoint startScreen:(CGPoint)startScreenPoint ;


- (void) draw ;
- (void) doMove:(CGPoint) move ;
- (void) putBomb ;
- (void) putBlock ;



@end
