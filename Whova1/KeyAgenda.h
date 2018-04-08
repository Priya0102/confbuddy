//
//  KeyAgenda.h
//  ITherm
//
//  Created by Anveshak on 12/1/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyAgenda : NSObject

@property (strong,nonatomic) NSString *comments;
@property (strong,nonatomic) NSString *comment_id;

@property(strong,nonatomic) NSString *date1;
@property(strong,nonatomic) NSString *comment_time;

@property(strong,nonatomic) NSString *name,*img;
@property(strong,nonatomic) NSString *read;
@property(strong,nonatomic) NSString *unread_count;
@end
