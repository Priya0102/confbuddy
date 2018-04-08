//
//  Talk.h
//  ITherm
//
//  Created by Anveshak on 5/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Talk : NSObject
@property(nonatomic,retain)NSString *nameStr,*talkid,*talkName,*sessionName,*sessionidstr,*abstract,*talkUniversity,*speakerName,*speakerUni,*location;

@property (strong,nonatomic) NSString *start_time,*date,*day;
@property (strong,nonatomic) NSString *added;
@end
