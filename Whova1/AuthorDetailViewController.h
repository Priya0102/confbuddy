

#import <UIKit/UIKit.h>
#import "AuthordetailTableViewCell.h"
#import "Paper_author.h"
#import <QuartzCore/QuartzCore.h>
@interface AuthorDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate,NSURLSessionDelegate,UITextViewDelegate>
{
   // NSMutableIndexSet *expandedSections;
    NSInteger b;
}
@property (strong, nonatomic) IBOutlet UIButton *viewMapBtn;
@property (strong, nonatomic) IBOutlet UIButton *postBtn;

@property (strong, nonatomic) IBOutlet UILabel *addSchLbl;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnImg;
@property (strong, nonatomic) IBOutlet UILabel *likeLbl;

@property (weak, nonatomic) IBOutlet UILabel *papername;

@property (weak, nonatomic) IBOutlet UILabel *paper_id;
@property (strong,nonatomic) NSString *paper,*paperidstr,*success,*message,*sessionidStr,*liked,*added;

@property (strong, nonatomic) IBOutlet UILabel *starttime;
@property (strong, nonatomic) IBOutlet UILabel *endtime;
@property (strong,nonatomic) NSMutableArray *session;
@property (strong,nonatomic) NSArray *name_author;
@property (strong,nonatomic) NSArray *company_author;
@property (strong,nonatomic) NSArray *email_author;
@property (strong,nonatomic) NSArray *phone_author;
@property (strong,nonatomic) NSArray *speaker;

@property (strong,nonatomic) NSArray *authors;
@property (weak, nonatomic) IBOutlet UILabel *sessionname;
@property (weak, nonatomic) IBOutlet UILabel *sessionid;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *paper_abstract;
@property (weak, nonatomic) IBOutlet UIButton *btnRead;

@property(nonatomic,retain)NSString *tempSessionName,*abstractstr,*locationstr,*starttimestr,*endtimestr,*authoridstr;
@property (weak, nonatomic) IBOutlet UILabel *location;


@property (strong, nonatomic) IBOutlet UIButton *seemoreOutlet;

@property (strong, nonatomic) IBOutlet UILabel *count_like;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;
@property (strong, nonatomic) IBOutlet UITextField *comments;

@property (strong,nonatomic) NSMutableArray *commentarray,*imgarr,*usernamearr,*commentarr,*datearr,*authornamearr,*affilitionarr,*authorinfoarr,*authoridarr,*salutionarr,*paperidarr,*firstnamearr,*lastnamearr;

@property(nonatomic,retain)NSString *tempsession_id,*tempcomment,*temppaperid;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (strong, nonatomic) IBOutlet UITableView *tableview2;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleLargeBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;

@property (strong, nonatomic) IBOutlet UIView *view1;


@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
