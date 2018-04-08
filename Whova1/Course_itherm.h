
//  Course_itherm.h
//  ITherm
//
//  Created by Anveshak on 6/1/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "Session_itherm.h"

@interface Course_itherm : Session_itherm
    @property (strong,nonatomic) NSString *coursename,*courseabstract;
    @property (strong,nonatomic) NSString *course_id,*added,*course_no;

    @property (strong,nonatomic) NSMutableArray *leader;
@end
