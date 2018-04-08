
#import <UIKit/UIKit.h>
#import "PaperTableViewCell.h"
#import "Session_itherm.h"
#import "Paper_itherm.h"
#import "Paper_author.h"
#import "AuthorDetailViewController.h"
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <QuartzCore/QuartzCore.h>

@interface SessionViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
;
@property (weak, nonatomic) IBOutlet UILabel *comm;
@property (weak, nonatomic) IBOutlet UILabel *ttitle1;
@property (strong, nonatomic) IBOutlet UIButton *viewMapBtn;


@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *result;


@property (strong,nonatomic) NSArray *papers;

@property (strong,nonatomic) NSMutableArray *all_papers,*user_papers;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLbl;

@property (weak, nonatomic) IBOutlet UILabel *loca;

@property (weak, nonatomic) IBOutlet UILabel *session_name;

@property (strong,nonatomic) Session_itherm *sess;
@property(nonatomic,retain)NSOperationQueue *que;
@property (strong,nonatomic) Paper_itherm *pi;
@property (strong,nonatomic) NSMutableArray *paper_id;
@property (strong,nonatomic) NSMutableArray *paper_name,*added;
@property (strong,nonatomic) NSMutableArray *all_authors;
@property (strong,nonatomic) NSMutableArray *paper_abstract,*paperArr;

@property(nonatomic,retain)NSString *temp_session_id;

@property(nonatomic,retain)NSString *stimestr,*etimestr,*locationstr,*datestr,*sessionstr,*abstractstr,*tempabst;

@property (weak, nonatomic) IBOutlet UILabel *line;


- (IBAction)alramButtonClick:(id)sender;
//-(void)paperParsing;
@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (weak, nonatomic) IBOutlet UIImageView *setImage;

@property(nonatomic,retain)NSMutableArray *tickarray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
