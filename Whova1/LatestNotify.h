//
//  LatestNotify.h
//  ITherm
//
//  Created by Anveshak on 2/28/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestNotify : NSObject
@property (strong,nonatomic) NSString *notification_name;
@property (strong,nonatomic) NSString *notification_id;
//@property int notification_id;
@property(strong,nonatomic) NSString *date;
@property(strong,nonatomic) NSString *notify_time,*notify_id;

@property(strong,nonatomic) NSString *notify_description,*read,*unread_count;
@end
