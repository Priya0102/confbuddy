//
//  SessionModel.h
//  ITherm
//
//  Created by Anveshak on 2/27/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session_itherm.h"
@interface SessionModel : NSObject


@property(strong,nonatomic) NSString *headerText;

//@property (strong,nonatomic) Session_itherm *agendaInfo;

@property(strong,nonatomic)NSMutableArray *sessionArray;


@end
