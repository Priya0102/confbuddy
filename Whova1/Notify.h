

#import <Foundation/Foundation.h>

@interface Notify : NSObject
@property (strong,nonatomic) NSString *notification_name;
//@property (strong,nonatomic) NSString *notification_id;
//@property int notification_id;
@property(strong,nonatomic) NSString *date;
@property(strong,nonatomic) NSString *notify_time,*notify_id;

@property(strong,nonatomic) NSString *notify_description,*read,*unread_count;

@end
