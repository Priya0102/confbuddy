//
//  Session_itherm.h
//  ITherm
//
//  Created by Anveshak on 1/16/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Session_itherm :NSObject

@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *start_time;
@property (strong,nonatomic) NSString *end_time;
@property (strong,nonatomic) NSString *track_name;
@property (strong,nonatomic) NSString *session_name;
@property (strong,nonatomic) NSString *room_name;
@property (strong,nonatomic) NSString *session_id;
@property (strong,nonatomic) NSString *day;

@property (strong,nonatomic) NSMutableArray *papers;

@property (strong,nonatomic) NSString *program_type_id;
@property (strong,nonatomic) NSString *category;
@property(nonatomic,retain)NSString *paper_details_cnt,*user_paper_cnt;
@property (strong,nonatomic) NSString *time_falg,*line_flag,*line_lbl,*line_down,*remaining;
@end
