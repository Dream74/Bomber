//
//  Server.m
//  Bomber
//
//  Created by dream on 12/12/13.
//  Copyright (c) 2013 CYCU. All rights reserved.
//

#import "Server.h"

#define kFirechatNS @"https://bomber.firebaseio.com/"

@implementation Server


static Firebase* firebase;

+ (void) initalServer {
    firebase = [[Firebase alloc] initWithUrl:kFirechatNS];
}

/* example
 [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
 // NSLog(@"%@ -> %@", snapshot.name, snapshot.value[@"player0"][@"piece"][@"y"]);
 }];
 
 [[self.firebase childByAppendingPath:@"/Player"] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
 NSLog(@"childByAppendingPath Player :%@ %@", snapshot.name, snapshot.value ) ;
 }];
 
 [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
 NSLog(@"FEventTypeChildAdded Name :%@ %@", snapshot.name, snapshot.value ) ;
 
 }];
 
 
 [self.firebase observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
 NSLog(@"FEventTypeChildChanged Name :%@ %@", snapshot.name, snapshot.value ) ;
 //        NSLog(@"Chance :%@", snapshot.value[@"piece"][@"y"]);
 }];
 
 
 [self.firebase observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
 NSLog(@"FEventTypeChildRemoved Name :%@ %@", snapshot.name, snapshot.value ) ;
 // NSString* text = snapshot.value[@"text"];
 // NSString* name = snapshot.value[@"name"];
 // NSLog(@"FEventTypeChildRemoved User Name :%@ Text :%@", name, text);
 }];
 
 */


@end
