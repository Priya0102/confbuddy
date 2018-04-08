

#import <UIKit/UIKit.h>

@interface NotificationsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *notification;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *notify_time;
@property (weak, nonatomic) IBOutlet UILabel *notify_id;
@property (strong, nonatomic) IBOutlet UIView *view;
@end
