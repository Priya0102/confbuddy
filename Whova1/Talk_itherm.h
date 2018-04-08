//
//  Talk_itherm.h
//  ITherm
//
//  Created by Anveshak on 1/25/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "Session_itherm.h"

@interface Talk_itherm : Session_itherm
@property(nonatomic,retain)NSString *nameStr,*talkid,*talkName,*sessionName,*sessionidstr,*abstract,*talkUniversity,*speakerName,*speakerUni,*location;

//@property (strong,nonatomic) NSString *start_time,*date,*day;
@property (strong,nonatomic) NSString *added;

@end
