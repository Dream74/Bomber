//
//  Resource.m
//  Bomber
//
//  Created by luoboy on 13/11/21.
//  Copyright (c) 2013年 CYCU. All rights reserved.
//

#import "Resource.h"

@implementation Resource

static  UIImage *  bomb_32x32_2 ;
static  UIImage *  bomb_32x32_2 ;
static  UIImage *  blast ;
static  UIImage *  character_crawling ;
static  UIImage *  character_flying ;
static  UIImage *  character_gold ;
static  UIImage *  character_jetpack ;
static  UIImage *  character_silver ;
static  UIImage *  explosion ;
static  UIImage *  items ;
static  UIImage *  perks ;
static  UIImage *  tileset ;
static  UIImage *  tileset_12_31 ;
static  UIImage *  mario_rpg ;

+ (void) initalResource {
        
    bomb_32x32_2       = [UIImage imageNamed:@"bomb_32x32_2.png"]       ;
    blast              = [UIImage imageNamed:@"blast.png"]              ;
    character_crawling = [UIImage imageNamed:@"character_crawling.png"] ;
    character_flying   = [UIImage imageNamed:@"character_flying.png"]   ;
    character_gold     = [UIImage imageNamed:@"character_gold.png"]     ;
    character_jetpack  = [UIImage imageNamed:@"character_jetpack .png"] ;
    character_silver   = [UIImage imageNamed:@"character_silver.png"]   ;
    explosion          = [UIImage imageNamed:@"explosion.png"]          ;
    items              = [UIImage imageNamed:@"items.png"]              ;
    perks              = [UIImage imageNamed:@"perks.png"]              ;
    tileset            = [UIImage imageNamed:@"tileset.png"]            ;
    tileset_12_31      = [UIImage imageNamed:@"tileset_12_31.png"]      ;
    mario_rpg          = [UIImage imageNamed:@"mario_rpg.png" ]         ;
   
}

// return static Variable
+  (UIImage *)  bomb_32x32_2 { return bomb_32x32_2; }
+  (UIImage *)  blast { return blast; }
+  (UIImage *)  character_crawling {return character_crawling ; }
+  (UIImage *)  character_flying {return character_flying; }
+  (UIImage *)  character_gold { return character_gold; }
+  (UIImage *)  character_jetpack { return character_jetpack; }
+  (UIImage *)  character_silver { return character_silver; }
+  (UIImage *)  explosion { return explosion; }
+  (UIImage *)  items { return explosion; }
+  (UIImage *)  perks { return perks; }
+  (UIImage *)  tileset { return tileset; }
+  (UIImage *)  tileset_12_31 { return tileset_12_31; }
+  (UIImage *)  mario_rpg { return mario_rpg ; }


@end
