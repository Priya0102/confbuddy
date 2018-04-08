
#import <UIKit/UIKit.h>
#import "Notify.h"
#import "NotificationsTableViewCell.h"
@interface NotificationsViewController : UIViewController <NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NSURLSessionDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *send;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *allnotifications;

//@property (weak, nonatomic) IBOutlet UITextField *desc;
@property (strong, nonatomic) IBOutlet UITextView *desc;
@property(nonatomic,retain)NSString *tempname,*tempdesc,*tempdate,*temptime,*tempnotify_id,*success;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;


@end
